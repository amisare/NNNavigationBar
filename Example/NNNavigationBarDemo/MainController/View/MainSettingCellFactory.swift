//
//  MainSettingCellFactory.swift
//  NNNavigationBarDemo
//
//  Created by 顾海军 on 2019/9/20.
//  Copyright © 2019 GuHaijun. All rights reserved.
//

import UIKit

class MainSettingCellFactory: NSObject {

    class func cell(settingBean: SettingBeanProtocol, indexPath: IndexPath) -> MainSettingCellProtocol? {
        
        var clazz: NSObject.Type = MainSettingTitleCell.self
        
        if settingBean is SettingHeaderBean {
            clazz = MainSettingHeaderCell.self
        }
        else if settingBean is SettingSwitcherBean {
            clazz = MainSettingSwitcherCell.self
        }
        else if settingBean is SettingImageBean {
            clazz = MainSettingImageCell.self
        }
        else if settingBean is SettingSegmentBean {
            clazz = MainSettingSegmentCell.self
        }
        else if settingBean is SettingBean {
            clazz = MainSettingTitleCell.self
        }
        
        var cell = (Bundle.main.loadNibNamed(String.init(describing: clazz), owner: nil, options: nil) as? [MainSettingCell])?[0] as? MainSettingCellProtocol
        
        cell?.bean = settingBean;
        cell?.indexPath = indexPath;
        
        return cell
    }
}

