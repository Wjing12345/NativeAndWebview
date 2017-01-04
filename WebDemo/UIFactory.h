//
//  UIFactory.h
//  wisenjoyapp
//
//  Created by 范东 on 16/9/26.
//  Copyright © 2016年 wisenjoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIFactory : NSObject

+ (UIView *)viewWithFrame:(CGRect)frame bgColor:(UIColor *)bgColor;

+ (UILabel *)labelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font bgColor:(UIColor *)bgColor;

+ (UITextView *)textViewWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font bgColor:(UIColor *)bgColor;

+ (UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)font titleColorNormal:(UIColor *)titleColorNormal bgImageNormal:(UIImage *)bgImageNormal bgImageHighlighted:(UIImage *)bgImageHighlighted target:(id)target touchAction:(SEL)action;

+ (UIButton *)buttonWithFrame:(CGRect)frame imageNormal:(UIImage *)imageNormal imageHighlighted:(UIImage *)imageHighlighted target:(id)target touchAction:(SEL)action;

+ (UIButton *)buttonWithFrame:(CGRect)frame imageNormal:(UIImage *)imageNormal imageSelected:(UIImage *)imageSelected target:(id)target touchAction:(SEL)action;

+ (UIButton *)buttonResizableWithFrame:(CGRect)frame WithCapInsets:(UIEdgeInsets)edge withTitle:(NSString *)title imageNormalOfName:(NSString *)imageNormalName imageHighlightedOfName:(NSString *)imageHighlightedName target:(id)target touchAction:(SEL)action;

+ (UITextField *)textfieldWithFrame:(CGRect)frame placeholderText:(NSString *)placehoder font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment text:(NSString *)text andTarget:(id)target action:(SEL)action;

+ (UIActivityIndicatorView *)activityIndicatorView:(CGRect)frame userInteractionEnabled:(BOOL)userInteractionEnabled activityIndicatorViewStyle:(UIActivityIndicatorViewStyle)activityIndicatorViewStyle button:(UIButton *)button;

@end
