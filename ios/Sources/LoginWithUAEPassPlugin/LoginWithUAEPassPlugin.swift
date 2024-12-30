
import Foundation
import Capacitor
import UAEPassClient

@objc(UaePassPlugin)
public class UaePassPlugin: CAPPlugin {
    
    @objc func initialize(_ call: CAPPluginCall) {
        // Basic initialization exactly like docs
        UAEPASSRouter.shared.spConfig = SPConfig(
            redirectUriLogin: "roomi://login",
            scope: "urn:uae:digitalid:profile",
            state: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789",
            successSchemeURL: "roomi://login",
            failSchemeURL: "roomi://fail-login",
            signingScope: "urn:safelayer:eidas:sign:process:document"
        )
        
        UAEPASSRouter.shared.environmentConfig = UAEPassConfig(
            clientID: "sandbox_stage",
            clientSecret: "sandbox_stage",
            env: .qa
        )
        
        call.resolve()
    }
    
    @objc func login(_ call: CAPPluginCall) {
        DispatchQueue.main.async {
            let webViewController = UAEPassWebViewController()
            if let viewController = self.bridge?.viewController {
                let navigationController = UINavigationController(rootViewController: webViewController)
                viewController.present(navigationController, animated: true)
            }
        }
    }
    
    public func handleOpenURL(_ notification: Notification) {
        guard let url = notification.object as? URL else { return }
        print("<><><><> appDelegate URL : \(url.absoluteString)")
        
        if url.absoluteString.contains(HandleURLScheme.externalURLSchemeSuccess()) {
            if let topViewController = UserInterfaceInfo.topViewController() {
                if let webViewController = topViewController as? UAEPassWebViewController {
                    webViewController.forceReload()
                }
            }
        }
        else if url.absoluteString.contains(HandleURLScheme.externalURLSchemeFail()) {
            guard let webViewController = UserInterfaceInfo.topViewController() as? UAEPassWebViewController else {
                return
            }
            webViewController.foreceStop()
            
            let alertController = UIAlertController(
                title: "Failed to login with UAE PASS Login",
                message: "Try again later",
                preferredStyle: .actionSheet
            )
            
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                NSLog("OK Pressed")
                webViewController.navigationController?.popViewController(animated: true)
            }
            
            alertController.addAction(okAction)
            self.bridge?.viewController?.present(alertController, animated: true, completion: nil)
        }
    }
}
