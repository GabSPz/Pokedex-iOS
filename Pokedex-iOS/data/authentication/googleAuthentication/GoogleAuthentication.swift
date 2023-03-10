//
//  GoogleAuthentication.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 03/01/23.
//

import Foundation
import Firebase
import GoogleSignIn

class GoogleAuthentication: GoogleAuthenticationProtocol {
    
    func googleLogin(completion: @escaping(Result<[String]?, Error>) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: ApplicationUtility.rootViewControler) {  signInResult, error in
            
            if let error = error {
                print("Error Google SignIn: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let user = signInResult?.user else { return }
            guard let idToken = user.idToken?.tokenString else { return }
            let accessToken = user.accessToken.tokenString
            
            completion(.success([idToken,accessToken]))
            
        }
    }
    func getTokens(completion: @escaping([String]?) -> Void) {
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.configuration = config
        GIDSignIn.sharedInstance.restorePreviousSignIn{ user, error in
            if let error = error {
                print("Errror getting current user: \(error.localizedDescription)")
                return
            }
            guard
                let idToken = user?.idToken?.tokenString,
                let accesToken = user?.accessToken.tokenString
            else {
                return
            }
            
            completion([idToken, accesToken])
        }

    }
}
