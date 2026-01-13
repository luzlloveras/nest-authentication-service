# Authentication Service

A complete, production-ready authentication service built with NestJS, featuring user registration, JWT authentication, refresh tokens, password validation, and SQLite database integration.

## 🚀 Features

- ✅ **User Registration** - Secure user registration with password validation
- ✅ **JWT Authentication** - Access tokens with configurable expiration
- ✅ **Refresh Tokens** - Long-lived refresh tokens for seamless token renewal
- ✅ **Password Security** - Bcrypt hashing with robust password validation
- ✅ **Database Integration** - SQLite with TypeORM for data persistence
- ✅ **Protected Routes** - JWT guards for route protection
- ✅ **User Management** - Support for multiple users
- ✅ **Session Management** - Logout with token invalidation
- ✅ **Input Validation** - Class-validator for request validation

## 📋 Prerequisites

- Node.js (v18 or higher)
- npm or yarn
- TypeScript knowledge (helpful but not required)

## 🛠️ Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd nest-authentication-service
```

2. Install dependencies:
```bash
npm install
```

3. Set up environment variables:
```bash
cp env.example .env
```

4. Edit `.env` file and configure your secrets:
```env
# JWT Configuration
JWT_SECRET=your-super-secret-jwt-key-change-this-in-production-min-32-chars
JWT_REFRESH_SECRET=your-super-secret-refresh-token-key-change-this-in-production-min-32-chars
JWT_EXPIRES_IN=15m
JWT_REFRESH_EXPIRES_IN=7d

# Database Configuration
DB_PATH=database.sqlite

# Server Configuration
PORT=3000

# Application Environment
NODE_ENV=development
```

**Important:** 
- Use strong, random secrets (minimum 32 characters recommended)
- Never commit `.env` file to version control
- Use different secrets for production

## 🏃 Running the Application

### Development Mode
```bash
npm run start:dev
```

The server will start on `http://localhost:3000` with hot-reload enabled.

### Production Mode
```bash
npm run build
npm run start:prod
```

### Other Commands
```bash
# Format code
npm run format

# Lint code
npm run lint

# Run tests
npm run test

# Run e2e tests
npm run test:e2e

# Test coverage
npm run test:cov
```

## 📚 API Endpoints

### Base URL
```
http://localhost:3000
```

### 1. Register User
Register a new user account.

**Endpoint:** `POST /auth/register`

**Request Body:**
```json
{
  "username": "johndoe",
  "password": "SecurePass123!"
}
```

**Password Requirements:**
- Minimum 8 characters
- At least one uppercase letter
- At least one lowercase letter
- At least one number
- At least one special character (@$!%*?&)

**Success Response (201):**
```json
{
  "id": 1,
  "username": "johndoe",
  "createdAt": "2024-01-13T20:15:43.000Z",
  "updatedAt": "2024-01-13T20:15:43.000Z"
}
```

**Error Responses:**
- `400` - Validation error (invalid password format, username too short, etc.)
- `409` - Username already exists

---

### 2. Login
Authenticate user and receive JWT tokens.

**Endpoint:** `POST /auth/login`

**Request Body:**
```json
{
  "username": "johndoe",
  "password": "SecurePass123!"
}
```

**Success Response (200):**
```json
{
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": 1,
    "username": "johndoe"
  }
}
```

**Token Expiration:**
- Access Token: 15 minutes (configurable via `JWT_EXPIRES_IN`)
- Refresh Token: 7 days (configurable via `JWT_REFRESH_EXPIRES_IN`)

**Error Responses:**
- `401` - Invalid credentials

---

### 3. Refresh Access Token
Renew access token using refresh token.

**Endpoint:** `POST /auth/refresh`

