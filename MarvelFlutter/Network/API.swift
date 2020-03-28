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

    static let publicKey = "38e5baf1fc7824c1388569f93dc7d1ed"
    static let privateKey = "49b818576f3019760706ea51ca18341a31472e2f"
    
    static func authData() -> String {
        let timestamp = String(describing: Int(NSDate().timeIntervalSince1970))
        let md5Result = CryptoHelper.md5Hash(str: "\(timestamp)\(API.privateKey)\(API.publicKey)")
        
        return "?apikey=\(API.publicKey)&ts=\(timestamp)&hash=\(md5Result)"
    }
    
    enum APIMethod: String {
        case get = "GET"
        case post = "POST"
    }
    
    enum Endpoint {
        case characters
        case comics
        case comicDetailsImage(_ path: Thumbnail)
        
        var method: APIMethod {
            switch self {
            case .characters, .comics, .comicDetailsImage:
                return .get
            }
        }
        
        private var path: String {
            switch self {
            case .characters:
                return "v1/public/characters"
            case .comics:
                return "v1/public/comics"
            case .comicDetailsImage(let path):
                return "\(path.path + path.extension)"
            }
        }
        
        var url: URL {
            switch self {
            case .comicDetailsImage(let path):
                return URL(string: "https" + path.path.dropFirst(4) + "/standard_amazing." + path.extension)!
            default:
                return URL(string: API.baseUrl + path + authData())!
            }
        }
    }
    
    static func fetch(endpoint: Endpoint, callback: @escaping (_ data: Data?,
        _ response: URLResponse?, _ error: Error?) -> Void) {
        
        print("\n====  REQUEST \(endpoint.url)  ====")
        
        var request = URLRequest(url: endpoint.url)
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
    
    static func download(endpoint: Endpoint, callback: @escaping (_ data: Data?,
        _ response: URLResponse?, _ error: Error?) -> Void) {
        
        print("\n====  DOWNLOAD \(endpoint.url)  ====")
        
        var request = URLRequest(url: endpoint.url)
        let session = URLSession.shared
        
        request.httpMethod = endpoint.method.rawValue
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print(" 🚨 Failure: \(error.localizedDescription)")
                callback(data, response, error)
            }
            
            guard let httpResponse = response as? HTTPURLResponse else { return }
            
            if let data = data {
                if (200...299).contains(httpResponse.statusCode) {
                     print(" ✅ Succeeded \(httpResponse.statusCode)\n")
                } else {
                     print(" 🚨 Error \(httpResponse.statusCode)\n")
                }
               
                callback(data, response, error)
            }
        }
        task.resume()
    }
}
