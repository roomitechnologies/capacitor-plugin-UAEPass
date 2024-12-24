import { registerPlugin } from '@capacitor/core';
const LoginWithUAEPass = registerPlugin('LoginWithUAEPass', {
    web: () => import('./web').then((m) => new m.LoginWithUAEPassWeb()),
});
export * from './definitions';
export { LoginWithUAEPass };
//# sourceMappingURL=index.js.map