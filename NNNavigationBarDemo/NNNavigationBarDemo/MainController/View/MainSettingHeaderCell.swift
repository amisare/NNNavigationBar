//
//  MainSettingHeaderCell.swift
//  NNNavigationBarDemo
//
//  Created by GuHaijun on 2018/5/11.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

import UIKit

class MainSettingHeaderCell: MainSettingCell, MainSettingCellProtocol {
    
    @IBOutlet weak var headerImageView: UIImageView!

    var cellHeight: CGFloat {
        get {
            return 110
        }
    }
    
    var bean: SettingBeanProtocol? {
        didSet {
            guard let imageBean = self.bean as? SettingHeaderBean else { return }
            self.headerImageView.image = imageBean.image
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
