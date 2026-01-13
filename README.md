# 🔐 NestJS Authentication Service

A complete, production-ready authentication service built with **NestJS**, featuring JWT authentication, refresh tokens, user registration, password validation, and SQLite database integration. This service provides a robust foundation for implementing authentication in your applications.

## 📋 Table of Contents

- [Features](#-features)
- [Technologies](#-technologies)
- [Prerequisites](#-prerequisites)
- [Installation](#-installation)
- [Configuration](#-configuration)
- [Usage](#-usage)
- [API Documentation](#-api-documentation)
- [API Endpoints](#-api-endpoints)
- [Project Structure](#-project-structure)
- [Security](#-security)
- [Testing](#-testing)
- [Deployment](#-deployment)

## ✨ Features

### 🔐 Authentication & Authorization
- ✅ **User Registration** - Secure user registration with password validation
- ✅ **JWT Authentication** - Access tokens with configurable expiration
- ✅ **Refresh Tokens** - Long-lived refresh tokens for seamless token renewal
- ✅ **Protected Routes** - JWT guards for route protection
- ✅ **Session Management** - Logout with token invalidation

### 🛡️ Security
- ✅ **Password Hashing** - Bcrypt with 10 salt rounds
- ✅ **Strong Validation** - Complex password requirements
- ✅ **Global Validation** - ValidationPipe configured globally
- ✅ **Error Handling** - Global exception filters with structured responses
- ✅ **CORS Configuration** - Secure CORS configuration

### 📚 Documentation & Quality
- ✅ **Swagger/OpenAPI** - Interactive API documentation
- ✅ **TypeScript** - Full static typing
- ✅ **DTO Validation** - Class-validator for input validation
- ✅ **CI/CD** - GitHub Actions pipeline

### 🗄️ Database
- ✅ **TypeORM** - Modern ORM for TypeScript
- ✅ **SQLite** - Lightweight and easy-to-use database
- ✅ **Migrations** - Automatic synchronization in development

## 🛠️ Technologies

### Core
- **NestJS** (^10.0.0) - Progressive Node.js framework
- **TypeScript** (^5.1.3) - Typed superset of JavaScript
- **TypeORM** (^0.3.17) - ORM for TypeScript/JavaScript

### Authentication
- **Passport** (^0.6.0) - Authentication middleware
- **Passport JWT** (^4.0.1) - JWT strategy
- **Passport Local** (^1.0.0) - Local strategy
- **@nestjs/jwt** (^10.2.0) - JWT module for NestJS

### Security
- **Bcrypt** (^5.1.1) - Password hashing
- **class-validator** (^0.14.0) - Class validation
- **class-transformer** (^0.5.1) - Object transformation

### Documentation
- **@nestjs/swagger** (^7.1.16) - Swagger/OpenAPI integration

### Database
- **SQLite3** (^5.1.6) - SQLite driver

## 📋 Prerequisites

- **Node.js** v18 or higher
- **npm** or **yarn**
- Basic TypeScript knowledge (recommended)

## 🚀 Installation

### 1. Clone the repository

```bash
git clone https://github.com/luzlloveras/nest-authentication-service.git
cd nest-authentication-service
```

### 2. Install dependencies

```bash
npm install
```

### 3. Configure environment variables

```bash
cp env.example .env
```

Edit the `.env` file and configure your secrets:

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

# CORS Configuration
CORS_ORIGIN=*
```

**⚠️ Important:**
- Use strong, random secrets (minimum 32 characters recommended)
- Never commit the `.env` file to version control
- Use different secrets for production

## 🏃 Usage

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

# Run tests in watch mode
npm run test:watch

# Run e2e tests
npm run test:e2e

# Test coverage
npm run test:cov
```

## 📚 API Documentation

### Swagger/OpenAPI

Interactive API documentation is available when the server is running:

```
http://localhost:3000/api
```

From Swagger you can:
- View all available endpoints
- Test endpoints directly from the browser
- Authenticate using the "Authorize" button
- View request/response schemas
- Test different use cases

### Information Endpoint

```
GET http://localhost:3000/
```

Returns information about the API, version, features, and available endpoints.

## 🔌 API Endpoints

### Base URL
```
http://localhost:3000
```

---

### 1. 📝 Register User

Register a new user in the system.

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

### 2. 🔑 Login

Authenticate a user and receive JWT tokens.

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

### 3. 🔄 Refresh Access Token

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
- `400` - Refresh token required
- `401` - Invalid or expired refresh token

---

### 4. 👤 Get User Profile

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

### 5. 🚪 Logout

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

## 🏗️ Project Structure

```
src/
├── auth/                      # Authentication module
│   ├── auth.controller.ts     # Auth endpoints controller
│   ├── auth.module.ts         # Auth module configuration
│   ├── auth.service.ts        # Authentication business logic
│   ├── jwt.strategy.ts         # Passport JWT strategy
│   ├── jwt-auth.guard.ts       # JWT guard for route protection
│   ├── local.strategy.ts       # Passport local strategy
│   └── local-auth.guard.ts    # Local guard for login
├── users/                     # Users module
│   ├── dto/                   # Data Transfer Objects
│   │   ├── login.dto.ts       # Login DTO
│   │   ├── register.dto.ts    # Register DTO
│   │   └── refresh-token.dto.ts # Refresh token DTO
│   ├── entities/              # Database entities
│   │   └── user.entity.ts     # User entity
│   ├── users.module.ts        # Users module configuration
│   └── users.service.ts       # Users business logic
├── common/                    # Shared code
│   └── filters/               # Global filters
│       └── http-exception.filter.ts # HTTP exception filter
├── app.module.ts              # Root application module
├── app.controller.ts          # Root controller
├── app.service.ts             # Root service
└── main.ts                    # Application entry point
```

## 🔒 Security

### Password Security
- **Bcrypt Hashing**: Passwords are hashed using bcrypt with 10 salt rounds
- **Strong Validation**: Complex password requirements enforced
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
- **Global ValidationPipe**: Automatic validation of all DTOs

### Error Handling
- **Global Exception Filter**: Consistent and structured error responses
- **Correct HTTP Codes**: Appropriate use of HTTP status codes
- **Clear Error Messages**: Descriptive messages for debugging

### CORS
- **Secure Configuration**: CORS configured from environment variables
- **Allowed Headers**: Control of allowed headers
- **Allowed Methods**: HTTP methods restriction

## 🧪 Testing

### Automated Testing Script

Run the comprehensive test script:

```bash
./test-api.sh
```

This script tests:
1. Registering a new user
2. Login and token generation
3. Protected profile endpoint
4. Refresh token functionality
5. Logout functionality

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
| `CORS_ORIGIN` | Allowed origin for CORS | `*` | No |

## 📦 Main Dependencies

### Core
- `@nestjs/common` - NestJS common utilities
- `@nestjs/core` - NestJS core framework
- `@nestjs/config` - Configuration management
- `@nestjs/jwt` - JWT module
- `@nestjs/passport` - Passport integration
- `@nestjs/typeorm` - TypeORM integration
- `@nestjs/swagger` - Swagger/OpenAPI documentation

### Authentication & Security
- `passport` - Authentication middleware
- `passport-jwt` - JWT strategy for Passport
- `passport-local` - Local strategy for Passport
- `bcrypt` - Password hashing
- `class-validator` - Validation decorators
- `class-transformer` - Object transformation

### Database
- `typeorm` - ORM for TypeScript
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

**5. Swagger not showing**
- Verify server is running
- Ensure you're accessing `http://localhost:3000/api`
- Verify `@nestjs/swagger` is installed

## 🚀 Deployment

### Production Preparation

1. **Configure production environment variables:**
   - Use strong and unique secrets
   - Set `NODE_ENV=production`
   - Disable `synchronize` in TypeORM (use migrations)

2. **Production build:**
```bash
npm run build
```

3. **Run in production:**
```bash
npm run start:prod
```

### Production Recommendations

- ✅ Use a more robust database (PostgreSQL, MySQL)
- ✅ Implement rate limiting
- ✅ Configure professional logging (Winston, Pino)
- ✅ Use HTTPS
- ✅ Configure CORS specifically for your domain
- ✅ Implement monitoring and alerts
- ✅ Use database migrations instead of synchronize

## 📝 License

This project is licensed under the MIT License.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📞 Support

For issues and questions, please open an issue on the repository.

## 🙏 Acknowledgments

- [NestJS](https://nestjs.com/) - Amazing framework
- [TypeORM](https://typeorm.io/) - Excellent ORM
- [Passport](http://www.passportjs.org/) - Flexible authentication

---

**Built with ❤️ using NestJS**
