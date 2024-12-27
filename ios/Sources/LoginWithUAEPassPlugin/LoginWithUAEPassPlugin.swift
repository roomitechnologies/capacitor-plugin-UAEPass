// ios/Plugin/UaePassPlugin.swift
import Foundation
import Capacitor
import UAEPassClient 

@objc(UaePassPlugin)
public class UaePassPlugin: CAPPlugin {
    private var initialized = false
    
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
        
        let env: UAEPassEnvironment
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
        call.resolve()
    }
    
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
                    // Fetch user info using the access token
                    // This is a placeholder - implement actual UAE Pass API calls
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
            
            // Present the UAE Pass login view controller
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
        
        // Implement document signing logic here
        // This is a placeholder - implement actual UAE Pass signing flow
        call.resolve([
            "signedDocumentUrl": "https://example.com/signed-document.pdf"
        ])
    }
}
