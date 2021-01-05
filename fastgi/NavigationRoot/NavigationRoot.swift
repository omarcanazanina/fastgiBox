//
//  NavigationRoot.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import Foundation
import SwiftUI

class NavigationRoot{
    private let storage = UserDefaults.standard
    
    //nav
    func setRootViewNav (number: String, smstext: String){
        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        
        if let windowScenedelegate = scene?.delegate as? SceneDelegate {
            let window = UIWindow(windowScene: scene!)
            window.rootViewController = UIHostingController(rootView:CodeView(number: number, smstext: smstext)            )
            windowScenedelegate.window = window
            window.makeKeyAndVisible()
        }
    }
    
    //iniciar sesion
    func setRootView (){
        let authState = AuthState()
        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        
        if let windowScenedelegate = scene?.delegate as? SceneDelegate {
            let window = UIWindow(windowScene: scene!)
            window.rootViewController = UIHostingController(rootView:TabsView(currentBtnEm: .constant(.Entel)).environmentObject(authState)
            )
            windowScenedelegate.window = window
            window.makeKeyAndVisible()
        }
    }
    //cerrar sesion
    func changeRootClose(){
        self.storage.removeObject(forKey: "_id")
        self.storage.removeObject(forKey: "token")
        let authState = AuthState()
        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene

        if let windowScenedelegate = scene?.delegate as? SceneDelegate {
           let window = UIWindow(windowScene: scene!)
           window.rootViewController = UIHostingController(rootView:LoginView()
            .environmentObject(authState)
            )
           windowScenedelegate.window = window
           window.makeKeyAndVisible()
        }
    }
}
