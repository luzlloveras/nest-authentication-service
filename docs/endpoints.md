# API Endpoints

Base URL: `http://localhost:3000`

## Register

```bash
POST /auth/register
Content-Type: application/json

{
  "username": "johndoe",
  "password": "SecurePass123!"
}
```

Password must be at least 8 chars with uppercase, lowercase, number, and special character (@$!%*?&).

## Login

```bash
POST /auth/login
Content-Type: application/json

{
  "username": "johndoe",
  "password": "SecurePass123!"
}
```

Returns access token (15min), refresh token (7d), and user info.

## Refresh Token

```bash
POST /auth/refresh
Content-Type: application/json

{
  "refresh_token": "..."
}
```

Returns new access token.

## Get Profile

```bash
GET /auth/profile
Authorization: Bearer <access_token>
```

## Logout

```bash
POST /auth/logout
Authorization: Bearer <access_token>
```

## Interactive Docs

Swagger UI at `http://localhost:3000/api` when server is running.
