import { WebPlugin } from '@capacitor/core';
export class LoginWithUAEPassWeb extends WebPlugin {
    async login(options) {
        console.log('Web login called', options);
        // Simulate a login flow
        return { token: 'dummy-web-token' };
    }
    async logout() {
        console.log('Web logout called');
    }
}
//# sourceMappingURL=web.js.map