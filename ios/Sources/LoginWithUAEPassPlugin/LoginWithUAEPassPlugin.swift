
/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
import Foundation
import Capacitor
import UAEPassClient

@objc(UAEPassPlugin)
public class UAEPassPlugin: CAPPlugin {

    @objc func login(_ call: CAPPluginCall) {
        let redirectUri = call.getString("redirectUri") ?? "roomi://login"
        
        UAEPassClient.shared.configure(clientId: "sandbox_stage", redirectUri: redirectUri)
        UAEPASSRouter.shared.spConfig = SPConfig(
            redirectUriLogin: redirectUri,
            scope: "urn:uae:digitalid:profile:general",
            state: UUID().uuidString,
            successSchemeURL: redirectUri,
            failSchemeURL: "roomi://fail-login"
        )
        
        // UAE Pass Login Process
        call.resolve(["token": "dummy-ios-token"])
    }
    
    @objc func logout(_ call: CAPPluginCall) {
        call.resolve()
    }
}

