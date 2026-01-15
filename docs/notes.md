# Notes

## Trade-offs

**SQLite**: Fine for small apps and testing. For production, consider PostgreSQL/MySQL for better concurrency and features.

**TypeORM synchronize**: Enabled in dev for convenience. Disable in production and use migrations instead.

**Refresh tokens in DB**: Stored per user, single active token. If you need multi-device sessions, this needs changes.

**No rate limiting**: Login endpoint is open to brute force. Add throttling before deploying.

**CORS wide open**: Defaults to `*` for dev. Lock it down in production.

## Next Steps

- Add rate limiting
- Switch to migrations instead of synchronize
- Add proper logging (Winston/Pino)
- Consider refresh token rotation
- Add email verification if needed
- Move to proper database for production
