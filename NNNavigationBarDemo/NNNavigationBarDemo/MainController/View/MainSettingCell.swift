//
//  MainSettingCell.swift
//  NNNavigationBarDemo
//
//  Created by GuHaijun on 2018/5/11.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

import UIKit


enum MainSettingCellStyle : Int {
    case `default`
    case switcher
    case image
    case segment
}

protocol MainSettingCellDelegate : NSObjectProtocol {
    func cell(_ cell: MainSettingCellProtocol, actionObject : Any, params: Dictionary<String, Any>?)
}

extension MainSettingCellDelegate {
    func cell(_ cell: MainSettingCellProtocol, actionObject: Any, params: Dictionary<String, Any>?) {
    }
}

protocol MainSettingCellProtocol : NSObjectProtocol {
    var actionDelegate : MainSettingCellDelegate? {get set}
    var bean: SettingBeanProtocol? {get set}
}

class MainSettingCell: UITableViewCell, MainSettingCellProtocol{
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var actionDelegate: MainSettingCellDelegate?
    
    var _bean: SettingBeanProtocol?
    var bean: SettingBeanProtocol? {
        get {
            return _bean
        }
        set {
            _bean = newValue
            self.titleLabel.text = _bean?.title
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
