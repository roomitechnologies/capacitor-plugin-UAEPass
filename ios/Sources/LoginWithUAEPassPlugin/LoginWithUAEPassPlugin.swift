import Foundation
import Capacitor
import UAEPassClient

@objc(LoginWithUAEPassPlugin)
public class LoginWithUAEPassPlugin: CAPPlugin {
    
    override public func load() {
        print("🔵 UAE Pass Plugin - Plugin loaded")
        NotificationCenter.default.addObserver(self, selector: #selector(handleOpenURL(_:)), name: Notification.Name(CAPNotifications.URLOpen.name()), object: nil)
    }

    @objc func initialize(_ call: CAPPluginCall) {
        print("🔵 UAE Pass Plugin - Initializing SDK")

        let state = randomString(length: 24)
        let scope = "urn:uae:digitalid:profile"

        UAEPASSRouter.shared.spConfig = SPConfig(
            redirectUriLogin: "roomi://login",
            scope: scope,
            state: state,
            successSchemeURL: "roomi://login",
            failSchemeURL: "roomi://fail-login",
            signingScope: "urn:safelayer:eidas:sign:process:document"
        )

        UAEPASSRouter.shared.environmentConfig = UAEPassConfig(
            clientID: "sandbox_stage",
            clientSecret: "sandbox_stage", // Add client secret if required
            env: .staging
        )

        call.resolve()
    }

    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }

    @objc func login(_ call: CAPPluginCall) {
        DispatchQueue.main.async {
            if let webVC = UAEPassWebViewController.instantiate() as? UAEPassWebViewController {
                webVC.urlString = UAEPassConfiguration.getServiceUrlForType(serviceType: .loginURL)

                let topViewController = self.bridge?.viewController

                webVC.onUAEPassSuccessBlock = { (code: String?) in
                    topViewController?.dismiss(animated: true)
                    if let code = code {
                        call.resolve(["accessCode": code])
                    } else {
                        call.reject("Failed to get access code", "400", nil)
                    }
                }

                webVC.onUAEPassFailureBlock = { (response: String?) in
                    topViewController?.dismiss(animated: true)
                    call.reject("Authentication failed", response ?? "Unknown error", nil)
                }

                webVC.onDismiss = {
                    topViewController?.dismiss(animated: true)
                    call.reject("Authentication canceled", "User canceled the flow", nil)
                }

                webVC.reloadwithURL(url: webVC.urlString)
                topViewController?.present(webVC, animated: true)
            } else {
                call.reject("Failed to initialize web view", "500", nil)
            }
        }
    }

    @objc public func handleOpenURL(_ notification: Notification) {
        guard let url = notification.object as? URL else {
            print("❌ UAE Pass Plugin - handleOpenURL: Invalid URL")
            return
        }

        print("🔵 UAE Pass Plugin - handleOpenURL: Received URL - \(url.absoluteString)")

        if url.absoluteString.contains(HandleURLScheme.externalURLSchemeSuccess()) {
            print("🔵 UAE Pass Plugin - handleOpenURL: Success URL detected")
            self.notifyListeners("loginSuccess", data: [:])
        }
        else if url.absoluteString.contains(HandleURLScheme.externalURLSchemeFail()) {
            print("🔵 UAE Pass Plugin - handleOpenURL: Failure URL detected")
            self.notifyListeners("loginFailure", data: [:])
        }
    }
}
