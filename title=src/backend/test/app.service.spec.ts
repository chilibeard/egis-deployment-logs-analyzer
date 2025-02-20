import { Test, TestingModule } from '@nestjs/testing';
import { AppService } from '../src/app.service';

describe('AppService', () => {
  let service: AppService;
  
  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [AppService],
    }).compile();
    
    service = module.get<AppService>(AppService);
  });
  
  it('should return backend status', () => {
    expect(service.getStatus()).toBe('Backend is up and running!');
  });

  it('should return dummy deployments', () => {
    const deployments = service.getDeployments();
    expect(Array.isArray(deployments)).toBe(true);
    expect(deployments.length).toBeGreaterThan(0);
    deployments.forEach(dep => {
      expect(dep).toHaveProperty('id');
      expect(dep).toHaveProperty('machineName');
      expect(dep).toHaveProperty('status');
      expect(dep).toHaveProperty('createdAt');
    });
  });
}); 