//
//  Group.swift
//  Stock
//
//  Created by Kim Younghoo on 11/28/17.
//  Copyright © 2017 0hoo. All rights reserved.
//

import Foundation

//[C2-2]
//class Group {

//[C8-1]
class Group: Codable {
    //[C10-11]
    static let didDelete = Notification.Name(rawValue: "Group.didDelete")
    
    var title: String
    var note: String?
    
    init(title: String, note: String?) {
        self.title = title
        self.note = note
    }
}
