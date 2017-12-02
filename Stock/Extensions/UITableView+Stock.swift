//
//  UITableView+Stock.swift
//  Stock
//
//  Created by Kim Younghoo on 11/30/17.
//  Copyright © 2017 0hoo. All rights reserved.
//

import UIKit

//[C12-3]
extension UITableView {
    func hideBottomSeparator() {
        tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: 1))
    }
}
