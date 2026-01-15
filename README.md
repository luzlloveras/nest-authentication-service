# NestJS Authentication Service

Simple JWT authentication service with refresh tokens and user registration. Built with NestJS and TypeORM, using SQLite for storage.

## Getting Started

Install dependencies and set up environment:

```bash
npm install
cp env.example .env
```

Start the dev server:

```bash
npm run start:dev
```

Server runs on `http://localhost:3000`. Check out the Swagger docs at `/api` once it's running.

## What it does

Handles user registration and JWT-based authentication. Access tokens expire after 15 minutes, refresh tokens last 7 days. Passwords are hashed with bcrypt.

Currently using SQLite for simplicity. You'll want to switch to PostgreSQL or MySQL for production. TypeORM synchronize is enabled in dev mode - make sure to use migrations in production.

## Documentation

- [API Endpoints](docs/endpoints.md) - Endpoint details and examples
- [Configuration](docs/config.md) - Environment variables
- [Testing](docs/testing.md) - How to test the API
- [Architecture](docs/architecture.md) - Project structure
