import Foundation
import Capacitor

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(LoginWithUAEPassPlugin)
public class LoginWithUAEPassPlugin: CAPPlugin, CAPBridgedPlugin {
    public let identifier = "LoginWithUAEPassPlugin"
    public let jsName = "LoginWithUAEPass"
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "echo", returnType: CAPPluginReturnPromise)
    ]
    private let implementation = LoginWithUAEPass()

    @objc func echo(_ call: CAPPluginCall) {
        let value = call.getString("value") ?? ""
        call.resolve([
            "value": implementation.echo(value)
        ])
    }
}
