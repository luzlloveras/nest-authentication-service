import { Test, TestingModule } from '@nestjs/testing';
import { AppController } from './app.controller';
import { AppService } from './app.service';

describe('AppController', () => {
  let appController: AppController;
  let appService: AppService;

  beforeEach(async () => {
    const app: TestingModule = await Test.createTestingModule({
      controllers: [AppController],
      providers: [AppService],
    }).compile();

    appController = app.get<AppController>(AppController);
    appService = app.get<AppService>(AppService);
  });

  it('should return service info', () => {
    const result = { message: 'Authentication Service API', version: '2.0.0' };
    jest.spyOn(appService, 'getInfo').mockReturnValue(result);
    expect(appController.getInfo()).toEqual(result);
  });
});
