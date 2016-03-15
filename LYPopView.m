//
//  LYPopView.m
//  DownLoader
//
//  Created by zY on 16/3/1.
//  Copyright © 2016年 chai. All rights reserved.
//

#import "LYPopView.h"
#import "Common.h"
#import "Masonry.h"
#import "LYMaskView.h"
#import <CoreText/CoreText.h>

@implementation LYPopView
+(LYPopView *)sharedPopView
{
    static LYPopView *pop = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pop = [[LYPopView alloc] init];
    });
    return pop;
}

-(void)showPopView
{
    
    if ([[UIApplication sharedApplication].keyWindow.subviews containsObject:self]) {
        [self removeFromSuperview];
    }
    LYMaskView *masksview = [LYMaskView shareMasksView];
    if ([[UIApplication sharedApplication].keyWindow.subviews containsObject:masksview]) {
        [masksview removeFromSuperview];
        masksview.frame = [UIScreen mainScreen].bounds;
    }
    [[UIApplication sharedApplication].keyWindow addSubview:masksview];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(@(0));
        make.width.equalTo(self.superview.mas_width);
        make.height.equalTo(self.superview.mas_height);
    }];

    UIView *baseView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    baseView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.1];
    [self addSubview:baseView];
    
    UIView *centerView = [[UIView alloc] init];
    centerView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
//    centerView.backgroundColor = [UIColor redColor];
//    centerView.backgroundColor = kHomeBackColor;
    centerView.layer.cornerRadius = 3;
    [baseView addSubview:centerView];
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(baseView.mas_left).offset(30);
        make.right.equalTo(baseView.mas_right).offset(-30);
        make.height.equalTo(centerView.mas_width);
        make.centerY.equalTo(baseView.mas_centerY).offset(-30);
        
    }];
    if (iPhone6Plus) {
        [centerView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(baseView.mas_left).offset(50);
            make.right.equalTo(baseView.mas_right).offset(-50);
            make.height.equalTo(centerView.mas_width);
            make.centerY.equalTo(baseView.mas_centerY).offset(-30);
        }];
    }
    
    UIView *modifyView = [[UIView alloc] init];
    modifyView.backgroundColor = kHomeBackColor;
//    modifyView.backgroundColor = [UIColor whiteColor];
    [centerView addSubview:modifyView];
    [modifyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(centerView.mas_top).offset(4);
        make.bottom.equalTo(centerView.mas_bottom).offset(-4);
        make.right.equalTo(centerView.mas_right).offset(-4);
        make.left.equalTo(centerView.mas_left).offset(4);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"CHANGE THE NICKNAME";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = kTitleFont30;
    [modifyView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iPhone5) {
            make.top.equalTo(modifyView.mas_top).offset(10);
        }
        if (iPhone4) {
            make.top.equalTo(modifyView.mas_top).offset(5);
        }else{
            make.top.equalTo(modifyView.mas_top).offset(30);
        }
        make.centerX.equalTo(modifyView.mas_centerX);
    }];
    
    UILabel *subtitleLabel = [[UILabel alloc] init];
    subtitleLabel.text = @"修改昵称";
    subtitleLabel.textColor = [UIColor whiteColor];
    subtitleLabel.font = UISystemFont(16);
    [modifyView addSubview:subtitleLabel];
    [subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom);
        make.centerX.equalTo(modifyView.mas_centerX);
    }];
    
    
    UILabel *nickENLabel = [[UILabel alloc] init];
    nickENLabel.text = @"NICKNAME";
    nickENLabel.font = kTitleFont30;
    nickENLabel.textColor = [UIColor whiteColor];
    [modifyView addSubview:nickENLabel];
    [nickENLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(modifyView.mas_centerY).offset(-10);
        if (iPhone5) {
            make.left.equalTo(modifyView.mas_left).offset(10);
        }if (iPhone4) {
            make.left.equalTo(modifyView.mas_left).offset(5);
        }else{
            make.left.equalTo(modifyView.mas_left).offset(20);
        }
    }];
    
    UILabel *nickCNLabel = [[UILabel alloc] init];
    nickCNLabel.text = @"昵称";
    nickCNLabel.font = UISystemFont(16);
    nickCNLabel.textColor = [UIColor whiteColor];
//    nickCNLabel.backgroundColor = [UIColor redColor];
    [modifyView addSubview:nickCNLabel];
    [nickCNLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nickENLabel.mas_bottom);
        make.left.equalTo(nickENLabel.mas_left);
    }];
    
    self.txtField = [[UITextField alloc] init];
    self.txtField.textColor = [UIColor whiteColor];
    self.txtField.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    self.txtField.textAlignment = NSTextAlignmentCenter;
    self.txtField.text = _message;
    [modifyView addSubview:self.txtField];
    [self.txtField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(modifyView.mas_centerY);
        make.left.equalTo(nickENLabel.mas_right).offset(5);
        make.width.greaterThanOrEqualTo(@50);
        make.right.equalTo(modifyView.mas_right).offset(-10);
        make.height.equalTo(@30);
    }];
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setImage:[UIImage imageNamed:@"btn_cancle"] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(cancleAction) forControlEvents:UIControlEventTouchUpInside];
    [modifyView addSubview:cancleBtn];
    
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(modifyView.mas_bottom).offset(-30);
        make.left.equalTo(modifyView.mas_left).offset(30);
        make.width.equalTo(@70);
        make.height.equalTo(@25);
    }];
    
    UIButton *modifyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [modifyBtn setImage:[UIImage imageNamed:@"btn_modify"] forState:UIControlStateNormal];
    modifyBtn.imageView.contentMode =UIViewContentModeScaleAspectFill;
    [modifyBtn addTarget:self action:@selector(modifyAction) forControlEvents:UIControlEventTouchUpInside];
    [modifyView addSubview:modifyBtn];
    [modifyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(modifyView.mas_bottom).offset(-30);
        make.right.equalTo(modifyView.mas_right).offset(-30);
        make.width.equalTo(@70);
        make.height.equalTo(@25);
    }];
    
    
}

-(void)hidden
{
    if ([[UIApplication sharedApplication].keyWindow.subviews containsObject:self]) {
        [self removeFromSuperview];
    }
    LYMaskView *masksview = [LYMaskView shareMasksView];
    if ([[UIApplication sharedApplication].keyWindow.subviews containsObject:masksview]) {
        [masksview removeFromSuperview];
    }
}

-(void)cancleAction
{
    [self hidden];
}

-(void)modifyAction
{
    NSLog(@"--------------");
    [self hidden];
}

@end
