//
//  UIImageView.swift
//  NikeTestApp
//
//  Created by Harish on 08/03/20.
//  Copyright © 2020 Harish. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloadImageFrom(link:String) {
        URLSession.shared.dataTask(with: URL(string: link)!) { (data, response, error) in
            DispatchQueue.main.async {
                if let data = data { self.image = UIImage(data: data) }
            }
        }.resume()
    }
}
