//
//  Service.swift
//  MarvelFlutter
//
//  Created by Pedro Felipe Coloma de Araujo on 18/06/20.
//  Copyright © 2020 Pedro Felipe Coloma de Araujo. All rights reserved.
//

import Foundation

class Service {
    final func fetch(endpoint: Endpoint, callback: @escaping (_ data: Data?,
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
                    print(" ✅ Succeeded \(httpResponse.statusCode)\n \(String(data: data, encoding: .utf8)?.prefix(200) ?? "")\n")
                } else {
                     print(" 🚨 Error \(httpResponse.statusCode)\n \(String(data: data, encoding: .utf8) ?? "")\n")
                }
               
                callback(data, response, error)
            }
        }
        task.resume()
    }
    
    final func download(endpoint: Endpoint, callback: @escaping (_ data: Data?,
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
