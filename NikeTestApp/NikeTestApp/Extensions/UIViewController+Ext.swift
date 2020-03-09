//
//  UIViewController+Ext.swift
//  NikeTestApp
//
//  Created by Harish on 07/03/20.
//  Copyright © 2020 Harish. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
    
    func showWarning(message: String) {
        showAlert(title: "Warning", message: message)
    }
}
