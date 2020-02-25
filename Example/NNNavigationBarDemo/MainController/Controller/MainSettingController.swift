//
//  MainSettingController.swift
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

class MainSettingController: UIViewController {
    
    var page = 0
    
    var headerBean: SettingHeaderBean = SettingHeaderBean.init(title: "", image: #imageLiteral(resourceName: "horizontal-color"))
    var segmentBean: SettingSegmentBean = SettingSegmentBean.init(title: "", selectedIndex: .current)
    var actionBeans: [SettingBean] = [
        SettingBean.init(title: "push"),
        SettingBean.init(title: "pop"),
        SettingBean.init(title: "popToRoot"),
    ]
    var headGroupBeans: [SettingGroupBean] {
        return [
            SettingGroupBean.init( title: "header", settingBeans: [headerBean]),
            SettingGroupBean.init( title: "segment", settingBeans: [segmentBean])
        ]
    }
    var tailGroupBeans: [SettingGroupBean] {
        return [
            SettingGroupBean.init( title: "header", settingBeans: actionBeans)
        ]
    }
    
    var currentSettingData: SettingData!
    var nextSettingData: SettingData {
        let settingData = self.currentSettingData.next
        if settingData == nil {
            self.currentSettingData.createNext()
        }
        return self.currentSettingData.next!
    }
    var globalSettingData: SettingData!
    
    var settingGroupBeans: [SettingGroupBean] {
        switch self.segmentBean.selectedIndex {
        case .current:
            return headGroupBeans + self.currentSettingData.groupBeans + tailGroupBeans
        case .next:
            return headGroupBeans + self.nextSettingData.groupBeans + tailGroupBeans
        case .global:
            return headGroupBeans + self.globalSettingData.groupBeans + tailGroupBeans
        }
    }
    
    lazy var optionTableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: .grouped)
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 0.0
        tableView.estimatedSectionHeaderHeight = 0.0
        tableView.estimatedSectionFooterHeight = 0.0
        tableView.sectionFooterHeight = 0.01
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.init(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage.init()
        self.navigationController?.navigationBar.nn_backgroundViewHidden = false;
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Next", style: .plain, target: self, action: #selector(pushNextViewController))
        
        self.title = "Title" + " " + "\(self.page)"
        
        view.addSubview(optionTableView)
        optionTableView.translatesAutoresizingMaskIntoConstraints = false
        let constraints: Array<NSLayoutConstraint> =
            NSLayoutConstraint.nn_constraints(withVisualFormats: ["H:|[tableView]|",
                                                                  "V:|[tableView]|"],
                                              views: ["tableView" : optionTableView]);
        NSLayoutConstraint.activate(constraints)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupDate()
    }
    
