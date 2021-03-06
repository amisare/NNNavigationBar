//
//  ColorfulImageBean.swift
//  NNNavigationBarDemo
//
//  Created by 顾海军 on 2019/9/20.
//  Copyright © 2019 GuHaijun. All rights reserved.
//

import UIKit

class ColorfulImageBean: ColorfulBeanProtocol {
    var title: String
    var image: UIImage? {
        get {
            return UIImage.init(named: self.title)
        }
    }
    var color: UIColor?
    
    init(title: String) {
        self.title = title
    }
}
