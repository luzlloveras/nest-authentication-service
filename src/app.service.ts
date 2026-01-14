import { Injectable } from '@nestjs/common';

@Injectable()
export class AppService {
  getInfo() {
    return {
      message: 'Authentication Service API',
      version: '2.0.0',
    };
  }
}
