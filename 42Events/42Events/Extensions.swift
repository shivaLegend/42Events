//
//  Extensions.swift
//  42Events
//
//  Created by Tai Nguyen on 18/05/2021.
//

import UIKit

extension UIView {
    func roundCornersWith(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}

