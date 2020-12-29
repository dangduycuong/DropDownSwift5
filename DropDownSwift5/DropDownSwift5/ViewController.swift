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
    
    var dataSource = ["textField.addTarget(self, action: #selector(showDropDown), for: .touchDown)", "As we", "have found", "IB doesn't allow us", "to change the height of the rounded", "corner border style.", "So change it to any of", "the other styles", "and set the desired height.", "In the code change", "the border style back.", "Lao động trí óc mà không lao động chân tay, chỉ biết lý luận mà không biết thực hành thì cũng là trí thức có một nửa. Vì vậy, cho nên các cháu trong lúc học lý luận cũng phải kết hợp với thực hành và tất cả các ngành khác đều phải: lý luận kết hợp với thực hành, học tập kết hợp với lao động. TuDienDanhNgon.vn"]
    var filterData = [String]()
    
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
        //        textField.addTarget(self, action: #selector(showDropDown), for: .touchDown)
        DropDown.startListeningToKeyboard()
//        customizeUIDropdown()
    }
    
    func filterDataText() {
        if textField.text == "" {
            filterData = dataSource
        } else {
            filterData = dataSource.filter { (data: String) in
                if let text = textField.text {
                    if data.lowercased().range(of: text.lowercased()) != nil {
                        return true
                    }
                }
                return false
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        filterDataText()
        useDropdown()
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        filterDataText()
        useDropdown()
    }
    
    func customizeUIDropdown() {
        DropDown.appearance().textColor = UIColor.cyan
        DropDown.appearance().selectedTextColor = UIColor.red
        DropDown.appearance().textFont = UIFont.systemFont(ofSize: 15)
        DropDown.appearance().backgroundColor = UIColor.white
        DropDown.appearance().selectionBackgroundColor = UIColor.lightGray
//        DropDown.appearance().cellHeight = 60
        DropDown.appearance().cornerRadius = 10
    }
    
    func useDropdown() {
        dropDown.anchorView = textField
        dropDown.dataSource = filterData
        dropDown.direction = .bottom
        dropDown.bottomOffset = CGPoint(x: 0, y: textField.bounds.size.height)
        //        dropDown.cellConfiguration = { [unowned self] (index, item) in
        //            return "- \(item) (option \(index))"
        //        }
        dropDown.dismissMode = .onTap
        dropDown.cellNib = UINib(nibName: "CustomCell", bundle: nil)
        dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard let cell = cell as? CustomCell else { return }
            cell.optionLabel.numberOfLines = 0
            
            // Setup your custom UI components
            cell.logoImageView.image = UIImage(named: "logo_\(index)")
            cell.optionLabel.text = item
            
            cell.optionLabel.backgroundColor = .cyan
//            cell.titleLabel.text = item
        }
        //optional
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.textField.text = item
        }
        //        dropDown.width = 200
        //display action
        dropDown.show()
        //        dropDown.hide()
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
            self.title = ""
            let vc = Storyboard.Main.numbersViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        dropDown.show()
    }
}

