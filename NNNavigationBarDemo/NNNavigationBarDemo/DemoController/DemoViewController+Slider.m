//
//  DemoViewController+Slider.m
//  NNNavigationBarDemo
//
//  Created by GuHaijun on 2018/4/13.
//  Copyright © 2018年 GuHaijun. All rights reserved.
//

#import "DemoViewController+Slider.h"

@implementation DemoViewController (Slider)

- (void)setupSlider {
    UIView *colorSliderContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 66)];
    
    [colorSliderContentView addSubview:self.colorAlphaCurrentLabel];
    self.colorAlphaCurrentLabel.frame = CGRectMake(0,
                                                   0,
                                                   self.view.bounds.size.width,
                                                   22);
    [colorSliderContentView addSubview:self.colorAlphaMixLabel];
    self.colorAlphaMixLabel.frame = CGRectMake(0,
                                               self.colorAlphaCurrentLabel.frame.origin.y +
                                               self.colorAlphaCurrentLabel.frame.size.height,
                                               44,
                                               44);
    [colorSliderContentView addSubview:self.colorAlphaMaxLabel];
    self.colorAlphaMaxLabel.frame = CGRectMake(self.colorAlphaCurrentLabel.frame.size.width - 44,
                                               self.colorAlphaCurrentLabel.frame.origin.y +
                                               self.colorAlphaCurrentLabel.frame.size.height,
                                               44,
                                               44);
    [colorSliderContentView addSubview:self.colorSlider];
    self.colorSlider.frame = CGRectMake(self.colorAlphaMixLabel.frame.size.width,
                                        self.colorAlphaCurrentLabel.frame.origin.y +
                                        self.colorAlphaCurrentLabel.frame.size.height,
                                        self.colorAlphaCurrentLabel.frame.size.width -
                                        self.colorAlphaMixLabel.frame.size.width -
                                        self.colorAlphaMaxLabel.frame.size.width,
                                        44);
    
    self.tableView.tableFooterView = colorSliderContentView;
    
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
