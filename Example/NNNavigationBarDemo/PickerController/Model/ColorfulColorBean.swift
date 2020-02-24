//
//  ColorfulColorBean.swift
//  NNNavigationBarDemo
//
//  Created by 顾海军 on 2019/9/20.
//  Copyright © 2019 GuHaijun. All rights reserved.
//

import UIKit

class ColorfulColorBean: ColorfulBeanProtocol {
    var title: String
    var image: UIImage? {
        get {
            guard let color = self.color else {return nil}
            return UIImage.nn_image(with: color)
        }
    }
    var color: UIColor? {
        get {
            guard UIColor.responds(to: NSSelectorFromString(self.title)) else {return nil}
            if let color = UIColor.perform(NSSelectorFromString(self.title)) {
                return color.takeUnretainedValue() as? UIColor
            }
            else {
                return nil
            }
        }
    }

    init(title: String) {
        self.title = title
    }
}
