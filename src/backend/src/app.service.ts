import { Injectable } from '@nestjs/common';

@Injectable()
export class AppService {
  getStatus(): string {
    return 'Backend is up and running!';
  }
  
  // New method returning dummy deployments
  getDeployments(): any {
    // In the future, connect to Supabase to retrieve real deployment data.
    return [
      { id: 1, machineName: 'EG-B24XLYMTV1D9', status: 'Processed', createdAt: new Date() },
      { id: 2, machineName: 'EG-XYZ123ABC', status: 'Pending', createdAt: new Date() },
    ];
  }
} 