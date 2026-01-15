# NestJS Authentication Service

JWT authentication with refresh tokens and user registration. Uses SQLite with TypeORM.

## Run locally

```bash
npm install
cp env.example .env
npm run start:dev
```

Server runs on `http://localhost:3000`. Swagger docs at `/api`.

## Notes

- Uses SQLite (fine for dev, consider PostgreSQL for prod)
- No rate limiting on login endpoint yet
- Refresh tokens stored in database, single active token per user
- TypeORM synchronize enabled in dev (use migrations in prod)

## Documentation

See [docs/](docs/) for API endpoints, configuration, testing, and architecture details.
