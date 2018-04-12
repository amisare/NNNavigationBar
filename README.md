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

1. 在UINavigationController进行push/pop操作时会把UIViewController的UINavigationItem属性'vc.navigationItem'传递给UINavigationBar，为UINavigationBar提供UIViewController的相关数据，如UINavigationBar的title值。
2. 在UINavigationItem中添加当前UINavigationBar背景属性，在执行push操作时通过UINavigationItem将背景属性传递到UINavigationBar修改背景，实现不同背景的切换。
3. 通过Method Swizzling方式hook UINavigationBar方法调用实现背景过度。

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

你可以用以下命令来安装最新版的 CocoaPods：

```bash
$ gem install cocoapods
```

在 `podfile` 中添加以下代码：

```ruby
pod 'NNNavigationBar'
```

然后在终端运行以下命令：

```bash
$ pod install
```

## 系统要求

- iOS 8.0+

## 许可证

NNNavigationBar 是基于 MIT 许可证下发布的，详情参见 LICENSE。
