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
    func cell(_ cell: MainSettingCellProtocol)
}

extension MainSettingCellDelegate {
    func cell(_ cell: MainSettingCellProtocol) {
    }
}

protocol MainSettingCellProtocol {
    var bean: SettingBeanProtocol? {get set}
    var indexPath: IndexPath? {get set}
    var delegate : MainSettingCellDelegate? {get set}
}

extension MainSettingCellProtocol where Self : MainSettingCell {
    var delegate : MainSettingCellDelegate? {
        get{
            return _delegate
        }
        set{
            _delegate = newValue
        }
    }
    var indexPath : IndexPath? {
        get{
            return _indexPath
        }
        set{
            _indexPath = newValue
        }
    }
}

class MainSettingCell: UITableViewCell {
    
    fileprivate weak var _delegate : MainSettingCellDelegate?
    fileprivate var _indexPath: IndexPath?
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override open func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
