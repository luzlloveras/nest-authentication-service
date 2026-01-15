# Testing

## Test script

Run the included test script:

```bash
./test-api.sh
```

## Manual testing with curl

Register a user:

```bash
curl -X POST http://localhost:3000/auth/register \
  -H "Content-Type: application/json" \
  -d '{"username":"testuser","password":"SecurePass123!"}'
```

Login:

```bash
curl -X POST http://localhost:3000/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"testuser","password":"SecurePass123!"}'
```

Get profile (replace with your access token):

```bash
curl http://localhost:3000/auth/profile \
  -H "Authorization: Bearer <access-token>"
```

Refresh token:

```bash
curl -X POST http://localhost:3000/auth/refresh \
  -H "Content-Type: application/json" \
  -d '{"refresh_token":"<refresh-token>"}'
```

## Automated tests

Run unit tests:

```bash
npm test
```

Run e2e tests:

```bash
npm run test:e2e
```
