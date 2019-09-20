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


class PickerController: UITableViewController {
    
    var pickerData = PickerData.init();

    var selected: ((PickerBeanProtocol?)->())? = nil
    
    var type = PickerDataType.default
    
    override init(style: UITableView.Style) {
        super.init(style: style)
        self.tableView.register(UINib.init(nibName: String.init(describing: PickerImageCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: PickerImageCell.self))
    }
    
    convenience init(_ type : PickerDataType) {
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
        return self.pickerData.groupBeans(type: self.type).count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pickerData.groupBeans(type: self.type)[section].pickerBeans.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.pickerData.groupBeans(type: self.type)[section].title
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String.init(describing: PickerImageCell.self)) as? PickerImageCell else { return UITableViewCell.init() }
        
        let bean = self.pickerData.groupBeans(type: self.type)[indexPath.section].pickerBeans[indexPath.row]
        cell.bean = bean
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell: PickerImageCell? = tableView.cellForRow(at: indexPath) as? PickerImageCell
        cell?.isSelected = false
        
        if let selected = selected {
            selected(cell?.bean)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}
