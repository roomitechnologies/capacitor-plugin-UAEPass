import { WebPlugin } from '@capacitor/core';

import type { LoginWithUAEPassPlugin, UAEPassOptions } from './definitions';

export class LoginWithUAEPassWeb extends WebPlugin implements LoginWithUAEPassPlugin {
  async login(options: UAEPassOptions): Promise<{ token: string }> {
    console.log('Web login called', options);
    // Simulate a login flow
    return { token: 'dummy-web-token' };
  }

  async logout(): Promise<void> {
    console.log('Web logout called');
  }
}
