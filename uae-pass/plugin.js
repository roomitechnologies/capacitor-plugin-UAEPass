var capacitorLoginWithUAEPass = (function (exports, core) {
    'use strict';

    const LoginWithUAEPass = core.registerPlugin('LoginWithUAEPass', {
        web: () => Promise.resolve().then(function () { return web; }).then((m) => new m.LoginWithUAEPassWeb()),
    });

    class LoginWithUAEPassWeb extends core.WebPlugin {
        async login(options) {
            console.log('Web login called', options);
            // Simulate a login flow
            return { token: 'dummy-web-token' };
        }
        async logout() {
            console.log('Web logout called');
        }
    }

    var web = /*#__PURE__*/Object.freeze({
        __proto__: null,
        LoginWithUAEPassWeb: LoginWithUAEPassWeb
    });

    exports.LoginWithUAEPass = LoginWithUAEPass;

    return exports;

})({}, capacitorExports);
//# sourceMappingURL=plugin.js.map
