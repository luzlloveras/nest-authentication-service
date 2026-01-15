# Architecture

## Project structure

```
src/
├── auth/              # Authentication module
│   ├── auth.controller.ts
│   ├── auth.service.ts
│   ├── jwt.strategy.ts
│   ├── local.strategy.ts
│   ├── jwt-auth.guard.ts
│   └── local-auth.guard.ts
├── users/             # Users module
│   ├── dto/           # Request DTOs
│   ├── entities/      # User entity
│   └── users.service.ts
├── common/            # Shared code
│   └── filters/       # Exception filters
├── app.module.ts
├── app.controller.ts
└── main.ts
```

## Modules

**AuthModule**: Handles authentication logic, JWT generation, login, register, refresh, logout.

**UsersModule**: Manages user CRUD operations and password validation.

## Authentication flow

1. User registers → password hashed with bcrypt
2. User logs in → credentials validated, JWT tokens generated
3. Access token used for protected routes (15min expiry)
4. Refresh token used to get new access token (7d expiry)
5. Logout invalidates refresh token

## Database

SQLite database with TypeORM. User entity stores hashed passwords and refresh tokens.
