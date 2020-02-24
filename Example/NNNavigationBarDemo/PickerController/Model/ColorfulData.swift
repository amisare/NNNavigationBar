//
//  ColorfulData.swift
//  NNNavigationBarDemo
//
//  Created by 顾海军 on 2019/9/20.
//  Copyright © 2019 GuHaijun. All rights reserved.
//

import UIKit

enum ColorfulDataType {
    case `default`
    case image
    case color
}

class ColorfulData: NSObject {
    
    var imageBeans: [ColorfulImageBean] {
        return [
            ColorfulImageBean.init(title: "image0"),
            ColorfulImageBean.init(title: "image1"),
            ColorfulImageBean.init(title: "image2"),
            ColorfulImageBean.init(title: "image3"),
        ]
    }
    
    var colorBeans: [ColorfulColorBean] {
        return [
            ColorfulColorBean.init(title: "blackColor"),
            ColorfulColorBean.init(title: "darkGrayColor"),
            ColorfulColorBean.init(title: "lightGrayColor"),
            ColorfulColorBean.init(title: "whiteColor"),
            ColorfulColorBean.init(title: "grayColor"),
            ColorfulColorBean.init(title: "redColor"),
            ColorfulColorBean.init(title: "greenColor"),
            ColorfulColorBean.init(title: "blueColor"),
            ColorfulColorBean.init(title: "cyanColor"),
            ColorfulColorBean.init(title: "yellowColor"),
            ColorfulColorBean.init(title: "magentaColor"),
            ColorfulColorBean.init(title: "orangeColor"),
            ColorfulColorBean.init(title: "purpleColor"),
            ColorfulColorBean.init(title: "brownColor"),
            ColorfulColorBean.init(title: "clearColor"),
        ]
    }
    
    var nilBeans: [ColorfulColorBean] {
        return [
            ColorfulColorBean.init(title: "nil"),
        ]
    }
    
    func groupBeans(type: ColorfulDataType) -> [ColorfulGroupBean] {
        switch type {
        case .color:
            return [
                ColorfulGroupBean.init(
                    title: "color",
                    pickerBeans: self.colorBeans
                ),
                ColorfulGroupBean.init(
                    title: "nil",
                    pickerBeans: self.nilBeans
                )
            ]
        case .image:
            return [
                ColorfulGroupBean.init(
                    title: "image",
                    pickerBeans: self.imageBeans
                ),
                ColorfulGroupBean.init(
                    title: "nil",
                    pickerBeans: self.nilBeans
                )
            ]
        default:
            
            return [
                ColorfulGroupBean.init(
                    title: "image",
                    pickerBeans: self.imageBeans
                ),
                ColorfulGroupBean.init(
                    title: "color",
                    pickerBeans: self.colorBeans
                ),
                ColorfulGroupBean.init(
                    title: "nil",
                    pickerBeans: self.nilBeans
                )
            ]
        }
    }
}
