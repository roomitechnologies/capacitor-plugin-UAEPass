// ios/Plugin/UaePassPlugin.swift
import Foundation
import Capacitor
import UAEPassClient

@objc(UaePassPlugin)
public class UaePassPlugin: CAPPlugin {
    private var initialized = false
    
    // Initialize UAE Pass Configuration
    @objc func initialize(_ call: CAPPluginCall) {
        guard let clientId = call.getString("clientId"),
              let clientSecret = call.getString("clientSecret"),
              let environment = call.getString("environment"),
              let redirectUri = call.getString("redirectUri"),
              let scope = call.getString("scope"),
              let state = call.getString("state"),
              let successScheme = call.getString("successScheme"),
              let failScheme = call.getString("failScheme"),
              let signingScope = call.getString("signingScope") else {
            call.reject("Missing required parameters")
            return
        }
        
        let env: UAEPassConfig.Environment
        switch environment {
        case "production":
            env = .production
        case "qa":
            env = .qa
        case "dev":
            env = .dev
        default:
            call.reject("Invalid environment")
            return
        }
        
        UAEPASSRouter.shared.spConfig = SPConfig(
            redirectUriLogin: redirectUri,
            scope: scope,
            state: state,
            successSchemeURL: successScheme,
            failSchemeURL: failScheme,
            signingScope: signingScope
        )
        
        UAEPASSRouter.shared.environmentConfig = UAEPassConfig(
            clientID: clientId,
            clientSecret: clientSecret,
            env: env
        )
        
        initialized = true
        call.resolve(["message": "UAE Pass initialized successfully"])
    }
    
    // Login Flow
    @objc func login(_ call: CAPPluginCall) {
        guard initialized else {
            call.reject("Plugin not initialized")
            return
        }
        
        DispatchQueue.main.async {
            let webViewController = UAEPassWebViewController()
            webViewController.completionHandler = { [weak self] result in
                switch result {
                case .success(let accessToken):
                    call.resolve([
                        "accessToken": accessToken,
                        "userInfo": [
                            "uuid": "sample-uuid",
                            "firstName": "John",
                            "lastName": "Doe",
                            "email": "john@example.com"
                        ]
                    ])
                case .failure(let error):
                    call.reject(error.localizedDescription)
                }
            }
            
            if let viewController = self.bridge?.viewController {
                let navigationController = UINavigationController(rootViewController: webViewController)
                viewController.present(navigationController, animated: true)
            }
        }
    }

    
    @objc func signDocument(_ call: CAPPluginCall) {
        guard initialized else {
            call.reject("Plugin not initialized")
            return
        }
        
        guard let documentUrl = call.getString("documentUrl"),
              let signatureType = call.getString("signatureType"),
              let page = call.getInt("page"),
              let coordinates = call.getObject("coordinates"),
              let size = call.getObject("size") else {
            call.reject("Missing required parameters")
            return
        }
        
        // Placeholder for signing logic
        call.resolve([
            "signedDocumentUrl": "https://example.com/signed-document.pdf"
        ])
    }
    
    // Handle URL Scheme
    public override func handleOpenURL(_ notification: Notification) {
        guard let url = notification.object as? URL else { return }
        
        if url.absoluteString.contains(HandleURLScheme.externalURLSchemeSuccess()) {
            handleSuccess(url: url)
        } else if url.absoluteString.contains(HandleURLScheme.externalURLSchemeFail()) {
            handleFailure(url: url)
        }
    }
    
    private func handleSuccess(url: URL) {
        if let topViewController = UserInterfaceInfo.topViewController() as? UAEPassWebViewController {
            topViewController.forceReload()
        }
    }
    
    private func handleFailure(url: URL) {
        guard let webViewController = UserInterfaceInfo.topViewController() as? UAEPassWebViewController else {
            return
        }
        webViewController.foreceStop()
        
        let alertController = UIAlertController(
            title: "Login Failed",
            message: "Unable to login with UAE Pass. Please try again.",
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            webViewController.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(okAction)
        self.bridge?.viewController?.present(alertController, animated: true)
    }
}
