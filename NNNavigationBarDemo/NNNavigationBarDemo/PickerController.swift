//
//  ColorPickerController.swift
//  NNNavigationBarDemo
//
//  Created by GuHaijun on 2018/5/14.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

import UIKit

enum PickerControllerType {
    case `default`
    case color
}

enum PickerDataType {
    case clear
    case image
    case color
}

class PickerController: UITableViewController {

    var selected: (([String : Any])->())? = nil
    
    var imageCellData: [[String : Any]] = [
        [
            "section" : "IMAGE",
            "data" : [
                "image0",
                "image1",
                "image2",
                "image3",
            ]]
    ]
    
    var colorCellData: [[String : Any]] = [
        [
            "section" : "COLOR",
            "data" : [
                "blackColor",
                "darkGrayColor",
                "lightGrayColor",
                "whiteColor",
                "grayColor",
                "redColor",
                "greenColor",
                "blueColor",
                "cyanColor",
                "yellowColor",
                "magentaColor",
                "orangeColor",
                "purpleColor",
                "brownColor",
                "clearColor",
            ]]
    ]
    
    var nullCellData: [[String : Any]] = [
        [
            "section" : "NIL",
            "data" : [
                "nil",
            ]]
    ]
    
    var cellData: [[String : Any]] {
        get {
            if type == .color {
                return self.colorCellData + self.nullCellData
            }
            return self.imageCellData + self.colorCellData + self.nullCellData
        }
    }
    
    var type = PickerControllerType.default
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
        self.tableView.register(UINib.init(nibName: String.init(describing: PickerImageCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: PickerImageCell.self))
    }
    
    convenience init(_ type : PickerControllerType) {
        self.init(style: .grouped)
        self.type = type
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return cellData.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (cellData[section]["data"] as? [Any])?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.cellData[section]["section"] as? String ?? ""
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String.init(describing: PickerImageCell.self)) as? PickerImageCell else { return UITableViewCell.init() }
        
        let cellData = (self.cellData[indexPath.section]["data"] as? [String])?[indexPath.row] ?? ""
        let sectionTitle = self.cellData[indexPath.section]["section"] as? String ?? ""
        
        if sectionTitle == "IMAGE" {
            cell.imageName = cellData
        }
        if sectionTitle == "COLOR" {
            cell.colorName = cellData
        }
        if sectionTitle == "NIL" {
            cell.colorName = nil
            cell.imageName = nil
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell: PickerImageCell? = tableView.cellForRow(at: indexPath) as? PickerImageCell
        cell?.isSelected = false
        
        let sectionTitle = self.cellData[indexPath.section]["section"] as? String ?? ""
        
        var selectedData = [String : Any]()
        if sectionTitle == "IMAGE" {
            selectedData["type"] = PickerDataType.image
            selectedData["data"] = cell?.pickerImage
        }
        if sectionTitle == "COLOR" {
            selectedData["type"] = PickerDataType.color
            selectedData["data"] = cell?.pickerColor
        }
        if sectionTitle == "NIL" {
            selectedData["type"] = PickerDataType.clear
        }
        
        if let selected = selected {
            selected(selectedData)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}