    @objc public func pushNextViewController() {
        self.segmentBean.selectedIndex = .current
        let vc = MainSettingController.init();
        vc.currentSettingData = self.nextSettingData
        vc.globalSettingData = self.globalSettingData
        vc.page = self.page + 1
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainSettingController {
    
    func setupDate() {
        self.setupNavigationItemPrompt()
        updateState()
    }
    
    func updateState() {
        self.navigationItem.setNn_backgroundImage(nil, for: UIBarMetrics.default)
        self.navigationItem.setNn_backgroundColor(nil, for: UIBarMetrics.default)
        if let image = self.currentSettingData.metricsDefault.image {
            self.navigationItem.setNn_backgroundImage(image, for: UIBarMetrics.default)
        }
        if let color = self.currentSettingData.metricsDefault.color {
            self.navigationItem.setNn_backgroundColor(color, for: UIBarMetrics.default)
        }
        
        self.navigationItem.setNn_backgroundImage(nil, for: UIBarMetrics.compact)
        self.navigationItem.setNn_backgroundColor(nil, for: UIBarMetrics.compact)
        if let image = self.currentSettingData.metricsCompact.image {
            self.navigationItem.setNn_backgroundImage(image, for: UIBarMetrics.compact)
        }
        if let color = self.currentSettingData.metricsCompact.color {
            self.navigationItem.setNn_backgroundColor(color, for: UIBarMetrics.compact)
        }
        
        self.navigationItem.setNn_backgroundImage(nil, for: UIBarMetrics.defaultPrompt)
        self.navigationItem.setNn_backgroundColor(nil, for: UIBarMetrics.defaultPrompt)
        if let image = self.currentSettingData.metricsDefaultPrompt.image {
            self.navigationItem.setNn_backgroundImage(image, for: UIBarMetrics.defaultPrompt)
        }
        if let color = self.currentSettingData.metricsDefaultPrompt.color {
            self.navigationItem.setNn_backgroundColor(color, for: UIBarMetrics.defaultPrompt)
        }
        
        self.navigationItem.setNn_backgroundImage(nil, for: UIBarMetrics.compactPrompt)
        self.navigationItem.setNn_backgroundColor(nil, for: UIBarMetrics.compactPrompt)
        if let image = self.currentSettingData.metricsCompactPrompt.image {
            self.navigationItem.setNn_backgroundImage(image, for: UIBarMetrics.compactPrompt)
        }
        if let color = self.currentSettingData.metricsCompactPrompt.color {
            self.navigationItem.setNn_backgroundColor(color, for: UIBarMetrics.compactPrompt)
        }
        
        // ItemTintColor
        if let color = self.currentSettingData.tintColor.color {
            self.navigationItem.nn_tintColor = color
        }
        
        // BackgroundTranslucentTransition
        self.navigationController?.navigationBar.nn_backgroundTranslucentTransition = self.currentSettingData.translucentAnimation.isOn
        
        // NavigationBarTintColor
        if let color = self.globalSettingData.tintColor.color {
            self.navigationController?.navigationBar.nn_tintColor = color
        }
        
        // NavigationBarHidden
        self.navigationController?.setNavigationBarHidden(self.currentSettingData.hidden.isOn, animated: true)
        
        // OptionTableView reload
        self.optionTableView.reloadData()
    }
    
    func setupNavigationItemPrompt() {
        self.navigationItem.prompt = self.currentSettingData.prompt.isOn ? "Navigation Bar Prompt" : nil
    }
}

extension MainSettingController: UITableViewDataSource, UITableViewDelegate, MainSettingCellDelegate {
    
    //MARK: UITableViewDataSource, UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.settingGroupBeans.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settingGroupBeans[section].settingBeans.count
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
        return self.settingGroupBeans[section].title
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return MainSettingHeaderCell.cellHeight
        }
        return 44;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let settingBean = self.settingGroupBeans[indexPath.section].settingBeans[indexPath.row]
        var cell = MainSettingCellFactory.cell(settingBean: settingBean, indexPath: indexPath)
        cell?.delegate = self
        return cell! as! UITableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tableCell = tableView.cellForRow(at: indexPath)
        tableCell?.isSelected = false
        
        let settingBean = self.settingGroupBeans[indexPath.section].settingBeans[indexPath.row]

        // 选择图片或颜色
        if let settingBean = settingBean as? SettingImageBean {
            let type: ColorfulDataType = settingBean.title == "tintColor" ? .color : .default;
            let vc = ColorfulPickerController.init(type)
            vc.selected = {(bean: ColorfulBeanProtocol?)->() in
                guard let bean = bean else { return }
                settingBean.image = nil
                settingBean.color = nil
                if bean is ColorfulImageBean {
                    settingBean.image = (bean as? ColorfulImageBean)?.image
                }
                if bean is ColorfulColorBean {
                    settingBean.color = (bean as? ColorfulColorBean)?.color
                }
                self.updateState()
            }
            self.present(vc, animated: true, completion: nil)
        }
        
        // controller 操作
        if settingBean.title == "push" {
            self.pushNextViewController()
        }
        if settingBean.title == "pop" {
            self.navigationController?.popViewController(animated: true)
        }
        if settingBean.title == "popToRoot" {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }

    //MARK: MainSettingCellDelegate
    func cell(_ cell: MainSettingCellProtocol) {
        guard let indexPath = cell.indexPath else { return }
        let settingBean = self.settingGroupBeans[indexPath.section].settingBeans[indexPath.row]
        
        // switch 切换
        if let settingBean = settingBean as? SettingSwitcherBean {
            settingBean.isOn = (cell as! MainSettingSwitcherCell).switcher.isOn
            self.updateState()
        }
        
        // segment 切换，不需要更新状态
        if let settingBean = settingBean as? SettingSegmentBean {
            let segmentIndex = (cell as! MainSettingSegmentCell).segment.selectedSegmentIndex
            settingBean.selectedIndex = SettingSegmentIndexBean.init(rawValue: segmentIndex) ?? .current
            self.updateState()
        }
    }
}
