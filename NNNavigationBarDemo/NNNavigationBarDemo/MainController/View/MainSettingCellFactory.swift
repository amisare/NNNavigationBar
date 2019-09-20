//
//  MainSettingCellFactory.swift
//  NNNavigationBarDemo
//
//  Created by 顾海军 on 2019/9/20.
//  Copyright © 2019 GuHaijun. All rights reserved.
//

import UIKit

class MainSettingCellFactory: NSObject {

    class func cell(tableView: UITableView, settingBean: SettingBeanProtocol) -> MainSettingCellProtocol? {
        
        var clazz: NSObject.Type = MainSettingCell.self
        
        switch settingBean.type {
        case .header:
            clazz = MainHeaderCell.self
        case .switcher:
            clazz = MainSettingSwitcherCell.self
        case .image:
            clazz = MainSettingImageCell.self
        case .segment:
            clazz = MainSettingSegmentCell.self
        case .default:
            clazz = MainSettingCell.self
        }
        
        if let cell: MainSettingCellProtocol = tableView.dequeueReusableCell(withIdentifier: String.init(describing: clazz)) as? MainSettingCellProtocol {
            cell.bean = settingBean
            return cell
        }
        let cell = (Bundle.main.loadNibNamed(String.init(describing: clazz), owner: nil, options: nil) as? [MainSettingCellProtocol])?[0]
        
        return cell
    }
}
