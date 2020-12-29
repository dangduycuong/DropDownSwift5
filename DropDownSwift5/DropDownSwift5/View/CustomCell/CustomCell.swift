//
//  CustomCell.swift
//  DropDownSwift5
//
//  Created by Dang Duy Cuong on 9/25/20.
//  Copyright © 2020 Ngô Bảo Châu. All rights reserved.
//

import UIKit
import DropDown

class CustomCell: DropDownCell {
    
    @IBOutlet weak var logoImageView: UIImageView!
//    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        optionLabel.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
