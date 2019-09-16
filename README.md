<p align="center" >
  <img src="https://raw.githubusercontent.com/amisare/Logos/master/NNNavigationBar/Original/horizontal-color.png" width="509" height="124" alt="NNNavigationBar" title="NNNavigationBar">
</p>

[![GitHub release](https://img.shields.io/github/release/amisare/NNNavigationBar.svg)](https://github.com/amisare/NNNavigationBar/releases)
[![CocoaPods](https://img.shields.io/cocoapods/v/NNNavigationBar.svg)](https://cocoapods.org/pods/NNNavigationBar)
[![CocoaPods](https://img.shields.io/cocoapods/p/NNNavigationBar.svg)](https://cocoapods.org/pods/NNNavigationBar)
[![GitHub license](https://img.shields.io/github/license/amisare/NNNavigationBar.svg)](https://github.com/amisare/NNNavigationBar/blob/master/LICENSE)

本库用于实现UINavigationBar背景渐变过渡动画。

## 可能会遇到的问题

<details>
<summary><mark>UINavigationBar 上的一个系统 bug （ An apple bug on the UINavigationBar）</mark></summary>
<p></p>

<blockquote>

bug 描述：导航右滑返回手势，概率性的导致返回以后页面的 rightBarButtonItem 的 tintColor 颜色变浅， bug 现象如下：

![wx20181226-142113](https://user-images.githubusercontent.com/6335968/50435206-3f2a1400-091b-11e9-9ce7-7e9ba1f10acb.png)

bug 代码：

- 在 viewDidLoad 中设置 rightBarButtonItem 会导致 bug 产生。bug 是概率性发生的，不易复现。

```
    override func viewDidLoad() {
        super.viewDidLoad()

        // 在 viewDidLoad 中设置 rightBarButtonItem
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Next", style: .plain, target: self, action: #selector(pushNextViewController))
        self.view.backgroundColor = UIColor.white
        self.title = "Title" + " " + "\(self.page)"
    }

    @objc public func pushNextViewController() {
        let vc = self.nextViewController;
        vc.page = self.page + 1
        self.navigationController?.pushViewController(vc, animated: true)
    }
```

bug 解决：

- 在 viewWillAppear 中设置 rightBarButtonItem 。

```
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // 将 rightBarButtonItem 设置移至 viewWillAppear
       // self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Next", style: .plain, target: self, action: #selector(pushNextViewController))
        self.view.backgroundColor = UIColor.white
        self.title = "Title" + " " + "\(self.page)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       // 在 viewWillAppear 中设置 rightBarButtonItem
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Next", style: .plain, target: self, action: #selector(pushNextViewController))
    }
    
    @objc public func pushNextViewController() {
        let vc = self.nextViewController;
        vc.page = self.page + 1
        self.navigationController?.pushViewController(vc, animated: true)
    }
```

bug 工程源码：[UINavigationBarBug](https://github.com/amisare/UINavigationBarBug)

</blockquote>
</details>


## 效果

![ColorTransition](https://raw.githubusercontent.com/amisare/Screenshots/master/NNNavigationBar/Screenshots_00.gif)
![ImageTransition](https://raw.githubusercontent.com/amisare/Screenshots/master/NNNavigationBar/Screenshots_01.gif)

## 介绍

NNNavigationBar是实现导航条背景渐变过渡动画的轻量级代码库。

#### 实现

- 代码库通过Category/Method Swizzling方式hook UINavigationBar的方法调用，实现导航条背景渐变过渡动画。

#### 轻量

- 仅对UINavigationBar进行了Method Swizzling方法混淆。不涉及其它类的方法混淆，如UIViewController、UINavigationController等。
- 仅对UINavigationBar/UINavigationItem进行了必要的属性关联。

#### 原理
         
```


                              UINavigationItem (category_xxx)
                                           |
                                           |
                                           V
                                           ①  
                                     add [.nn_xxx]
                                           |                         UIViewController
                                           |  ------------------->  [.navigationItem]
                                                                             |
                                                                             |
                                                                             V
                                                                             ② 
                                                               set vcn.navigationItem.nn_xxx
                                                                             |
                                                                             |
                                                                             |
                                 UINavigationController                      V
                                       vc stack                              ③            
                                 |        vcn        | <----- navigationController push/pop vcn
                                 |        ...        |                       |
                                 |        vc1        |                       |
                                 |        vc0        |                       |          
                                                                             |
     UINavigationBar                                                         |
-----------------------                                                      |
| <——    title        |                                                      |
-----------------------                                                      |
           |                                                                 |
           |                     UINavigationBar.Items                       V
           |        ④-②              item stack                           ④-①
           |<--- update Bar --- | vcn.navigationItem | <--- navigationBar push/pop vcn.navigationItem
           |          |         |        ...         |                       |
           |          |         | vc2.navigationItem |                       |
           |          |         | vc1.navigationItem |                       |
           |          |         | vc0.navigationItem |                       |
           |          |                                                      |
           |          |                        ④-③                          |
           |          |--------------------->  hook  <-----------------------|
           |                                    |
           |                                    |
           |                                    |
           |             ⑤                     |
           |<--- update Bar [.nn_xx] -----------|
                                                      
```

1. 使用runtime在UINavigationItem的Category中添加属性[.nn_xx]。
2. 每个UIViewController中都拥有一个UINavigationItem属性navigationItem，在UIViewController中修改navigationItem对象的属性[.nn_xx]。
3. 在UINavigationController push/pop UIViewController时，会将UIViewController的navigationItem对象 push/pop 给UINavigationBar。
4. 通过Method Swizzling方式hook UINavigationBar方法调用，获得对应方法的调用时机。
5. 在合适的时刻，UINavigationBar取得navigationItem对象中的属性[.nn_xx]，更新UINavigationBar状态（本代码库实现了背景的平滑渐变过渡）。

## 使用

1. 导入头文件

```
#import "NNNavigationBar.h"
```

2. 颜色渐变过渡

```
- (void)viewDidLoad {
    [super viewDidLoad];
    // 去除系统背景
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    // 显示自定义背景
    self.navigationController.navigationBar.nn_backgroundViewHidden = false;
    // 设置背景颜色
    self.navigationItem.nn_backgroundColor = [UIColor orangeColor];
}
```

3. 图片渐变过渡

```
- (void)viewDidLoad {
    [super viewDidLoad];
    // 去除系统背景
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    // 显示自定义背景
    self.navigationController.navigationBar.nn_backgroundViewHidden = false;
    // 设置背景图片
    self.navigationItem.nn_backgroundImage = [UIImage imageNamed:xx_image];
}
```

4. 更多使用，详见demo


## 安装

### CocoaPods

安装最新版的 CocoaPods：

```bash
$ gem install cocoapods
```

在 `podfile` 中添加：

```ruby
pod 'NNNavigationBar', '~> 2.7.0'
```

然后在终端执行：

```bash
$ pod install
```

如安装失败，提示：

```bash
[!] Unable to find a specification for `NNNavigationBar`
```

尝试使用命令：

```bash
pod install --repo-update
```

## 系统要求

- iOS 8.0+

## 鸣谢

- Logo designed by [anharismail](https://github.com/anharismail)

## 许可证

NNNavigationBar 是基于 MIT 许可证下发布的，详情参见 LICENSE。
