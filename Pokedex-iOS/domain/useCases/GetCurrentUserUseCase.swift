//
//  GetCurrentUserUseCase.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 31/12/22.
//

import Foundation

final class GetCurrentUserUseCase {
    private let authRepository: AuthRepository
    
    init(authRepository: AuthRepository = AuthRepository()) {
        self.authRepository = authRepository
    }
    
    func getCurrentUser()-> User? {
        let userModel = authRepository.getCurrentUser()
        let user: User? = .init(email: userModel?.email ?? "")
        return user
    }
}
