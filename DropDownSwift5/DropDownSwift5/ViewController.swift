//
//  ViewController.swift
//  DropDownSwift5
//
//  Created by Đặng Duy Cường on 3/7/20.
//  Copyright © 2020 Ngô Bảo Châu. All rights reserved.
//

import UIKit
import DropDown

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var textField: UITextField!
    let dropDown = DropDown()
    
    var dataSource = ["As we have found", "IB doesn't allow us to change the height of the rounded corner border style.", "So change it to any of the other styles and set the desired height.", "In the code change the border style back."]
    
//    var filtered = [String]() {
//        didSet {
//            filtered = dataSource.filter { word in
//                word.lowercased().contains(textField.text!.lowercased())
//            }
//        }
//    }
    var filtered = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        textField.delegate = self
        textField.addTarget(self, action: #selector(showDropDown), for: .touchDown)
    }

    @objc func showDropDown() {
//        dropDown.dataSource = filtered
//        dropDown.anchorView = textField
//        dropDown.direction = .bottom
//        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
//          print("Selected item: \(item) at index: \(index)")
//        }
//
//        dropDown.bottomOffset = CGPoint(x: 0, y: -(dropDown.anchorView?.plainView.bounds.height)!)
//        dropDown.show()
//        dropDown.hide()
        
//        copy dưới lên
                dropDown.dataSource = dataSource
        //        dropDown.dataSource =
        //            self.arrayActionGroup.map({$0.ugcyName ?? ""})
                dropDown.direction = .bottom
        //        dropDown.textFont = Constant.font.robotoRegular(ofSize: 15)
                dropDown.anchorView = textField
                dropDown.bottomOffset = CGPoint(x: 0, y: textField.bounds.size.height)
                dropDown.width = textField.bounds.size.width
                dropDown.selectionAction = { (index, item) in
        //            self.groupActionId = self.arrayActionGroup[index].ugcyId
        //            self.labelActionGroupValue.text = item
        //            self.defaultSortField = self.arrayActionGroup[index].defaultSortField
        //            self.getListWorkLogCategoryDTO()
                    self.filtered = self.dataSource.filter { word in
                        word.lowercased().contains(self.textField.text!.lowercased())
                    }
                    self.textField.text = item
                    self.view.endEditing(true)
//                    self.dropDown.reloadAllComponents()
                    self.dropDown.dataSource = self.filtered
                    self.dropDown.reloadInputViews()
                }
                dropDown.show()
    }
    
    @IBAction func onClickSelectActionGroup(_ sender: UIButton) {
        dropDown.dataSource = dataSource
//        dropDown.dataSource =
//            self.arrayActionGroup.map({$0.ugcyName ?? ""})
        dropDown.direction = .bottom
//        dropDown.textFont = Constant.font.robotoRegular(ofSize: 15)
        dropDown.anchorView = sender
        dropDown.bottomOffset = CGPoint(x: 0, y: sender.bounds.size.height)
        dropDown.width = sender.bounds.size.width
        dropDown.selectionAction = { (index, item) in
//            self.groupActionId = self.arrayActionGroup[index].ugcyId
//            self.labelActionGroupValue.text = item
//            self.defaultSortField = self.arrayActionGroup[index].defaultSortField
//            self.getListWorkLogCategoryDTO()
            sender.titleLabel?.text = item
        }
        dropDown.show()
    }
}

