//
//  UIFactory.m
//  wisenjoyapp
//
//  Created by 范东 on 16/9/26.
//  Copyright © 2016年 wisenjoy. All rights reserved.
//

#import "UIFactory.h"

@implementation UIFactory

+ (UIView *)viewWithFrame:(CGRect)frame bgColor:(UIColor *)bgColor
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = bgColor;
    return view;
}

+ (UILabel *)labelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font bgColor:(UIColor *)bgColor
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.font = font;
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = textColor;
    label.backgroundColor = bgColor;
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    return label;
}


+ (UITextView *)textViewWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font bgColor:(UIColor *)bgColor
{
    UITextView *textV = [[UITextView alloc] initWithFrame:frame];
    textV.text = text;
    textV.font = font;
    textV.textAlignment = NSTextAlignmentCenter;
    textV.textColor = textColor;
    textV.backgroundColor = bgColor;
    return textV;
}

+ (UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)font titleColorNormal:(UIColor *)titleColorNormal bgImageNormal:(UIImage *)bgImageNormal bgImageHighlighted:(UIImage *)bgImageHighlighted target:(id)target touchAction:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColorNormal forState:UIControlStateNormal];
    button.titleLabel.font = font;
    [button setBackgroundImage:bgImageNormal forState:UIControlStateNormal];
    [button setBackgroundImage:bgImageHighlighted forState:UIControlStateHighlighted];
    [button setBackgroundImage:bgImageHighlighted forState:UIControlStateDisabled];
    if(target){
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return button;
}

+ (UIActivityIndicatorView *)activityIndicatorView:(CGRect)frame userInteractionEnabled:(BOOL)userInteractionEnabled activityIndicatorViewStyle:(UIActivityIndicatorViewStyle)activityIndicatorViewStyle button:(UIButton *)button
{
    UIActivityIndicatorView *activity_indicator_view = [[UIActivityIndicatorView alloc] initWithFrame:frame];
    [activity_indicator_view setUserInteractionEnabled:YES];//点击不传递事件到button
    [activity_indicator_view setActivityIndicatorViewStyle:activityIndicatorViewStyle];
    [button addSubview: activity_indicator_view];
    [activity_indicator_view startAnimating];
    return activity_indicator_view;
}

+ (UIButton *)buttonWithFrame:(CGRect)frame imageNormal:(UIImage *)imageNormal imageHighlighted:(UIImage *)imageHighlighted target:(id)target touchAction:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.exclusiveTouch = YES;
    button.backgroundColor = [UIColor clearColor];
    button.frame = frame;
    [button setImage:imageNormal forState:UIControlStateNormal];
    [button setImage:imageHighlighted forState:UIControlStateHighlighted];
    if(target){
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return button;
}

+ (UIButton *)buttonWithFrame:(CGRect)frame imageNormal:(UIImage *)imageNormal imageSelected:(UIImage *)imageSelected target:(id)target touchAction:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.exclusiveTouch = YES;
    button.backgroundColor = [UIColor clearColor];
    button.frame = frame;
    [button setImage:imageNormal forState:UIControlStateNormal];
    [button setImage:imageSelected forState:UIControlStateSelected];
    if(target){
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return button;
}

+ (UIButton *)buttonResizableWithFrame:(CGRect)frame WithCapInsets:(UIEdgeInsets)edge withTitle:(NSString *)title imageNormalOfName:(NSString *)imageNormalName imageHighlightedOfName:(NSString *)imageHighlightedName target:(id)target touchAction:(SEL)action
{
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    UIImage *btnImgNm = [[UIImage imageNamed:imageNormalName] resizableImageWithCapInsets:edge];
    UIImage *btnImgHl = [[UIImage imageNamed:imageHighlightedName] resizableImageWithCapInsets:edge];
    [btn setBackgroundImage:btnImgHl forState:UIControlStateHighlighted];
    [btn setBackgroundImage:btnImgNm forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    if(target){
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return btn;
}

+ (UITextField *)textfieldWithFrame:(CGRect)frame placeholderText:(NSString *)placehoder font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment text:(NSString *)text andTarget:(id)target action:(SEL)action
{
    UITextField *textfield = [[UITextField alloc] initWithFrame:frame];
    textfield.text = text;
    textfield.placeholder = placehoder;
    textfield.font = font;
    textfield.textAlignment = textAlignment;
    textfield.returnKeyType = UIReturnKeyDone;
    textfield.autocorrectionType = UITextAutocorrectionTypeNo;
    textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    if (target) {
        [textfield addTarget:self action:action forControlEvents:UIControlEventEditingDidEndOnExit];
    }
    return textfield;
}

@end
