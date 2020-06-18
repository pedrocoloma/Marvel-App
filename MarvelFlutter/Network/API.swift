//
//  API.swift
//  MarvelFlutter
//
//  Created by Pedro Felipe Coloma de Araujo on 08/03/20.
//  Copyright © 2020 Pedro Felipe Coloma de Araujo. All rights reserved.
//

import Foundation
import CryptoKit

class API {
    
    static let baseUrl = "https://gateway.marvel.com/"
    
    static func authData() -> String {
        let publicKey = "38e5baf1fc7824c1388569f93dc7d1ed"
        let privateKey = "49b818576f3019760706ea51ca18341a31472e2f"
        let timestamp = String(describing: Int(NSDate().timeIntervalSince1970))
        let md5Result = CryptoHelper.md5Hash(str: "\(timestamp)\(privateKey)\(publicKey)")
        
        return "?apikey=\(publicKey)&ts=\(timestamp)&hash=\(md5Result)"
    }
}
