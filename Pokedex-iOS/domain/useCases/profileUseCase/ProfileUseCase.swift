//
//  ProfileUseCase.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 02/01/23.
//

import Foundation

final class ProfileUseCase: ProfileUseCaseProtocol {
    private let authService: AuthenticationServiceProtocol
    
    init(authService: AuthenticationServiceProtocol) {
        self.authService = authService
    }
    
    func getCurrentProvider() -> [LinkedAccount] {
        return authService.currentProvider().map { model in
            LinkedAccount(rawValue: model.rawValue)
        }.compactMap{ $0 }
    }
    
    func userLogOut() throws {
        try authService.userLogOut()
    }
    
    func userLinkFacebook(completion: @escaping(Bool) -> Void) {
        authService.linkFacebook(completion: completion)
    }
    
    func userLinkGoogle(completion: @escaping(Bool) -> Void) {
        authService.linkGoogle(completion: completion)
    }
    
    func userLinkEmailAndPassword(email: String, password: String, completion: @escaping(Bool) -> Void) {
        authService.linkEmailAndPassword(email: email, password: password, completion: completion)
    }
    
    func deleteAccount(completion: @escaping(Result<Bool, Error>) -> Void) {
        authService.deleteAccount(completion: completion)
    }
}
