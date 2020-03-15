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
    static let comicsPath = "v1/public/characters"

    static let publicKey = "38e5baf1fc7824c1388569f93dc7d1ed"
    static let privateKey = "49b818576f3019760706ea51ca18341a31472e2f"
    
    enum APIMethod: String {
        case get = "GET"
        case post = "POST"
    }
    
    enum Endpoint {
        case characters
        
        var method: APIMethod {
            switch self {
            case .characters:
                return .get
            }
        }
        
        var path: String {
            switch self {
            case .characters:
                let timestamp = String(describing: Int(NSDate().timeIntervalSince1970))
                let md5Result = CryptoHelper.md5Hash(str: "\(timestamp)\(API.privateKey)\(API.publicKey)")
                
                return "v1/public/comics?apikey=\(API.publicKey)&ts=\(timestamp)&hash=\(md5Result)"
            }
        }
    }
    
    func fetch(endpoint: Endpoint, callback: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        
        print("\n====  REQUEST \(API.baseUrl + endpoint.path)  ====")
        
        let url = URL(string: API.baseUrl + endpoint.path)!
        var request = URLRequest(url: url)
        let session = URLSession.shared
        
        request.httpMethod = endpoint.method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print(" 🚨 Failure: \(error.localizedDescription)")
                callback(data, response, error)
            }
            
            guard let httpResponse = response as? HTTPURLResponse else { return }
            
            if let mimeType = httpResponse.mimeType, mimeType == "application/json", let data = data {
                if (200...299).contains(httpResponse.statusCode) {
                     print(" ✅ Succeeded \(httpResponse.statusCode)\n \(String(data: data, encoding: .utf8) ?? "")\n")
                } else {
                     print(" 🚨 Error \(httpResponse.statusCode)\n \(String(data: data, encoding: .utf8) ?? "")\n")
                }
               
                callback(data, response, error)
            }
        }
        task.resume()
    }
}
