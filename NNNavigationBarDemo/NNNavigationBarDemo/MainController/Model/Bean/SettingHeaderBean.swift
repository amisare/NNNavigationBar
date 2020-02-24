//
//  SettingHeaderBean.swift
//  NNNavigationBarDemo
//
//  Created by GuHaijun on 2019/9/22.
//  Copyright © 2019 GuHaijun. All rights reserved.
//

import UIKit

class SettingHeaderBean: SettingBeanProtocol {
    var title: String = ""
    var image: UIImage?
    init(title: String, image: UIImage) {
        self.title = title;
        self.image = image;
    }
}
