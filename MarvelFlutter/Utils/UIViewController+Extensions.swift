//
//  UIViewController+Extensions.swift
//  MarvelFlutter
//
//  Created by Pedro Felipe Coloma de Araujo on 26/03/20.
//  Copyright © 2020 Pedro Felipe Coloma de Araujo. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /*
     * Show loading alert overlaying the ViewController
     */
    func showLoadingalert(message: String? = "Loading ...") {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                    let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
                    loadingIndicator.hidesWhenStopped = true
            //        loadingIndicator.activit = UIActivityIndicatorView.Style.gray
                    loadingIndicator.startAnimating()
                    
                    alert.view.addSubview(loadingIndicator)
            self.present(alert, animated: true, completion: nil)
        }
    }

    /*
     *  Dismiss the loading alert
     *  Should only be called after showLoadingalert() has been called
     */
    func dismissLoadingAlert() {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
