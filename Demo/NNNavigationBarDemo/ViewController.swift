//
//  ViewController.swift
//  NNNavigationBarDemo
//
//  Created by GuHaijun on 2018/5/11.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

import UIKit

enum NNActiveSegement {
    case next
    case current
    case global
}

class ViewController: UIViewController {
    
    var prompt: String = "Navigation Bar Prompt"
    
    static var promptHidden: Bool = true
    var _promptHidden: Bool?
    var promptHidden: Bool? {
        get {
            return _promptHidden
        }
        set {
            _promptHidden = newValue
            self.updatePrompt()
        }
    }
    
    static var barHidden: Bool = false
    var _barHidden: Bool?
    var barHidden: Bool? {
        get {
            return _barHidden
        }
        set {
            _barHidden = newValue
            self.updateBar()
        }
    }
    
    var page = 0
    var segment: UISegmentedControl?
    
    lazy var nextViewController: ViewController = {
        let vc = ViewController.init()
        return vc
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: .grouped)
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 0.0
        tableView.estimatedSectionHeaderHeight = 0.0
        tableView.estimatedSectionFooterHeight = 0.0
        tableView.sectionFooterHeight = 0.01
        tableView .register(UINib.init(nibName: String.init(describing: MainHeaderCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: MainHeaderCell.self))
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Next", style: .plain, target: self, action: #selector(pushNextViewController))
        
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.init(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage.init()
        self.navigationController?.navigationBar.nn_backgroundViewHidden = false;
        
        self.title = "Title" + " " + "\(self.page)"
        
        self.setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateBar()
        self.updatePrompt()
        self.tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.prompt = nil;
    }
    
    func updatePrompt() {
        if let promptHidden = self.promptHidden {
            if promptHidden {
                self.navigationItem.prompt = nil
            }
            else {
                self.navigationItem.prompt = self.prompt
            }
        }
        else {
            if ViewController.promptHidden {
                self.navigationItem.prompt = nil
            }
            else {
                self.navigationItem.prompt = self.prompt
            }
        }
    }
    
    func updateBar() {
        if let barHidden = self.barHidden {
            self.navigationController?.setNavigationBarHidden(barHidden, animated: true)
        }
        else {
            self.navigationController?.setNavigationBarHidden(ViewController.barHidden, animated: true)
        }
    }
    
    @objc public func pushNextViewController() {
        self.segment?.selectedSegmentIndex = 0
        let vc = self.nextViewController;
        vc.page = self.page + 1
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate, MainSettingCellDelegate {
    
    
    public func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let constraints: Array<NSLayoutConstraint> =
            NSLayoutConstraint.nn_constraints(withVisualFormats: ["H:|[tableView]|",
                                                                  "V:|[tableView]|"],
                                              views: ["tableView" : tableView]);
        NSLayoutConstraint.activate(constraints)
    }
    
    func headerSectionData() -> [String : Any] {
        return [
            "section" : "header",
            "data" :  [
                ["title" : NSStringFromClass(MainHeaderCell.self),
                 ]
            ]
        ]
    }
    
    func segmentSectionData() -> [String : Any] {
        return [
            "section" : "segment",
            "data" : [
                ["title" : "",
                 "style" : MainSettingCellStyle.segment,
                 ],
            ]
        ]
    }
    
    func backgroundSectionData() -> [String : Any] {
        return [
            "section" : "background",
            "data" : [
                ["title" : "metricsDefault",
                 "style" : MainSettingCellStyle.image,
                 "attached" : [
                    "metrics" : UIBarMetrics.default,
                    ]
                ],
                
                ["title" : "metricsCompact",
                 "style" : MainSettingCellStyle.image,
                 "attached" : [
                    "metrics" : UIBarMetrics.compact,
                    ]
                ],
                
                ["title" : "metricsDefaultPrompt",
                 "style" : MainSettingCellStyle.image,
                 "attached" : [
                    "metrics" : UIBarMetrics.defaultPrompt,
                    ]
                ],
                
                ["title" : "metricsCompactPrompt",
                 "style" : MainSettingCellStyle.image,
                 "attached" : [
                    "metrics" : UIBarMetrics.compactPrompt,
                    ]
                ],
            ]
        ]
    }
    
    func otherSectionData() -> [String : Any] {
        return [
            "section" : "other",
            "data" : [
                
                ["title" : "translucentAnimation",
                 "style" : MainSettingCellStyle.switcher,
                 ],
                
                ["title" : "prompt",
                 "style" : MainSettingCellStyle.switcher,
                 ],
                
                ["title" : "hidden",
                 "style" : MainSettingCellStyle.switcher,
                 ],
            ]
        ]
    }
    
    func commonCellData() -> [String : Any] {
        return [
            "section" : "common operation",
            "data" : [
                ["title" : "push",
                 "style" : MainSettingCellStyle.default,
                 ],
                ["title" : "pop",
                 "style" : MainSettingCellStyle.default,
                 ],
                ["title" : "popToRoot",
                 "style" : MainSettingCellStyle.default,
                 ],
            ]
        ]
    }
    
    func cellData() -> [[String : Any]] {
        
        var cellData: [[String : Any]] = []
        
        cellData.append(self.headerSectionData())
        cellData.append(self.segmentSectionData())
        cellData.append(self.backgroundSectionData())
        cellData.append(self.otherSectionData())
        cellData.append(self.commonCellData())
        
        return cellData
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.cellData().count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionData = self.cellData()[section]["data"] as? [Any]
        return sectionData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section != 0 {
            return 44
        }
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return nil
        }
        return (self.cellData()[section]["section"] as? String) ?? ""
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return MainHeaderCell.init().cellHeight
        }
        return 44;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: String.init(describing: MainHeaderCell.self)) {
                return cell
            }
            return UITableViewCell.init()
        }
        
        let sectionData = self.cellData()[indexPath.section]["data"] as? [Any]
        guard let cellData : [String : Any] = sectionData?[indexPath.row] as? [String : Any] else { return UITableViewCell.init() }
        guard let cell : MainSettingCellProtocol = MainSettingCell.cellResuable(tableView, data: cellData) else { return UITableViewCell.init() }
        
        let style = MainSettingCell.cellType(cell);
        if style == .segment {
            cell.actionDelegate = self
            self.segment = cell.segment
        }
        if style == .switcher {
            cell.actionDelegate = self
            cell.switcher?.isOn = false
        }
        
        self.setCell(cell: cell, activeSegment: self.activeSegment())
        
        return cell as! UITableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let tableCell = tableView.cellForRow(at: indexPath)
        tableCell?.isSelected = false
        
        guard let cell : MainSettingCellProtocol = tableCell as? MainSettingCellProtocol else { return }
        if cell.titleLabel?.text?.contains("metrics") ?? false {
            self.handleBackground(cell: cell, activeSegment: self.activeSegment())
        }
        if cell.titleLabel?.text == "push" {
            self.navigationController?.pushViewController(self.nextViewController, animated: true)
        }
        if cell.titleLabel?.text == "pop" {
            self.navigationController?.popViewController(animated: true)
        }
        if cell.titleLabel?.text == "popToRoot" {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func cell(_ cell: MainSettingCellProtocol, actionObject: Any, params: Dictionary<String, Any>?) {
        if MainSettingCell.cellType(cell) == .switcher {
            if cell.titleLabel?.text == "translucentAnimation" {
                self.handleTranslucentAnimation(cell: cell, activeSegment: self.activeSegment())
            }
            if cell.titleLabel?.text == "prompt" {
                self.handlePrompt(cell: cell, activeSegment: self.activeSegment())
            }
            if cell.titleLabel?.text == "hidden" {
                self.handleBarHidden(cell: cell, activeSegment: self.activeSegment())
            }
        }
        if MainSettingCell.cellType(cell) == .segment {
            self.handleSegment(cell: cell)
        }
    }
    
    func setCell(cell: MainSettingCellProtocol?, activeSegment: NNActiveSegement) {
        
        guard let cell = cell else { return }
        
        if cell.titleLabel?.text?.contains("metrics") ?? false {
            
            guard let metrics = (cell.data?["attached"] as? [String : UIBarMetrics])?["metrics"] else {
                cell.preImageView?.image = nil
                return
            }
            if activeSegment == .current {
                
                if let backgroundImage = self.navigationItem.nn_backgroundImage(for: .any, barMetrics: metrics) {
                    cell.preImageView?.image = backgroundImage
                    return
                }
                if let backgroundColor = self.navigationItem.nn_backgroundColor(for: .any, barMetrics: metrics) {
                    let backgroundImage = UIImage.nn_image(with: backgroundColor)
                    cell.preImageView?.image = backgroundImage
                    return
                }
                cell.preImageView?.image = nil
            }
            if activeSegment == .next {
                if let backgroundImage = self.nextViewController.navigationItem.nn_backgroundImage(for: .any, barMetrics: metrics) {
                    cell.preImageView?.image = backgroundImage
                    return
                }
                if let backgroundColor = self.nextViewController.navigationItem.nn_backgroundColor(for: .any, barMetrics: metrics) {
                    let backgroundImage = UIImage.nn_image(with: backgroundColor)
                    cell.preImageView?.image = backgroundImage
                    return
                }
                cell.preImageView?.image = nil
            }
            if activeSegment == .global {
                if let backgroundImage = self.navigationController?.navigationBar.nn_backgroundImage(for: .any, barMetrics: metrics) {
                    cell.preImageView?.image = backgroundImage
                    return
                }
                if let backgroundColor = self.navigationController?.navigationBar.nn_backgroundColor(for: .any, barMetrics: metrics) {
                    let backgroundImage = UIImage.nn_image(with: backgroundColor)
                    cell.preImageView?.image = backgroundImage
                    return
                }
                cell.preImageView?.image = nil
            }
        }
        if cell.titleLabel?.text == "translucentAnimation" {
            if activeSegment == .current {
                cell.switcher?.isOn = self.navigationItem.nn_backgroundTranslucentTransition
            }
            if activeSegment == .next {
                cell.switcher?.isOn = self.nextViewController.navigationItem.nn_backgroundTranslucentTransition
            }
            if activeSegment == .global {
                cell.switcher?.isOn = (self.navigationController?.navigationBar.nn_backgroundTranslucentTransition)!
            }
        }
        if cell.titleLabel?.text == "prompt" {
            if activeSegment == .current {
                cell.switcher?.isOn = !(self.promptHidden ?? true)
            }
            if activeSegment == .next {
                cell.switcher?.isOn = !(self.nextViewController.promptHidden ?? true)
            }
            if activeSegment == .global {
                cell.switcher?.isOn = !(ViewController.promptHidden)
            }
        }
        if cell.titleLabel?.text == "hidden" {
            if activeSegment == .current {
                cell.switcher?.isOn = self.barHidden ?? false
            }
            if activeSegment == .next {
                cell.switcher?.isOn = self.nextViewController.barHidden ?? false
            }
            if activeSegment == .global {
                cell.switcher?.isOn = ViewController.barHidden
            }
        }
    }
    
    func activeSegment() -> NNActiveSegement {
        let index = self.segment?.selectedSegmentIndex
        if index == 0 {
            return .current
        }
        if index == 1 {
            return .next
        }
        if index == 2 {
            return .global
        }
        return .current
    }
}

