//
//  MainSettingImageCell.swift
//  NNNavigationBarDemo
//
//  Created by GuHaijun on 2018/5/11.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

import UIKit

class MainSettingImageCell: UITableViewCell, MainSettingCellProtocol {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var preImageView: UIImageView!
    
    var actionDelegate: MainSettingCellDelegate?
    
    var _bean: SettingBeanProtocol?
    var bean: SettingBeanProtocol? {
        get {
            return _bean
        }
        set {
            guard let imageBean = newValue as? SettingImageBean else { return }
            self.titleLabel.text = imageBean.title
            if let color = imageBean.color {
                let image = UIImage.nn_image(with: color)
                self.preImageView?.image = image
            }
            else if let image = imageBean.image {
                self.preImageView?.image = image
            }
            else {
                self.preImageView?.image = nil
            }
            _bean = imageBean
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.preImageView?.backgroundColor = UIColor.clear
        self.preImageView?.layer.borderColor = UIColor.gray.cgColor
        self.preImageView?.layer.cornerRadius = 3
        self.preImageView?.layer.borderWidth = 0.5
        self.preImageView?.layer.masksToBounds = true
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
