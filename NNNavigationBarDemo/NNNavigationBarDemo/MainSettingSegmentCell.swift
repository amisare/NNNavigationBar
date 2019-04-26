//
//  MainSegmentCell.swift
//  NNNavigationBarDemo
//
//  Created by GuHaijun on 2018/5/11.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

import UIKit

class MainSettingSegmentCell: UITableViewCell, MainSettingCellProtocol {
    
    @IBOutlet weak var _segment: UISegmentedControl!
    
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
    var segment: UISegmentedControl? {
        get {
            return _segment
        }
        set {
            _segment = newValue
        }
    }
    var actionDelegate: MainSettingCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.segment?.addObserver(self, forKeyPath: "selectedSegmentIndex", options: .new, context: nil)
        self.segment?.addTarget(self, action: #selector(self.handleSegment(segment:)), for: .valueChanged)
    }
    
    func updateCell() {
        self.titleLabel?.text = self.data?["title"] as? String;
    }
    
    @objc func handleSegment(segment: UISegmentedControl) {
        self.actionDelegate?.cell(self, actionObject: segment, params: nil);
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let change = change, let object = object else { return }
        if keyPath == "selectedSegmentIndex" {
            if (change[NSKeyValueChangeKey.newKey] != nil) {
                self.actionDelegate?.cell(self, actionObject: object, params: nil)
            }
        }
    }
    
    deinit {
        self.segment?.removeObserver(self, forKeyPath: "selectedSegmentIndex")
    }
    
}
