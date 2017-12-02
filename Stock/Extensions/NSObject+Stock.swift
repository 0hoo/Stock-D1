//
//  NSObject+Stock.swift
//  Stock
//
//  Created by Kim Younghoo on 11/28/17.
//  Copyright © 2017 0hoo. All rights reserved.
//

import Foundation

extension NSObject {
    //[C6-20]
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
