import { registerPlugin } from '@capacitor/core';

import type { LoginWithUAEPassPlugin } from './definitions';

const LoginWithUAEPass = registerPlugin<LoginWithUAEPassPlugin>('LoginWithUAEPass', {
  web: () => import('./web').then((m) => new m.LoginWithUAEPassWeb()),
});

export * from './definitions';
export { LoginWithUAEPass };
