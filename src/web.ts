import { WebPlugin } from '@capacitor/core';

import type { LoginWithUAEPassPlugin } from './definitions';

export class LoginWithUAEPassWeb extends WebPlugin implements LoginWithUAEPassPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
