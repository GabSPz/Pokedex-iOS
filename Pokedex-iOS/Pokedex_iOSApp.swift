//
//  Pokedex_iOSApp.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 20/12/22.
//

import SwiftUI
import Firebase
import FacebookLogin
import GoogleSignIn
import GoogleMaps

class AppDelegate: NSObject,UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        FirebaseApp.configure()
        GMSServices.provideAPIKey("AIzaSyDkAn9zmo2rt1p4PatMmo-eE7yfJDioZpY")
        return true
    }
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any])
      -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
    }
}

@main
struct Pokedex_iOSApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    let persistenceController = PersistenceController.shared
    

    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .environmentObject(SessionManager())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
