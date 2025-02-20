import { Controller, Get } from '@nestjs/common';
import { AppService } from './app.service';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get()
  getStatus(): string {
    return this.appService.getStatus();
  }

  // New endpoint to list deployments
  @Get('deployments')
  getDeployments(): any {
    return this.appService.getDeployments();
  }
} 