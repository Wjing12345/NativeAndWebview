//
//  DetailNativeView.m
//  wisenjoyapp
//
//  Created by wangjingmac on 2016/11/22.
//  Copyright © 2016年 wisenjoy. All rights reserved.
//

#import "DetailNativeView.h"
#import "UIFactory.h"

//宽度
#define kScreenWidth                                    [UIScreen mainScreen].bounds.size.width
//高度
#define kScreenHeight                                   [UIScreen mainScreen].bounds.size.height

#define kStatusBarHeight                                [UIApplication sharedApplication].statusBarFrame.size.height
#define kNavigationBarHeight                            44.0
#define kBottomTabBarHeight                             49.0

//导航条高度
#define kNavBarHeight                                   kNavigationBarHeight+kStatusBarHeight

#define UICOLOR_FROM_RGB(r,g,b,a)                       [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define UICOLOR_FROM_HEX(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]

#define kAppWhiteColor                                  [UIColor whiteColor]//白色
#define kAppDarkGrayColor                               [UIColor darkGrayColor]//深灰色
#define kAppGrayColor                                   [UIColor grayColor]//灰色
#define kAppBlackColor                                  [UIColor blackColor]//黑色
#define kAppMainBgColor                                 UICOLOR_FROM_RGB(240,240,240,1)

//随机颜色

#define random(r, g, b, a)                              [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#define kRandomColor                                    random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

//字体
#define UIFont_size(size)                               [UIFont systemFontOfSize:size]
#define UIFont_boldsize(size)                               [UIFont boldSystemFontOfSize:size]

@interface DetailNativeView()

//@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *topTitleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *userButton;

@end

@implementation DetailNativeView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //布局View
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews{
    
    UILabel *topTitleLabel = [UIFactory labelWithFrame:CGRectMake(20, 20, kScreenWidth - 40, 50) text:@"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈" textColor:kAppBlackColor font:UIFont_boldsize(24) bgColor:[UIColor clearColor]];
    topTitleLabel.textAlignment = NSTextAlignmentLeft;
    topTitleLabel.numberOfLines = 0;
    [self addSubview:topTitleLabel];
    self.topTitleLabel = topTitleLabel;
    
    UIImageView *headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 70+10, 20, 20)];
    headImageView.userInteractionEnabled = YES;
    headImageView.contentMode = UIViewContentModeScaleAspectFit;
    headImageView.image = [UIImage imageNamed:@"guide_img_4_1.jpg"];
    headImageView.layer.cornerRadius = 10;
    headImageView.clipsToBounds = YES;
    [self addSubview:headImageView];
    self.headImageView = headImageView;
    
    UILabel *timeLabel = [UIFactory labelWithFrame:CGRectMake(kScreenWidth-200, 70+10, 200, 20) text:@"2017-01-01" textColor:UICOLOR_FROM_HEX(0x8A8A8A) font:UIFont_size(14) bgColor:[UIColor clearColor]];
    timeLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    UILabel *contentLabel = [UIFactory labelWithFrame:CGRectMake(20, 100+25, kScreenWidth - 40, 40) text:@"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈" textColor:kAppBlackColor font:UIFont_size(16) bgColor:[UIColor clearColor]];
    contentLabel.textAlignment = NSTextAlignmentLeft;
    contentLabel.numberOfLines = 0;
    [self addSubview:contentLabel];
    self.contentLabel = contentLabel;
}

@end
