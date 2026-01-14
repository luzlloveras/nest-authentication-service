# NestJS Authentication Service

Authentication service with JWT tokens, refresh tokens, and user registration. Uses SQLite for storage.

## Features

- User registration with password validation
- JWT access tokens (15min expiration)
- Refresh tokens (7 days expiration)
- Protected routes with JWT guards
- Password hashing with bcrypt
- SQLite database with TypeORM

## Setup

### Install dependencies

```bash
npm install
```

### Configure environment

Copy `env.example` to `.env` and set your secrets:

```env
JWT_SECRET=your-secret-key-min-32-chars
JWT_REFRESH_SECRET=your-refresh-secret-key-min-32-chars
JWT_EXPIRES_IN=15m
JWT_REFRESH_EXPIRES_IN=7d
DB_PATH=database.sqlite
PORT=3000
NODE_ENV=development
CORS_ORIGIN=*
```

### Run

```bash
# Development
npm run start:dev

# Production
npm run build
npm run start:prod
```

## API Endpoints

Base URL: `http://localhost:3000`

### Register

```bash
POST /auth/register
Content-Type: application/json

{
  "username": "johndoe",
  "password": "SecurePass123!"
}
```

Password requirements:
- Minimum 8 characters
- At least one uppercase, lowercase, number, and special character (@$!%*?&)

### Login

```bash
POST /auth/login
Content-Type: application/json

{
  "username": "johndoe",
  "password": "SecurePass123!"
}
```

Returns:
```json
{
  "access_token": "...",
  "refresh_token": "...",
  "user": { "id": 1, "username": "johndoe" }
}
```

### Refresh Token

```bash
POST /auth/refresh
Content-Type: application/json

{
  "refresh_token": "..."
}
```

### Get Profile

```bash
GET /auth/profile
Authorization: Bearer <access_token>
```

### Logout

```bash
POST /auth/logout
Authorization: Bearer <access_token>
```

## API Documentation

Swagger UI available at `http://localhost:3000/api` when server is running.

## Project Structure

```
src/
├── auth/              # Authentication module
│   ├── auth.controller.ts
│   ├── auth.service.ts
│   ├── jwt.strategy.ts
│   ├── local.strategy.ts
│   └── *.guard.ts
├── users/             # Users module
│   ├── dto/           # Request DTOs
│   ├── entities/      # User entity
│   └── users.service.ts
├── common/            # Shared code
│   └── filters/       # Exception filters
└── main.ts            # App entry point
```

## Testing

Run the test script:

```bash
./test-api.sh
```

Or use curl:

```bash
# Register
curl -X POST http://localhost:3000/auth/register \
  -H "Content-Type: application/json" \
  -d '{"username":"testuser","password":"SecurePass123!"}'

# Login
curl -X POST http://localhost:3000/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"testuser","password":"SecurePass123!"}'
```

## Database

Uses SQLite with TypeORM. Database file is created automatically at `database.sqlite`.

User schema:
- `id` (primary key)
- `username` (unique)
- `password` (hashed)
- `refreshToken` (nullable)
- `createdAt`, `updatedAt`

## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `JWT_SECRET` | JWT signing secret | Required |
| `JWT_REFRESH_SECRET` | Refresh token secret | `JWT_SECRET` |
| `JWT_EXPIRES_IN` | Access token expiration | `15m` |
| `JWT_REFRESH_EXPIRES_IN` | Refresh token expiration | `7d` |
| `DB_PATH` | SQLite database path | `database.sqlite` |
| `PORT` | Server port | `3000` |
| `NODE_ENV` | Environment | `development` |
| `CORS_ORIGIN` | CORS origin | `*` |

## License

MIT
