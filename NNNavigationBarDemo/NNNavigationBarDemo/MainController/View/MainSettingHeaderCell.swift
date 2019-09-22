//
//  MainSettingHeaderCell.swift
//  NNNavigationBarDemo
//
//  Created by GuHaijun on 2018/5/11.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

import UIKit

class MainSettingHeaderCell: MainSettingCell{
    
    @IBOutlet weak var headerImageView: UIImageView!

    var cellHeight: CGFloat {
        get {
            return 110
        }
    }
    
    override var bean: SettingBeanProtocol? {
        get {
            return _bean
        }
        set {
            guard let imageBean = newValue as? SettingHeaderBean else { return }
            self.headerImageView.image = imageBean.image
            _bean = imageBean
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
