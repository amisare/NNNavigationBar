//
//  MainSettingImageCell.swift
//  NNNavigationBarDemo
//
//  Created by GuHaijun on 2018/5/11.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

import UIKit

class MainSettingImageCell: UITableViewCell, MainSettingCellProtocol {
    
    @IBOutlet weak var _titleLabel: UILabel!
    @IBOutlet weak var _preImageView: UIImageView!
    
    var _data: [String : Any]?
    var data: [String : Any]? {
        get {
            return _data
        }
        set {
            _data = newValue
            updateCell()
        }
    }
    
    var titleLabel: UILabel? {
        get {
            return _titleLabel
        }
        set {
            _titleLabel = newValue
        }
    }
    
    var preImageView: UIImageView? {
        get {
            return _preImageView
        }
        set {
            _preImageView = newValue
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
    
    func updateCell() {
        self.titleLabel?.text = self.data?["title"] as? String;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
