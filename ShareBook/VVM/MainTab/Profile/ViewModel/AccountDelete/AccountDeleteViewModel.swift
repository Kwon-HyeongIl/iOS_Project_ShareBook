//
//  AccountDeleteViewModel.swift
//  ShareBook
//
//  Created by 권형일 on 10/3/24.
//

import Foundation

@Observable
class AccountDeleteViewModel {
    func deleteAccount() {
        AuthManager.shared.deleteAccount()
    }
}
