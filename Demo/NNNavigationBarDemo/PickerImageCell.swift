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

    var _colorName: String?
    var colorName: String? {
        get {
            return _colorName
        }
        set {
            _colorName = newValue
            _imageName = nil;
            self.titleLabel.text = _colorName ?? "nil"
            self.preImageView.image = UIImage.nn_image(with: pickerColor)
        }
    }
    
    var _imageName: String?
    var imageName: String? {
        get {
            return _imageName
        }
        set {
            _imageName = newValue
            _colorName = nil
            self.titleLabel.text = _imageName ?? "nil"
            self.preImageView.image = pickerImage
        }
    }
    
    var pickerColor: UIColor? {
        get {
            guard let colorName = self.colorName else { return nil }
            guard UIColor.responds(to: NSSelectorFromString(colorName)) else {return nil}
            if let color = UIColor.perform(NSSelectorFromString(colorName)) {
                return color.takeUnretainedValue() as? UIColor
            }
            else {
                return nil
            }
        }
    }
    
    var pickerImage: UIImage? {
        get {
            guard let imageName = self.imageName else { return nil }
            return UIImage.init(named: imageName)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
