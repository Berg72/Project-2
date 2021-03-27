//
//  UITableViewCell.swift
//  Project-2
//
//  Created by Mark bergeson on 3/8/21.
//

import UIKit

extension UITableViewCell {

    class func reuseIdentifier() -> String {
        return String(describing: self)
    }
}
