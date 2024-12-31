#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>

CAP_PLUGIN(LoginWithUAEPassPlugin, "LoginWithUAEPassPlugin",
    CAP_PLUGIN_METHOD(initialize, CAPPluginReturnPromise);
    CAP_PLUGIN_METHOD(login, CAPPluginReturnPromise);
)
