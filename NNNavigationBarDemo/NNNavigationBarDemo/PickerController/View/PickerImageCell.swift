//
//  PickerImageCell.swift
//  NNNavigationBarDemo
//
//  Created by GuHaijun on 2018/5/14.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

import UIKit

class PickerImageCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var preImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.preImageView?.backgroundColor = UIColor.clear
        self.preImageView?.layer.borderColor = UIColor.gray.cgColor
        self.preImageView?.layer.cornerRadius = 3
        self.preImageView?.layer.borderWidth = 0.5
        self.preImageView?.layer.masksToBounds = true
    }
    
    var _bean: PickerBeanProtocol?
    
    var bean: PickerBeanProtocol? {
        get {
            return _bean
        }
        set {
            _bean = newValue
            self.titleLabel.text = _bean?.title
            self.preImageView.image = _bean?.image
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
