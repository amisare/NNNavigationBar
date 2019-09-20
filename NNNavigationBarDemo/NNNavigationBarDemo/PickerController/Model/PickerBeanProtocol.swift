//
//  PickerBeanProtocol.swift
//  NNNavigationBarDemo
//
//  Created by 顾海军 on 2019/9/20.
//  Copyright © 2019 GuHaijun. All rights reserved.
//

import UIKit

enum PickerBeanType {
    case color
    case image
}

protocol PickerBeanProtocol {
    var type: PickerBeanType { get }
    var title: String { get set }
    var image: UIImage? { get }
}
