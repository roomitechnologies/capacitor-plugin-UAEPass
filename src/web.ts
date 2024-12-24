import { WebPlugin } from '@capacitor/core';

import type { LoginWithUAEPassPlugin } from './definitions';

export class LoginWithUAEPassWeb extends WebPlugin implements LoginWithUAEPassPlugin {
  initialize(): Promise<void> {
    throw new Error('Method not implemented.');
  }
  async login(): Promise<{ accessToken: string; userInfo: { uuid: string; firstName: string; lastName: string; email: string; } }> {
    console.log('Web login called');
    // Simulate a login flow
    return {
      accessToken: 'dummy-web-access-token',
      userInfo: {
        uuid: 'dummy-uuid',
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com'
      }
    };
  } 

  async logout(): Promise<void> {
    console.log('Web logout called');
  }
}
