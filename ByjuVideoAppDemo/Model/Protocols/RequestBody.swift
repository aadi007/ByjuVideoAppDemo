//
//  RequestBody.swift
//  ByjuVideoAppDemo
//
//  Created by Aadesh Maheshwari on 30/11/15.
//  Copyright (c) 2015 @@DI007. All rights reserved.
//

import Foundation
import ObjectMapper

class RequestBody: NSObject, RequestBodyProtocol {
    
    required init?(_ map: Map) {
        
    }
    
    override init() {
        
    }
    
    func mapping(map: Map) {
    }
    
}