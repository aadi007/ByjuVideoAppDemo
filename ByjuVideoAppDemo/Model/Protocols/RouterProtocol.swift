//
//  RouterProtocol.swift
//  ByjuVideoAppDemo
//
//  Created by Aadesh Maheshwari on 30/11/15.
//  Copyright (c) 2015 @@DI007. All rights reserved.
//

import Foundation
import Alamofire

protocol RouterProtocol {
    
    var path: String { get }
    
    var method: Alamofire.Method { get }
    
    var parameters: AnyObject? { get }
    
    var body: RequestBody? { get }
}