//
//  TestWebViewController.h
//  wisenjoyapp
//
//  Created by wangjingmac on 2017/1/3.
//  Copyright © 2017年 wisenjoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestWebViewController : UIViewController

@property(nonatomic,assign)int sid;
@property(nonatomic,copy)NSString *banner;
@property(nonatomic,copy)NSString *topicTitle;
@property(nonatomic,copy)NSString *describe;
@property(nonatomic,copy)NSString *avatar;
//@property(nonatomic,copy)NSString *createUserId;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *pinyin;
@property(nonatomic,assign)NSTimeInterval updatedAt;
@property(nonatomic,assign)int type;

@end
