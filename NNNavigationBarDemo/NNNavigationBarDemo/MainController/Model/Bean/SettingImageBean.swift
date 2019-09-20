//
//  SettingImageBean.swift
//  NNNavigationBarDemo
//
//  Created by 顾海军 on 2019/9/20.
//  Copyright © 2019 GuHaijun. All rights reserved.
//

import UIKit

class SettingImageBean: SettingBeanProtocol {
    var type: SettingType = SettingType.image
    var title: String = ""
    
    private var _image: UIImage?
    private var _color: UIColor?
    
    var image: UIImage? {
        get {
            return _image
        }
        set {
            _image = newValue
            _color = nil;
        }
    }
    
    var color: UIColor? {
        get {
            return _color
        }
        set {
            _color = newValue
            _image = nil;
        }
    }
}
