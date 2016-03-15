//
//  LYPopView.h
//  DownLoader
//
//  Created by zY on 16/3/1.
//  Copyright © 2016年 chai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYPopView : UIView

@property (nonatomic, strong) UITextField *txtField;
@property (nonatomic, strong) NSString *message;
+(LYPopView *)sharedPopView;
-(void)showPopView;


@end
