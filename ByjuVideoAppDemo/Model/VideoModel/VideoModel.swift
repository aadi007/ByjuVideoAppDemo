//
//  VideoModel.swift
//  ByjuVideoAppDemo
//
//  Created by Parth Desai on 30/11/15.
//  Copyright © 2015 @@DI007. All rights reserved.
//

import UIKit
import SwiftyJSON

class VideoModel: NSObject {

    var videoURL: String?
    var trackName: String?
    var longDescription: String?
    
    init(json:JSON) {
        super.init()
        if let URL = json["artworkUrl60"].string {
            self.videoURL = URL
        }
        if let trackName = json["trackName"].string {
            self.trackName = trackName
        }
        if let longDescription = json["longDescription"].string {
            self.longDescription = longDescription
        }
    }
}
