//
//  LYMaskView.m
//  DownLoader
//
//  Created by zY on 16/3/1.
//  Copyright © 2016年 chai. All rights reserved.
//

#import "LYMaskView.h"

@implementation LYMaskView

+ (LYMaskView *)shareMasksView
{
    static LYMaskView *masksview = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        masksview = [[LYMaskView alloc] init];
    });
    return masksview;
}


- (instancetype)init
{
    CGRect frame = [UIScreen mainScreen].bounds;
    self = [super initWithFrame:frame];
    return self;
}
@end
