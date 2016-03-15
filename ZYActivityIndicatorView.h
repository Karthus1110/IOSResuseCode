//
//  ZYActivityIndicatorView.h
//  DownLoader
//
//  Created by zY on 16/3/8.
//  Copyright © 2016年 chai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYActivityIndicatorView : UIActivityIndicatorView
@property (nonatomic, strong) UIButton *closeButton;
+(ZYActivityIndicatorView *)sharedIndicator;
-(void)showIndicatorInView:(UIView *)view;
-(void)hideIndicatorInView:(UIView *)view;

@end
