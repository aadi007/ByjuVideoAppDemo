//
//  AuthRouter.swift
//  ByjuVideoAppDemo
//
//  Created by Aadesh Maheshwari on 30/11/15.
//  Copyright (c) 2015 @@DI007. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum AuthRouter: RouterProtocol {
    
    case AuthenticateRequest(AuthRequestBody)

    var path: String {
        switch self {
            
            case .AuthenticateRequest:
                return "/users/login"
            
        }
    }
    
    var method: Alamofire.Method {
        switch self {
            case .AuthenticateRequest:
                return .POST
        }
    }
    
    var parameters: AnyObject? {
        switch self {
            
            default:
                return nil

        }
    }
    
    var body: RequestBody? {
        switch self {
            
            case .AuthenticateRequest(let candidateFacebookData):
                return candidateFacebookData
        }
    }
}
