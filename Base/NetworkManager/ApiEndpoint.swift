// 
//  Apis.swift
//  breadwallet
//
//  Created by ElintMinds_11 on 11/05/20.
//  Copyright © 2020 Breadwinner AG. All rights reserved.
//
//  See the LICENSE file at the project root for license information.
//

import Foundation

public let baseUrl = "https://mobile.dev.api1.blockcard.ternio.co/"

enum ApiEndpoint {
    case createUser
    case login
    case forgotPassword
    case passwordReset
    case profile(String)
    case notifications(String)
    case resendVerificationLink
    case verifyEmail(String,String)
    case changePassword(String)
    
    var value: String {
        switch self {
        case .login : return "v1/user/login"
        case .createUser: return "v1/user"
        case .forgotPassword: return "v1/user/forgot-password"
        case .passwordReset: return "v1/user/reset-password"
        case .profile(let userId): return "/v1/user/\(userId)"
        case .notifications(let userId): return "v1/user/\(userId)/notification"
        case .resendVerificationLink: return "v1/user/verification/resend"
        case .verifyEmail(let userId,let token): return "v1/user/\(userId)/verify/\(token)"
        case .changePassword(let userId) : return "/v1/user/\(userId)/password"
        }
    }
}
