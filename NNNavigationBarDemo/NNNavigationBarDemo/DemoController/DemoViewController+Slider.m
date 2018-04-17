//
//  DemoViewController+Slider.m
//  NNNavigationBarDemo
//
//  Created by GuHaijun on 2018/4/13.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "DemoViewController+Slider.h"
#import "NSLayoutConstraint+NNVisualFormat.h"

@implementation DemoViewController (Slider)

- (void)setupSlider {
    UIView *colorSliderContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 66)];
    self.tableView.tableFooterView = colorSliderContentView;
    
    [colorSliderContentView addSubview:self.colorAlphaCurrentLabel];
    [colorSliderContentView addSubview:self.colorAlphaMixLabel];
    [colorSliderContentView addSubview:self.colorAlphaMaxLabel];
    [colorSliderContentView addSubview:self.colorSlider];
    self.colorAlphaCurrentLabel.translatesAutoresizingMaskIntoConstraints = false;
    self.colorAlphaMixLabel.translatesAutoresizingMaskIntoConstraints = false;
    self.colorAlphaMaxLabel.translatesAutoresizingMaskIntoConstraints = false;
    self.colorSlider.translatesAutoresizingMaskIntoConstraints = false;
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint nn_constraintsWithVisualFormats:@[@"H:|-0-[colorAlphaCurrentLabel]-0-|",
                                                                                                  @"V:|-6-[colorAlphaCurrentLabel(==22)]",
                                                                                                  @"V:[colorAlphaCurrentLabel]-0-[colorAlphaMixLabel]-0-|",
                                                                                                  @"V:[colorAlphaCurrentLabel]-0-[colorAlphaMaxLabel]-0-|",
                                                                                                  @"V:[colorAlphaCurrentLabel]-0-[colorSlider]-0-|",
                                                                                                  @"H:|-0-[colorAlphaMixLabel(==44)]",
                                                                                                  @"H:[colorAlphaMaxLabel(==44)]-0-|",
                                                                                                  @"H:[colorAlphaMixLabel]-0-[colorSlider]-0-[colorAlphaMaxLabel]",
                                                                                                  ]
                                                                                          views:@{@"colorAlphaCurrentLabel" : self.colorAlphaCurrentLabel,
                                                                                                  @"colorAlphaMixLabel" : self.colorAlphaMixLabel,
                                                                                                  @"colorAlphaMaxLabel" : self.colorAlphaMaxLabel,
                                                                                                  @"colorSlider" : self.colorSlider,
                                                                                                  }]];
    
    self.colorAlphaMixLabel.text = [NSString stringWithFormat:@"%0.1f", self.colorSlider.minimumValue];
    self.colorAlphaMaxLabel.text = [NSString stringWithFormat:@"%0.1f", self.colorSlider.maximumValue];
    
    [self.colorSlider addObserver:self forKeyPath:@"value" options:NSKeyValueObservingOptionNew context:nil];
    [self.colorSlider addTarget:self action:@selector(handleColorSlider:) forControlEvents:UIControlEventValueChanged];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"value"]) {
        if (change[NSKeyValueChangeNewKey] != [NSNull null] && change[NSKeyValueChangeNewKey] != nil) {
            self.colorAlphaCurrentLabel.text = [[change objectForKey:NSKeyValueChangeNewKey] stringValue];
        }
    }
}

- (void)handleColorSlider:(UISlider *)colorSlider {
    self.colorAlphaCurrentLabel.text = @(self.colorSlider.value).stringValue;
}

- (void)dealloc {
    [self.colorSlider removeObserver:self forKeyPath:@"value"];
}

@end
