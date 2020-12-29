//
//  Storyboard.swift
//  DropDownSwift5
//
//  Created by Dang Duy Cuong on 12/29/20.
//  Copyright © 2020 Ngô Bảo Châu. All rights reserved.
//

import Foundation
import UIKit
struct Storyboard {
    struct Main {
        static let manager = UIStoryboard(name: "Main", bundle: nil)
        
        static func numbersViewController() -> NumbersViewController {
            return manager.instantiateViewController(withIdentifier: "NumbersViewController") as! NumbersViewController
        }
    }
}
