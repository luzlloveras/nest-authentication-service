import { Controller, Get } from '@nestjs/common';
import { AppService } from './app.service';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get()
  getInfo() {
    return {
      message: 'Authentication Service API',
      version: '2.0.0',
      features: [
        'User Registration',
        'User Login with JWT',
        'Refresh Tokens',
        'Password Validation',
        'Database Integration (SQLite)',
        'Protected Routes',
      ],
      endpoints: {
        register: {
          method: 'POST',
          path: '/auth/register',
          description: 'Register a new user',
          body: {
            username: 'string (min 3 chars)',
            password: 'string (min 8 chars, must contain uppercase, lowercase, number, and special char)',
          },
        },
        login: {
          method: 'POST',
          path: '/auth/login',
          description: 'Authenticate user and get JWT tokens',
          body: {
            username: 'string',
            password: 'string',
          },
          response: {
            access_token: 'JWT token (expires in 15m)',
            refresh_token: 'JWT refresh token (expires in 7d)',
            user: 'User object',
          },
        },
        refresh: {
          method: 'POST',
          path: '/auth/refresh',
          description: 'Refresh access token using refresh token',
          body: {
            refresh_token: 'string',
          },
        },
        logout: {
          method: 'POST',
          path: '/auth/logout',
          description: 'Logout user (requires JWT token)',
          headers: {
            Authorization: 'Bearer <access_token>',
          },
        },
        profile: {
          method: 'GET',
          path: '/auth/profile',
          description: 'Get authenticated user profile (requires JWT token)',
          headers: {
            Authorization: 'Bearer <access_token>',
          },
        },
      },
    };
  }
}