extension ViewController {
    
    func handleSegment(cell: MainSettingCellProtocol) {
        self.tableView.reloadData()
    }
    
    func handleBackground(cell: MainSettingCellProtocol, activeSegment: NNActiveSegement) {
        let vc = PickerController.init(PickerControllerType.default)
        vc.selected = {(params:[String : Any])->() in
            
            guard let metrics: UIBarMetrics = (cell.data?["attached"] as? [String : Any])?["metrics"] as? UIBarMetrics else { return }
            guard let type: PickerDataType = params["type"] as? PickerDataType else { return }
            
            if activeSegment == .current {
                self.navigationItem.setNn_backgroundImage(nil, for: metrics)
                self.navigationItem.setNn_backgroundColor(nil, for: metrics)
                if type == .image {
                    self.navigationItem.setNn_backgroundImage(params["data"] as? UIImage, for: metrics)
                    return
                }
                if type == .color {
                    self.navigationItem.setNn_backgroundColor(params["data"] as? UIColor, for: metrics)
                    return
                }
            }
            if activeSegment == .next {
                self.nextViewController.navigationItem.setNn_backgroundImage(nil, for: metrics)
                self.nextViewController.navigationItem.setNn_backgroundColor(nil, for: metrics)
                if type == .image {
                    self.nextViewController.navigationItem.setNn_backgroundImage(params["data"] as? UIImage, for: metrics)
                    return
                }
                if type == .color {
                    self.nextViewController.navigationItem.setNn_backgroundColor(params["data"] as? UIColor, for: metrics)
                    return
                }
            }
            if activeSegment == .global {
                self.navigationController?.navigationBar.setNn_backgroundImage(nil, for: metrics)
                self.navigationController?.navigationBar.setNn_backgroundColor(nil, for: metrics)
                if type == .image {
                    self.navigationController?.navigationBar.setNn_backgroundImage(params["data"] as? UIImage, for: metrics)
                    return
                }
                if type == .color {
                    self.navigationController?.navigationBar.setNn_backgroundColor(params["data"] as? UIColor, for: metrics)
                    return
                }
            }
            self.tableView.reloadData()
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    func handleTranslucentAnimation(cell: MainSettingCellProtocol, activeSegment: NNActiveSegement) {
        if activeSegment == .current {
            self.navigationItem.nn_backgroundTranslucentTransition = (cell.switcher?.isOn ?? false)
        }
        if activeSegment == .next {
            self.nextViewController.navigationItem.nn_backgroundTranslucentTransition = (cell.switcher?.isOn ?? false)
        }
        if activeSegment == .global {
            self.navigationController?.navigationBar.nn_backgroundTranslucentTransition = (cell.switcher?.isOn ?? false)
        }
    }
    
    func handlePrompt(cell: MainSettingCellProtocol, activeSegment: NNActiveSegement) {
        
        var hidden = true
        if let isOn = cell.switcher?.isOn {
            hidden = !isOn
        }
        if activeSegment == .current {
            self.promptHidden = hidden
        }
        if activeSegment == .next {
            self.nextViewController.promptHidden = hidden
        }
        if activeSegment == .global {
            ViewController.promptHidden = hidden
        }
    }
    
    func handleBarHidden(cell: MainSettingCellProtocol, activeSegment: NNActiveSegement) {
        
        var hidden = false
        if let isOn = cell.switcher?.isOn {
            hidden = isOn
        }
        if activeSegment == .current {
            self.barHidden = hidden
        }
        if activeSegment == .next {
            self.nextViewController.barHidden = hidden
        }
        if activeSegment == .global {
            ViewController.barHidden = hidden
        }
    }
    
}

