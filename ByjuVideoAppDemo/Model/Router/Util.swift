//
//  Util.swift
//  ByjuVideoAppDemo
//
//  Created by Aadesh Maheshwari on 30/11/15.
//  Copyright (c) 2015 @@DI007. All rights reserved.
//

import Foundation
import Alamofire

/**
*  Util resource is used for all generic API.
*  Every resource is added as a case and its path and method is added to
*  respective strings.
*/
enum UtilRouter {
    
    case GetMoviewData()
    
    var path: String {
        switch self {
            
        case .GetMoviewData:
            return "https://itunes.apple.com/search?term=harry&country=us&entity=movie"
        }
    }
    
    var method: Alamofire.Method {
        switch self {
            case .GetMoviewData():
                return .GET
        }
    }
    
    var parameters: AnyObject? {
        switch self {
            default:
                return nil
        }
    }
}