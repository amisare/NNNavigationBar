# NNNavigationBar

本库用于实现UINavigationBar背景过度动画。

## 效果

![ColorTransition](https://raw.githubusercontent.com/amisare/NNNavigationBar/master/Screenshots/2018-04-13%2000_00_57.gif)
![ImageTransition](https://raw.githubusercontent.com/amisare/NNNavigationBar/master/Screenshots/2018-04-13%2000_02_50.gif)

## 介绍

NNNavigationBar是实现导航条背景过度动画的轻量级代码库。

#### 实现

- 代码库通过Category/Method Swizzling方式hook UINavigationBar的方法调用，实现导航条背景过度动画。

#### 轻量

- 仅对UINavigationBar进行了Method Swizzling方法混淆。不涉及其它类的方法混淆，如UIViewController、UINavigationController等。
- 仅对UINavigationBar/UINavigationItem进行了必要的属性关联。

#### 原理
         
```


                                   UINavigationItem (category_xxx)
                                                |
                                            ①  |
                                         add [.nn_xxx]
                                                |
                                                |                                          UIViewController
                                                |  ------------------------------------->  [.navigationItem]
                                                                                                  |
                                                                                                  |
                                                                                           ②     |
                                                                                       set vcn.navigationItem.nn_xxx
                                                                                                  |
                                                                                                  |
                                     UINavigationController                                       |
                                           vc stack                                 ③            V
                                     |        vcn        | <------ navigationController push/pop vcn
                                     |        ...        |                          |
                                     |        vc1        |                          |
                                     |        vc0        |                          |          
                                                                                    |
     UINavigationBar                                                                |
-----------------------                                                             |
| <——    title        |                                                             |
-----------------------                                                             |
           |                                                                        |
           |                         UINavigationBar.Items                          |
           |                               item stack                               V
           |<----- update Bar ------ | vcn.navigationItem | <------ navigationBar push/pop vcn.navigationItem
           |          ④-②           |        ...         |                       ④-①
           |            |            | vc2.navigationItem |                         |
           |            |            | vc1.navigationItem |                         |
           |            |            | vc0.navigationItem |                         |
           |            |                                                           |
           |            |                           ④-③                            |
           |            |------------------------>  hook  <-------------------------|
           |                                          |
           |                                          |
           |                                          |
           |             ⑤                           |
           |<------ update Bar [.nn_xx] --------------|
                                                      
```

1. 使用runtime在UINavigationItem的Category中添加属性[.nn_xx]。
2. 每个UIViewController中都拥有一个UINavigationItem属性navigationItem，在UIViewController中修改navigationItem对象的属性[.nn_xx]。
3. 在UINavigationController push/pop UIViewController时，会将UIViewController的navigationItem对象 push/pop 给UINavigationBar。
4. 通过Method Swizzling方式hook UINavigationBar方法调用，获得对应方法的调用时机。
5. 在合适的时刻，UINavigationBar取得navigationItem对象中的属性[.nn_xx]，更新UINavigationBar状态（本代码库实现了背景的平滑过度）。

## 使用

1. 导入头文件

```
#import "NNNavigationBar.h"
```

2. 颜色过度

```
- (void)viewDidLoad {
    [super viewDidLoad];
    // 背景显示
    self.navigationController.navigationBar.nn_backgroundViewHidden = false;
    // 设置背景颜色
    self.navigationItem.nn_backgroundColor = [UIColor orangeColor];
}
```

3. 图片过度

```
- (void)viewDidLoad {
    [super viewDidLoad];
    // 背景显示
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
pod 'NNNavigationBar'
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

## 许可证

NNNavigationBar 是基于 MIT 许可证下发布的，详情参见 LICENSE。