**Request Body:**
```json
{
  "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

**Success Response (200):**
```json
{
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

**Error Responses:**
- `401` - Invalid or expired refresh token

---

### 4. Get User Profile
Get authenticated user's profile information.

**Endpoint:** `GET /auth/profile`

**Headers:**
```
Authorization: Bearer <access_token>
```

**Success Response (200):**
```json
{
  "id": 1,
  "username": "johndoe",
  "createdAt": "2024-01-13T20:15:43.000Z",
  "updatedAt": "2024-01-13T20:15:43.000Z"
}
```

**Error Responses:**
- `401` - Missing or invalid access token

---

### 5. Logout
Invalidate refresh token and log out user.

**Endpoint:** `POST /auth/logout`

**Headers:**
```
Authorization: Bearer <access_token>
```

**Success Response (200):**
```json
{
  "message": "Logged out successfully"
}
```

**Error Responses:**
- `401` - Missing or invalid access token

---

## 🧪 Testing

### Automated Testing Script
Run the comprehensive test script:
```bash
./test-api.sh
```

This script will:
1. Register a new user
2. Test login and token generation
3. Test protected profile endpoint
4. Test refresh token functionality
5. Test logout functionality

### Manual Testing with cURL

**1. Register a user:**
```bash
curl -X POST http://localhost:3000/auth/register \
  -H "Content-Type: application/json" \
  -d '{"username":"testuser","password":"SecurePass123!"}'
```

**2. Login:**
```bash
curl -X POST http://localhost:3000/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"testuser","password":"SecurePass123!"}'
```

**3. Get profile (replace with your access token):**
```bash
curl http://localhost:3000/auth/profile \
  -H "Authorization: Bearer <your-access-token>"
```

**4. Refresh token:**
```bash
curl -X POST http://localhost:3000/auth/refresh \
  -H "Content-Type: application/json" \
  -d '{"refresh_token":"<your-refresh-token>"}'
```

**5. Logout:**
```bash
curl -X POST http://localhost:3000/auth/logout \
  -H "Authorization: Bearer <your-access-token>"
```

## 🏗️ Project Structure

```
src/
├── auth/                 # Authentication module
│   ├── auth.controller.ts    # Auth endpoints
│   ├── auth.module.ts        # Auth module configuration
│   ├── auth.service.ts       # Auth business logic
│   ├── jwt.strategy.ts       # JWT passport strategy
│   ├── jwt-auth.guard.ts      # JWT guard
│   ├── local.strategy.ts     # Local passport strategy
│   └── local-auth.guard.ts   # Local guard
├── users/               # Users module
│   ├── dto/                  # Data Transfer Objects
│   │   ├── login.dto.ts
│   │   └── register.dto.ts
│   ├── entities/             # Database entities
│   │   └── user.entity.ts
│   ├── users.module.ts       # Users module configuration
│   └── users.service.ts      # Users business logic
├── app.module.ts        # Root application module
└── main.ts              # Application entry point
```

## 🔒 Security Features

### Password Security
- **Bcrypt Hashing**: Passwords are hashed using bcrypt with 10 salt rounds
- **Strong Validation**: Enforces complex password requirements
- **No Plain Text Storage**: Passwords are never stored in plain text

### Token Security
- **JWT Signing**: Tokens are signed with secret keys
- **Expiration**: Short-lived access tokens (15 minutes)
- **Refresh Tokens**: Long-lived refresh tokens stored in database
- **Token Invalidation**: Refresh tokens can be invalidated on logout

### Input Validation
- **Class Validator**: Request validation using decorators
- **Type Safety**: TypeScript for type checking
- **SQL Injection Protection**: TypeORM parameterized queries

## 🗄️ Database

The application uses SQLite with TypeORM for simplicity and ease of development. The database file (`database.sqlite`) is automatically created on first run.

### User Entity Schema
```typescript
{
  id: number (Primary Key, Auto Increment)
  username: string (Unique)
  password: string (Hashed)
  refreshToken: string (Nullable)
  createdAt: Date
  updatedAt: Date
}
```

### Database Configuration
- **Type**: SQLite
- **Location**: `database.sqlite` (configurable via `DB_PATH`)
- **Synchronization**: Enabled in development, disabled in production

## 🔧 Configuration

### Environment Variables

| Variable | Description | Default | Required |
|----------|-------------|---------|----------|
| `JWT_SECRET` | Secret key for JWT signing | - | Yes |
| `JWT_REFRESH_SECRET` | Secret key for refresh tokens | `JWT_SECRET` | No |
| `JWT_EXPIRES_IN` | Access token expiration | `15m` | No |
| `JWT_REFRESH_EXPIRES_IN` | Refresh token expiration | `7d` | No |
| `DB_PATH` | SQLite database file path | `database.sqlite` | No |
| `PORT` | Server port | `3000` | No |
| `NODE_ENV` | Environment mode | `development` | No |

## 📦 Dependencies

### Core Dependencies
- `@nestjs/common` - NestJS common utilities
- `@nestjs/core` - NestJS core framework
- `@nestjs/config` - Configuration management
- `@nestjs/jwt` - JWT module
- `@nestjs/passport` - Passport integration
- `@nestjs/typeorm` - TypeORM integration
- `typeorm` - ORM for TypeScript
- `passport` - Authentication middleware
- `passport-jwt` - JWT strategy for Passport
- `passport-local` - Local strategy for Passport
- `bcrypt` - Password hashing
- `class-validator` - Validation decorators
- `class-transformer` - Object transformation
- `sqlite3` - SQLite database driver

## 🚦 Usage Examples

### Complete Authentication Flow

1. **Register a new user:**
```bash
POST /auth/register
{
  "username": "alice",
  "password": "MySecure123!"
}
```

2. **Login and get tokens:**
```bash
POST /auth/login
{
  "username": "alice",
  "password": "MySecure123!"
}
# Returns: access_token, refresh_token, user
```

3. **Access protected resource:**
```bash
GET /auth/profile
Headers: Authorization: Bearer <access_token>
```

4. **Refresh access token when expired:**
```bash
POST /auth/refresh
{
  "refresh_token": "<refresh_token>"
}
# Returns: new access_token
```

5. **Logout:**
```bash
POST /auth/logout
Headers: Authorization: Bearer <access_token>
```

## 🐛 Troubleshooting

### Common Issues

**1. "Cannot find module" errors**
- Run `npm install` to install all dependencies

**2. Database connection errors**
- Ensure SQLite is installed
- Check file permissions for database directory

**3. JWT validation errors**
- Verify `JWT_SECRET` is set in `.env`
- Ensure tokens are not expired
- Check token format in Authorization header

**4. Password validation fails**
- Ensure password meets all requirements:
  - Minimum 8 characters
  - Contains uppercase, lowercase, number, and special character

## 📝 License

This project is licensed under the UNLICENSED license.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📞 Support

For issues and questions, please open an issue on the repository.

---

**Built with ❤️ using NestJS**
