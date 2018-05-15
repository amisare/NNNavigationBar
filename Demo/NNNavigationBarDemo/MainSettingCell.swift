//
//  MainSettingCell.swift
//  NNNavigationBarDemo
//
//  Created by GuHaijun on 2018/5/11.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

import UIKit


public enum MainSettingCellStyle : Int {
    case `default`
    case switcher
    case image
    case segment
}

public protocol MainSettingCellDelegate : NSObjectProtocol {
    func cell(_ cell: MainSettingCellProtocol, actionObject : Any, params: Dictionary<String, Any>?)
}

public extension MainSettingCellDelegate {
    func cell(_ cell: MainSettingCellProtocol, actionObject: Any, params: Dictionary<String, Any>?) {
    }
}

public protocol MainSettingCellProtocol : NSObjectProtocol {
    var data : [String : Any]? {get set}
    var titleLabel : UILabel? {get}
    var switcher : UISwitch? {get}
    var preImageView : UIImageView? {get}
    var segment : UISegmentedControl? {get}
    var actionDelegate : MainSettingCellDelegate? {get set}
}

public extension MainSettingCellProtocol {
    
    var titleLabel: UILabel? {
        get { return nil }
        set { }
    }
    
    var switcher: UISwitch? {
        get { return nil }
        set { }
    }
    
    var preImageView: UIImageView? {
        get { return nil }
        set { }
    }
    
    var segment: UISegmentedControl? {
        get { return nil }
        set { }
    }
    
    var actionDelegate: MainSettingCellDelegate? {
        get { return nil }
        set { }
    }
}


open class MainSettingCell: UITableViewCell, MainSettingCellProtocol{
    
    @IBOutlet weak var _titleLabel: UILabel!
    
    var _data: [String : Any]?
    public var data: [String : Any]? {
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
    }
    
    open class func cellResuable(_ tableView: UITableView, data: [String : Any]) -> MainSettingCellProtocol? {
        
        let style = data["style"] as? MainSettingCellStyle ?? .default
        
        let cellClosure = { (tableView: UITableView, clazz: NSObject.Type, data: [String : Any]) -> MainSettingCellProtocol? in
            
            if let cell: MainSettingCellProtocol = tableView.dequeueReusableCell(withIdentifier: String.init(describing: clazz)) as? MainSettingCellProtocol {
                cell.data = data
                return cell
            }
            let newCell = (Bundle.main.loadNibNamed(String.init(describing: clazz), owner: nil, options: nil) as? [MainSettingCellProtocol])?[0]
            newCell?.data = data
            
            return newCell
        }
        
        switch style {
        case .switcher:
            return cellClosure(tableView, MainSettingSwitcherCell.self, data)
        case .image:
            return cellClosure(tableView, MainSettingImageCell.self, data)
        case .segment:
            return cellClosure(tableView, MainSettingSegmentCell.self, data)
        default:
            return cellClosure(tableView, MainSettingCell.self, data)
        }
    }
    
    open class func cellType(_ cell: MainSettingCellProtocol) -> MainSettingCellStyle {
        if cell is MainSettingSwitcherCell {
            return .switcher
        }
        if cell is MainSettingImageCell {
            return .image
        }
        if cell is MainSettingSegmentCell {
            return .segment
        }
        return .default
    }

    override open func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateCell() {
        self.titleLabel?.text = self.data?["title"] as? String;
    }
    
    override open func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
