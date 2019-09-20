//
//  MainHeaderCell.swift
//  NNNavigationBarDemo
//
//  Created by GuHaijun on 2018/5/11.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

import UIKit

class MainHeaderCell: UITableViewCell, MainSettingCellProtocol{
    var actionDelegate: MainSettingCellDelegate?
    
    var bean: SettingBeanProtocol?

    open var cellHeight: CGFloat {
        get {
            return 110
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
