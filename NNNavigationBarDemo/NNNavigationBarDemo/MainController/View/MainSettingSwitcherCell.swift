//
//  MainSettingSwitcherCell.swift
//  NNNavigationBarDemo
//
//  Created by GuHaijun on 2018/5/11.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

import UIKit

class MainSettingSwitcherCell: MainSettingCell, MainSettingCellProtocol {
   
    @IBOutlet weak var switcher: UISwitch!
    
    var bean: SettingBeanProtocol? {
        didSet {
            self.textLabel?.text = self.bean?.title
            self.switcher.isOn = (self.bean as! SettingSwitcherBean).isOn
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.switcher?.addTarget(self, action: #selector(self.handleSwitcher(switcher:)), for: .valueChanged)
    }
    
    @objc func handleSwitcher(switcher: UISwitch) {
        (self.bean as! SettingSwitcherBean).isOn = self.switcher.isOn
        self.delegate?.cell(self, actionObject: switcher, params: nil);
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
