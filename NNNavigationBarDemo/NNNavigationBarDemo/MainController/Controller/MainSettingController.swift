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
    
    var currentSettingData: SettingData!
    
    var nextSettingData: SettingData {
        let settingData = self.currentSettingData.next
        if settingData == nil {
            self.currentSettingData.createNext()
        }
        return self.currentSettingData.next!
    }
    
    var globalSettingData: SettingData!
    
    var settingData: SettingData {
        switch self.currentSettingData.segment.selectedIndex {
        case .current:
            return self.currentSettingData
        case .next:
            return self.nextSettingData
        case .global:
            return self.globalSettingData
        }
    }
    
    lazy var tableView: UITableView = {
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
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let constraints: Array<NSLayoutConstraint> =
            NSLayoutConstraint.nn_constraints(withVisualFormats: ["H:|[tableView]|",
                                                                  "V:|[tableView]|"],
                                              views: ["tableView" : tableView]);
        NSLayoutConstraint.activate(constraints)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupDate()
        self.tableView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.currentSettingData.segment.selectedIndex = .current
    }
    
    @objc public func pushNextViewController() {
        let vc = MainSettingController.init();
        vc.currentSettingData = self.nextSettingData
        vc.globalSettingData = self.globalSettingData
        vc.page = self.page + 1
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func colorfulPick(type: ColorfulDataType, indexPath: IndexPath) {
        guard let settingBean = self.settingData.groupBeans[indexPath.section].settingBeans[indexPath.row] as? SettingImageBean else { return }
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
}

extension MainSettingController {
    
    func setupDate() {
        self.setupNavigationItemBackground()
        self.setupNavigationItemTintColor()
        self.setupNavigationBarTintColor()
        self.setupNavigationBarHiddenState()
        self.setupNavigationItemPrompt()
    }
    
    func updateState() {
        self.setupNavigationItemBackground()
        self.setupNavigationBarTintColor()
        self.setupNavigationBarHiddenState()
        self.tableView.reloadData()
    }
    
    func setupNavigationItemBackground() {
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
    }
    
    func setupNavigationItemTintColor() {
        if let color = self.currentSettingData.tintColor.color {
            self.navigationItem.nn_tintColor = color
        }
    }
    
    func setupNavigationBarTintColor() {
        if let color = self.globalSettingData.tintColor.color {
            self.navigationController?.navigationBar.nn_tintColor = color
        }
    }
    
    func setupNavigationItemPrompt() {
        self.navigationItem.prompt = self.currentSettingData.prompt.isOn ? "Navigation Bar Prompt" : nil
    }
    
    func setupNavigationBarHiddenState() {
        self.navigationController?.setNavigationBarHidden(self.currentSettingData.hidden.isOn, animated: true)
    }
}

extension MainSettingController: UITableViewDataSource, UITableViewDelegate, MainSettingCellDelegate {
    
    //MARK: UITableViewDataSource, UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        let data = self.settingData.groupBeans
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settingData.groupBeans[section].settingBeans.count
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
        return self.settingData.groupBeans[section].title
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return MainSettingHeaderCell.init().cellHeight
        }
        return 44;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let settingBean = self.settingData.groupBeans[indexPath.section].settingBeans[indexPath.row];
        var cell = MainSettingCellFactory.cell(settingBean: settingBean)
        if settingBean is SettingSegmentBean {
            cell?.bean = self.currentSettingData.segment
        }
        else {
            cell?.bean = settingBean
        }
        cell?.delegate = self
        return cell! as! UITableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let tableCell = tableView.cellForRow(at: indexPath)
        tableCell?.isSelected = false

        guard let cell: MainSettingCellProtocol = tableCell as? MainSettingCellProtocol else { return }
        if cell.bean is SettingImageBean {
            if cell.bean?.title == "tintColor" {
                self.colorfulPick(type: ColorfulDataType.color, indexPath: indexPath)
            }
            else {
                self.colorfulPick(type: ColorfulDataType.default, indexPath: indexPath)
            }
        }
        if cell.bean?.title == "push" {
            self.pushNextViewController()
        }
        if cell.bean?.title == "pop" {
            self.navigationController?.popViewController(animated: true)
        }
        if cell.bean?.title == "popToRoot" {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }

    //MARK: MainSettingCellDelegate
    func cell(_ cell: MainSettingCellProtocol, actionObject: Any, params: Dictionary<String, Any>?) {
        if cell.bean is SettingSwitcherBean {
            self.updateState()
        }
        if cell.bean is SettingSegmentBean {
            self.updateState()
        }
    }
}