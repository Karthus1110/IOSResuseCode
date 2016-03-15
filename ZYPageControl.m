//
//  ZYPageControl.m
//  DownLoader
//
//  Created by zY on 16/2/26.
//  Copyright © 2016年 chai. All rights reserved.
//

#import "ZYPageControl.h"

@interface ZYPageControl ()
{
    UIImage *imageNormal;
    UIImage *imageCurrent;
    
    BOOL isFirstLaunch;
    
}
@end

@implementation ZYPageControl

-(instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        isFirstLaunch = YES;
        imageNormal = [UIImage imageNamed:@"rayark_page"];
        imageCurrent = [UIImage imageNamed:@"rayark_page_current"];
    }
    return self;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        isFirstLaunch = YES;
        imageNormal = [UIImage imageNamed:@"rayark_page"];
        imageCurrent = [UIImage imageNamed:@"rayark_page_current"];
    }
    return self;
}

-(void) updateDots {
    for (int i=0; i<self.subviews.count; i++) {
        UIView *view = self.subviews[i];
        CGSize size;
        size.height = 10;     //自定义圆点的大小
        size.width = 10;      //自定义圆点的大小
        [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, size.width, size.width)];
        view.layer.cornerRadius = 5;

        UIImageView *imageview = [view viewWithTag:100+i];
            if (imageview == nil) {
                UIImageView *dot = [[UIImageView alloc] initWithFrame:view.bounds];
                dot.tag = 100+i;
                [view addSubview:dot];
            }
            if (i == self.currentPage) {
                imageview.image =imageCurrent;
            }else{
                imageview.image = imageNormal;
            }
        }
}


-(void) setCurrentPage:(NSInteger)page
{
    [super setCurrentPage:page];
    [self updateDots];
}
@end
