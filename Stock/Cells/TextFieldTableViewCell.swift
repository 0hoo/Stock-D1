//
//  TextFieldTableViewCell.swift
//  Stock
//
//  Created by Kim Younghoo on 11/28/17.
//  Copyright © 2017 0hoo. All rights reserved.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {

    //[C6-16]
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //[C6-23]
        selectionStyle = .none
    }
}
