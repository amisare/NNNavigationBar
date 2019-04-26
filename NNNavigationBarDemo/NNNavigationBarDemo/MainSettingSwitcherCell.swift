//
//  MainSettingSwitcherCell.swift
//  NNNavigationBarDemo
//
//  Created by GuHaijun on 2018/5/11.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

import UIKit

class MainSettingSwitcherCell: UITableViewCell, MainSettingCellProtocol {
    
    
    @IBOutlet weak var _titleLabel: UILabel!
    @IBOutlet weak var _switcher: UISwitch!
    
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
    public var titleLabel: UILabel? {
        get {
            return _titleLabel
        }
        set {
            _titleLabel = newValue
        }
    }
    
    var switcher: UISwitch? {
        get {
            return _switcher
        }
        set {
            _switcher = newValue
        }
    }
    
    var actionDelegate: MainSettingCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.switcher?.addTarget(self, action: #selector(self.handleSwitcher(switcher:)), for: .valueChanged)
    }
    
    func updateCell() {
        self.titleLabel?.text = self.data?["title"] as? String;
    }
    
    @objc func handleSwitcher(switcher: UISwitch) {
        self.actionDelegate?.cell(self, actionObject: switcher, params: nil);
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
