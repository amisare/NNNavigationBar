//
//  MainSettingCellFactory.swift
//  NNNavigationBarDemo
//
//  Created by 顾海军 on 2019/9/20.
//  Copyright © 2019 GuHaijun. All rights reserved.
//

import UIKit

class MainSettingCellFactory: NSObject {

    class func cell(tableView: UITableView, settingBean: SettingBeanProtocol) -> MainSettingCell? {
        
        var clazz: NSObject.Type = MainSettingCell.self
        
        switch settingBean.type {
        case .header:
            clazz = MainSettingHeaderCell.self
        case .switcher:
            clazz = MainSettingSwitcherCell.self
        case .image:
            clazz = MainSettingImageCell.self
        case .segment:
            clazz = MainSettingSegmentCell.self
        case .default:
            clazz = MainSettingCell.self
        }
        
        let cell = (Bundle.main.loadNibNamed(String.init(describing: clazz), owner: nil, options: nil) as? [MainSettingCell])?[0]
        return cell
    }
}

