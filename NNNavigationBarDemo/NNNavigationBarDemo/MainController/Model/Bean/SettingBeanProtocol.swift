//
//  SettingBeanProtocol.swift
//  NNNavigationBarDemo
//
//  Created by 顾海军 on 2019/9/20.
//  Copyright © 2019 GuHaijun. All rights reserved.
//

import UIKit

enum SettingType {
    case `default`
    case header
    case switcher
    case image
    case segment
}

protocol SettingBeanProtocol {
    var type: SettingType { get }
    var title: String { get set }
}
