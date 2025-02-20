import { Controller, Post, Body, HttpException, HttpStatus } from '@nestjs/common';
import { LogsService } from './logs.service';

@Controller('logs')
export class LogsController {
  constructor(private readonly logsService: LogsService) {}

  @Post('upload')
  async uploadLog(@Body() fileData: any): Promise<any> {
    // fileData is expected to include properties such as fileName, bucket, filePath, etc.
    try {
      const result = await this.logsService.processLogFile(fileData);
      return { success: true, data: result };
    } catch (error) {
      throw new HttpException('Processing failed', HttpStatus.INTERNAL_SERVER_ERROR);
    }
  }
} 