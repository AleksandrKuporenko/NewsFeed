//
//  AuthServise.swift
//  NewsFeed
//
//  Created by Александр on 12.01.2021.
//

import Foundation
import VK_ios_sdk


protocol AuthServiceDeligete: class {
    func authServiceShouldShow(viewController: UIViewController)
    func authServicSingIn()
    func authServicSingInFail()
}



class AuthServise :NSObject,VKSdkDelegate,VKSdkUIDelegate {

    

    private let appId = "7726472"
    private let vkSdk: VKSdk
    
    override init() {
        self.vkSdk = VKSdk.initialize(withAppId: appId )
        super.init()
        print("VKSdk.initialize")
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    
    weak var delegate: AuthServiceDeligete?
    
    var token: String? {
        return VKSdk.accessToken()?.accessToken
    }
    
    var userId: String? {
        return VKSdk.accessToken()?.userId
    }
    
    func wakeUpSession() {
         let scope = ["wall","friends"]
        VKSdk.wakeUpSession(scope) { [delegate] (state,error) in
            switch state {
            case .initialized:
                print("initialized")
                VKSdk.authorize(scope)
            case .authorized:
                print("authorized")
                delegate?.authServicSingIn()
        default:
                delegate?.authServicSingInFail()
            }
        }
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        if result.token != nil {
            delegate?.authServicSingIn()
        }
        
    }
     
    func vkSdkUserAuthorizationFailed() {
        print(#function)
        delegate?.authServicSingInFail()
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
        delegate?.authServiceShouldShow(viewController: controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
    
}
