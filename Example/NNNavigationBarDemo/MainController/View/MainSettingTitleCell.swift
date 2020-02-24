//
//  MainSettingTitleCell.swift
//  NNNavigationBarDemo
//
//  Created by 顾海军 on 2019/9/24.
//  Copyright © 2019 GuHaijun. All rights reserved.
//

import UIKit

class MainSettingTitleCell: MainSettingCell {

    var bean: SettingBeanProtocol? {
        didSet {
            self.textLabel?.text = self.bean?.title
        }
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override open func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension MainSettingTitleCell: MainSettingCellProtocol {
    
}
