# Configuration

Copy `env.example` to `.env` and set these:

## Required

- `JWT_SECRET` - Secret key for JWT signing (min 32 chars recommended)

## Optional

- `JWT_REFRESH_SECRET` - Separate secret for refresh tokens (defaults to `JWT_SECRET`)
- `JWT_EXPIRES_IN` - Access token expiration (default: `15m`)
- `JWT_REFRESH_EXPIRES_IN` - Refresh token expiration (default: `7d`)
- `DB_PATH` - SQLite database path (default: `database.sqlite`)
- `PORT` - Server port (default: `3000`)
- `NODE_ENV` - Environment (default: `development`)
- `CORS_ORIGIN` - Allowed CORS origin (default: `*`)

## Database

Uses SQLite with TypeORM. Database file is created automatically. Schema:

- `id` (primary key)
- `username` (unique)
- `password` (hashed with bcrypt)
- `refreshToken` (nullable)
- `createdAt`, `updatedAt`
