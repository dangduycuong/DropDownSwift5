//
//  NumbersViewController.swift
//  DropDownSwift5
//
//  Created by Dang Duy Cuong on 12/29/20.
//  Copyright © 2020 Ngô Bảo Châu. All rights reserved.
//

import UIKit
import DropDown

class NumbersViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    let dropDown = DropDown()
    
    var sourceNumbers = [String]()
    var suggestNumbers = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        for item in 100...200 {
            sourceNumbers.append("\(item)")
        }
        searchTextField.delegate = self
        dropDown.textColor = .green
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        dropDown.backgroundColor = .white
    }
    
    func showDropDown() {
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
        dropDown.dataSource = suggestNumbers
        //        dropDown.dataSource =
        //            self.arrayActionGroup.map({$0.ugcyName ?? ""})
        dropDown.direction = .bottom
        //        dropDown.textFont = Constant.font.robotoRegular(ofSize: 15)
        dropDown.anchorView = searchTextField
        dropDown.bottomOffset = CGPoint(x: 0, y: searchTextField.bounds.size.height)
        dropDown.width = searchTextField.bounds.size.width
        
        dropDown.dismissMode = .onTap
                dropDown.cellNib = UINib(nibName: "NumberCell", bundle: nil)
                dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
                    guard let cell = cell as? NumberCell else { return }
//                    cell.optionLabel.numberOfLines = 0
                    
                    // Setup your custom UI components
                    cell.optionLabel.text = item
                    
//                    cell.optionLabel.backgroundColor = .cyan
                }
        
        dropDown.selectionAction = { (index, item) in
            self.searchTextField.text = item
        }
        dropDown.show()
    }
    
    func filterNumber() {
        if searchTextField.text == "" {
            suggestNumbers = sourceNumbers
        } else {
            suggestNumbers = sourceNumbers.filter { (string: String) in
                if let text = searchTextField.text {
                    if string.lowercased().range(of: text.lowercased()) != nil {
                        return true
                    }
                }
                return false
            }
        }
    }

}

extension NumbersViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        filterNumber()
        showDropDown()
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        filterNumber()
        showDropDown()
    }
}
