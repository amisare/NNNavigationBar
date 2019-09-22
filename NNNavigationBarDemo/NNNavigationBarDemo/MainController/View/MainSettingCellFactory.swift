//
//  MainSettingCellFactory.swift
//  NNNavigationBarDemo
//
//  Created by 顾海军 on 2019/9/20.
//  Copyright © 2019 GuHaijun. All rights reserved.
//

import UIKit

class MainSettingCellFactory: NSObject {

    class func cell(settingBean: SettingBeanProtocol) -> MainSettingCell? {
        
        var clazz: NSObject.Type = MainSettingCell.self
        
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
            clazz = MainSettingCell.self
        }
        
        let cell = (Bundle.main.loadNibNamed(String.init(describing: clazz), owner: nil, options: nil) as? [MainSettingCell])?[0]
        return cell
    }
}

