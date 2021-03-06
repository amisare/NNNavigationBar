//
//  SettingData.swift
//  NNNavigationBarDemo
//
//  Created by 顾海军 on 2019/9/20.
//  Copyright © 2019 GuHaijun. All rights reserved.
//

import UIKit

class SettingData: NSObject {
    
    var next: SettingData?
    
    lazy var metricsDefault: SettingImageBean = {
        var bean = SettingImageBean.init()
        bean.title = "metricsDefault"
        return bean;
    }()
    
    lazy var metricsCompact: SettingImageBean = {
        var bean = SettingImageBean.init()
        bean.title = "metricsCompact"
        return bean;
    }()
    
    lazy var metricsDefaultPrompt: SettingImageBean = {
        var bean = SettingImageBean.init()
        bean.title = "metricsDefaultPrompt"
        return bean;
    }()
    
    lazy var metricsCompactPrompt: SettingImageBean = {
        var bean = SettingImageBean.init()
        bean.title = "metricsCompactPrompt"
        return bean;
    }()
    
    lazy var tintColor: SettingImageBean = {
        var bean = SettingImageBean.init()
        bean.title = "tintColor"
        return bean;
    }()
    
    lazy var translucentAnimation: SettingSwitcherBean = {
        var bean = SettingSwitcherBean.init()
        bean.title = "translucentAnimation"
        bean.isOn = true;
        return bean;
    }()
    
    lazy var prompt: SettingSwitcherBean = {
        var bean = SettingSwitcherBean.init()
        bean.title = "prompt"
        return bean;
    }()
    
    lazy var hidden: SettingSwitcherBean = {
        var bean = SettingSwitcherBean.init()
        bean.title = "hidden"
        return bean;
    }()
    
    var groupBeans: [SettingGroupBean] {
        get {
            var groupBeans = [SettingGroupBean].init()
            groupBeans.append(
                SettingGroupBean.init(
                    title: "background",
                    settingBeans: [
                        metricsDefault,
                        metricsCompact,
                        metricsDefaultPrompt,
                        metricsCompactPrompt,
                    ]
                )
            )
            groupBeans.append(
                SettingGroupBean.init(
                    title: "prompt",
                    settingBeans: [
                        prompt,
                    ]
                )
            )
            groupBeans.append(
                SettingGroupBean.init(
                    title: "common operation",
                    settingBeans: [
                        tintColor,
                        translucentAnimation,
                        hidden,
                    ]
                )
            )
            return groupBeans
        }
    }
}

extension SettingData {
    
    func createNext() {
        let data = SettingData.init()
        self.next = data;
    }
    
    func removeNext() {
        self.next = nil;
    }
}
