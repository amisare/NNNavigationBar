//
//  PickerData.swift
//  NNNavigationBarDemo
//
//  Created by 顾海军 on 2019/9/20.
//  Copyright © 2019 GuHaijun. All rights reserved.
//

import UIKit

enum PickerDataType {
    case `default`
    case image
    case color
}

class PickerData: NSObject {
    
    var imageBeans: [PickerImageBean] {
        return [
            PickerImageBean.init(title: "image0"),
            PickerImageBean.init(title: "image1"),
            PickerImageBean.init(title: "image2"),
            PickerImageBean.init(title: "image3"),
        ]
    }
    
    var colorBeans: [PickerColorBean] {
        return [
            PickerColorBean.init(title: "blackColor"),
            PickerColorBean.init(title: "darkGrayColor"),
            PickerColorBean.init(title: "lightGrayColor"),
            PickerColorBean.init(title: "whiteColor"),
            PickerColorBean.init(title: "grayColor"),
            PickerColorBean.init(title: "redColor"),
            PickerColorBean.init(title: "greenColor"),
            PickerColorBean.init(title: "blueColor"),
            PickerColorBean.init(title: "cyanColor"),
            PickerColorBean.init(title: "yellowColor"),
            PickerColorBean.init(title: "magentaColor"),
            PickerColorBean.init(title: "orangeColor"),
            PickerColorBean.init(title: "purpleColor"),
            PickerColorBean.init(title: "brownColor"),
            PickerColorBean.init(title: "clearColor"),
        ]
    }
    
    var nilBeans: [PickerColorBean] {
        return [
            PickerColorBean.init(title: "nil"),
        ]
    }
    
    
    func groupBeans(type: PickerDataType) -> [PickerGroupBean] {
        switch type {
        case .color:
            return [
                PickerGroupBean.init(
                    title: "color",
                    pickerBeans: self.colorBeans
                ),
                PickerGroupBean.init(
                    title: "nil",
                    pickerBeans: self.nilBeans
                )
            ]
        case .image:
            return [
                PickerGroupBean.init(
                    title: "image",
                    pickerBeans: self.imageBeans
                ),
                PickerGroupBean.init(
                    title: "nil",
                    pickerBeans: self.nilBeans
                )
            ]
        default:
            
            return [
                PickerGroupBean.init(
                    title: "image",
                    pickerBeans: self.imageBeans
                ),
                PickerGroupBean.init(
                    title: "color",
                    pickerBeans: self.colorBeans
                ),
                PickerGroupBean.init(
                    title: "nil",
                    pickerBeans: self.nilBeans
                )
            ]
        }
    }
}
