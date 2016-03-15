//
//  ZYActivityIndicatorView.m
//  DownLoader
//
//  Created by zY on 16/3/8.
//  Copyright © 2016年 chai. All rights reserved.
//  没有遮盖的加载指示器

#import "ZYActivityIndicatorView.h"
#import "Masonry.h"
#import "LYMaskView.h"
#import "Common.h"

@interface ZYActivityIndicatorView()
{
    UIView *_indicatorView;
}
@end

@implementation ZYActivityIndicatorView

+(ZYActivityIndicatorView *)sharedIndicator
{
    static ZYActivityIndicatorView *indicator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        indicator = [[ZYActivityIndicatorView alloc] init];
//        indicator.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];

    });
    return indicator;
}


-(void)initUI
{

}

-(void)showIndicatorInView:(UIView *)view
{
//    LYMaskView *mask = [LYMaskView shareMasksView];
    
    _indicatorView = [[UIView alloc] init];
    _indicatorView.layer.cornerRadius = 10;
    _indicatorView.backgroundColor = RGBColor(20, 20, 20, 1);
    [view addSubview:_indicatorView];
    
    [_closeButton setImage:[UIImage imageNamed:@"btn_close"] forState:UIControlStateNormal];
    _closeButton.backgroundColor = [UIColor grayColor];
//    [indicatorView addSubview:_closeButton];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] init];
    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    indicator.layer.cornerRadius = 10;
    indicator.backgroundColor = RGBColor(20, 20, 20, 1);
    [_indicatorView addSubview:indicator];
    [indicator startAnimating];
    
//    UILabel *label = [[UILabel alloc] init];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.text = @"maotukeng";
//    [indicatorView addSubview:label];
    
    [_indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view.mas_centerX);
        make.centerY.equalTo(view.mas_centerY);
        make.width.equalTo(@100);
        make.height.equalTo(@100);
    }];
    
    [indicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_indicatorView);
        make.top.equalTo(_indicatorView.mas_top).offset(1);
        make.width.equalTo(_indicatorView.mas_width);
        make.height.equalTo(@100);
    }];
    
//    [_closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(indicatorView.mas_centerX);
//        make.top.equalTo(indicator.mas_bottom).offset(-3);
//        make.width.equalTo(@30);
//        make.height.equalTo(@30);
//    }];
    
    
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(indicatorView.mas_centerX);
//        make.top.equalTo(indicator.mas_bottom).offset(5);
//    }];
    
//    [view addSubview:mask];
}

-(void)hideIndicatorInView:(UIView *)view
{
//    LYMaskView *mask = [LYMaskView shareMasksView];
    if ([view.subviews containsObject:_indicatorView]) {
        [_indicatorView removeFromSuperview];
    }else return;
}

@end
