//
//  SettingSegmentBean.swift
//  NNNavigationBarDemo
//
//  Created by 顾海军 on 2019/9/20.
//  Copyright © 2019 GuHaijun. All rights reserved.
//

import UIKit

enum SettingSegmentIndexBean: Int {
    case current = 0
    case next = 1
    case global = 2
}

class SettingSegmentBean: SettingBeanProtocol {
    var title: String = ""
    var selectedIndex: SettingSegmentIndexBean = .current
}
