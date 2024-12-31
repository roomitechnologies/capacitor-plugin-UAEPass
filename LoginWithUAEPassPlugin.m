//
//  LoginWithUAEPassPlugin.m
//  Pods
//
//  Created by Roomi on 31/12/2024.
//

#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>



CAP_PLUGIN(LoginWithUAEPassPlugin, "LoginWithUAEPassPlugin",
    CAP_PLUGIN_METHOD(initialize, CAPPluginReturnPromise);
    CAP_PLUGIN_METHOD(login, CAPPluginReturnPromise);
)
