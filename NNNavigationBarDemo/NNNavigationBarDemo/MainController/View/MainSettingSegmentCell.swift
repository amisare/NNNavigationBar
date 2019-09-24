//
//  MainSegmentCell.swift
//  NNNavigationBarDemo
//
//  Created by GuHaijun on 2018/5/11.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

import UIKit

class MainSettingSegmentCell: MainSettingCell, MainSettingCellProtocol {
    
    @IBOutlet weak var segment: UISegmentedControl!
    
    var bean: SettingBeanProtocol? {
        didSet {
            self.segment.selectedSegmentIndex = (self.bean as! SettingSegmentBean).selectedIndex.rawValue
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.segment?.addTarget(self, action: #selector(self.handleSegment(segment:)), for: .valueChanged)
    }
    
    @objc func handleSegment(segment: UISegmentedControl) {
        (self.bean as! SettingSegmentBean).selectedIndex = SettingSegmentIndexBean.init(rawValue: segment.selectedSegmentIndex) ?? .current
        self.delegate?.cell(self, actionObject: segment, params: nil);
    }
}
