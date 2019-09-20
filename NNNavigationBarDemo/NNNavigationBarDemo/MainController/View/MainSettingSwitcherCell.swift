//
//  MainSettingSwitcherCell.swift
//  NNNavigationBarDemo
//
//  Created by GuHaijun on 2018/5/11.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

import UIKit

class MainSettingSwitcherCell: UITableViewCell, MainSettingCellProtocol {
   
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var switcher: UISwitch!
    
    var actionDelegate: MainSettingCellDelegate?
    
    var _bean: SettingBeanProtocol?
    var bean: SettingBeanProtocol? {
        get {
            return _bean
        }
        set {
            _bean = newValue
            self.titleLabel.text = _bean?.title
            self.switcher.isOn = (_bean as! SettingSwitcherBean).isOn
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.switcher?.addTarget(self, action: #selector(self.handleSwitcher(switcher:)), for: .valueChanged)
    }
    
    @objc func handleSwitcher(switcher: UISwitch) {
        (self.bean as! SettingSwitcherBean).isOn = self.switcher.isOn
        self.actionDelegate?.cell(self, actionObject: switcher, params: nil);
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
