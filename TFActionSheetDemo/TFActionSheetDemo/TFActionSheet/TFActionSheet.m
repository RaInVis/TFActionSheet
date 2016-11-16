//
//  TFActionSheet.m
//  TFActionSheetDemo
//
//  Created by RaInVis on 16/11/11.
//  Copyright © 2016年 RaInVis. All rights reserved.
//

#import "TFActionSheet.h"
#import <objc/runtime.h>

static NSString *actionSheetKey = @"actionSheetKey"; // runtimeKey
static CGFloat const kMargin = 10; // 其他按钮与取消按钮的间距
static CGFloat const buttonH = 50; // 按钮的高度
static CGFloat const sideMargin = 15; // 按钮两侧间距
static CGFloat const titleH = 75; // 标题的高度
static CGFloat const animtionDuringTime = 0.3; // 动画时间
static CGFloat const cornerRadius = 3.f; // 圆角
static CGFloat const commonMargin = 0.5; // 普通按钮之间的间距
static CGFloat const kAlpha = 0.4; // 透明度

#define ACTION_BUTTON_COLOR [UIColor whiteColor] // button北京颜色
#define ACTION_BACKGROUND_COLOR [UIColor blackColor] // 背景视图透明颜色
#define TF_ACTIONSHEET_WIDTH  [UIScreen mainScreen].bounds.size.width
#define TF_ACTIONSHEET_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface TFActionSheet ()

@property (nonatomic, strong) NSAttributedString *actionSheetTitle; //!< 标题
@property (nonatomic, strong) UIButton *cannelButton; //!< 取消按钮
@property (nonatomic, assign) CGFloat totalHeight; //!< 总高度
@property (nonatomic, strong) UIView *contentView; //!< 按钮视图
@property (nonatomic, strong) UIView *backgroundView; //!< 北京视图
@property (nonatomic, assign) NSUInteger idx; //!< 添加的button数量
@property (nonatomic, strong) UILabel *titleLab; //!< 标题lab

@end

@implementation TFActionSheet

#pragma mark - lazy load

- (UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.numberOfLines = 0;
        _titleLab.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(noneAction)];
        _titleLab.userInteractionEnabled = YES;
        [_titleLab addGestureRecognizer:tap]; 
        
    }
    return _titleLab;
}

- (UIButton *)cannelButton
{
    if (!_cannelButton) {
        _cannelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cannelButton.backgroundColor = ACTION_BUTTON_COLOR;
        [_cannelButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        _cannelButton.layer.cornerRadius = cornerRadius;
        _cannelButton.layer.masksToBounds = YES;
    }
    return _cannelButton;
}

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor clearColor];
    }
    return _contentView;
}

- (UIView *)backgroundView
{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        _backgroundView.backgroundColor = ACTION_BACKGROUND_COLOR;
        _backgroundView.alpha = 0;
    }
    return _backgroundView;
}

#pragma mark - init

- (instancetype)initWithTitle:(NSAttributedString *)title cancelButtonTitle:(NSAttributedString *)cancelButtonTitle
{
    if (self = [super init]) {
        
        _actionSheetTitle = title;
        if (_actionSheetTitle) {
            self.titleLab.attributedText = title;
            [self.contentView addSubview:self.titleLab];
        }
        _totalHeight = buttonH + kMargin;
        self.backgroundColor = [UIColor clearColor];
        [self.cannelButton setAttributedTitle:cancelButtonTitle forState:UIControlStateNormal];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:tap];
    }
    return self;
}

#pragma mark - public method

- (instancetype)addButtonTitle:(NSAttributedString *)buttonTitle buttonAction:(actionSheetBlock)block
{
    
    if (_idx == 0) {
        _idx ++;
        _totalHeight += kMargin;
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = ACTION_BUTTON_COLOR;
    [button setAttributedTitle:buttonTitle forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:button];
    // 绑定点击事件
    objc_setAssociatedObject(button, (__bridge const void *)(actionSheetKey), block, OBJC_ASSOCIATION_COPY);
    _totalHeight += buttonH;
    return self;
}

#pragma mark - private method

- (void)refreshUI
{
    [self calculateActionSheetHeight];
    [self setupFrame];
    [self addActionSubviews];
}

- (void)calculateActionSheetHeight
{
    if (_actionSheetTitle) {
        _totalHeight += titleH + commonMargin + (self.contentView.subviews.count - 1) *commonMargin;
    }else{
        _totalHeight += (self.contentView.subviews.count - 1) *commonMargin;
    }
    
    if (_idx == 0 && _actionSheetTitle) {
        _totalHeight += kMargin;
    }
}

- (void)setupButtonsFrame
{
    CGFloat titleHeight = !_actionSheetTitle ? 0 : titleH;
    for (NSUInteger idx = 0; idx < self.contentView.subviews.count; idx ++) {
        NSUInteger idy;
        UIView *childView = self.contentView.subviews[idx];
        UIButton *button;
        if ([childView isKindOfClass:[UIButton class]]) {
            button = (UIButton *)childView;
        }
        if (_actionSheetTitle) {
            idy = idx - 1;
        }else{
            idy = idx;
        }
        button.frame = CGRectMake(sideMargin, titleHeight + idy *buttonH + idx *commonMargin, TF_ACTIONSHEET_WIDTH - 2*sideMargin, buttonH);
        // 设置收尾圆角切割
        if (self.contentView.subviews.count - 1 == 0) {
            [self cutRoundingCornersToView:childView byRoundingCorners:UIRectCornerAllCorners];
            break;
        }
        if (idx == self.contentView.subviews.count - 1) {
            [self cutRoundingCornersToView:childView byRoundingCorners:UIRectCornerBottomRight | UIRectCornerBottomLeft];
            break;
        }
        if (idx == 0) {
            [self cutRoundingCornersToView:childView byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft];
        }
    }

}

- (void)setupFrame
{
    self.frame = CGRectMake(0, 0, TF_ACTIONSHEET_WIDTH, TF_ACTIONSHEET_HEIGHT);
    self.cannelButton.frame = CGRectMake(sideMargin, _totalHeight - buttonH - kMargin, TF_ACTIONSHEET_WIDTH - 2*sideMargin, buttonH);
    self.contentView.frame = CGRectMake(0, TF_ACTIONSHEET_HEIGHT, TF_ACTIONSHEET_WIDTH, _totalHeight);
    self.titleLab.frame = CGRectMake(sideMargin, 0, TF_ACTIONSHEET_WIDTH - 2*sideMargin, titleH);
    [self setupButtonsFrame];
}

- (void)addActionSubviews
{
    [self.contentView addSubview:self.cannelButton];
    [self addSubview:self.contentView];
    [self insertSubview:self.backgroundView atIndex:0];
}

// 切割圆角
- (void)cutRoundingCornersToView:(UIView *)view byRoundingCorners:(UIRectCorner)corners
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

#pragma mark - click Action

- (void)noneAction
{
    
}
- (void)buttonAction:(UIButton *)button
{
    actionSheetBlock block = objc_getAssociatedObject(button, (__bridge const void *)(actionSheetKey));
    if (block) {
        [self dismiss];
        block();
    }
}

- (void)show
{
    [self refreshUI];
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    [UIView animateWithDuration:animtionDuringTime animations:^{
        self.backgroundView.alpha = kAlpha;
        self.contentView.transform = CGAffineTransformMakeTranslation(0, -_totalHeight);
    }];
}

- (void)dismiss
{
    [UIView animateWithDuration:animtionDuringTime animations:^{
        self.backgroundView.alpha = 0;
        self.contentView.transform = CGAffineTransformMakeTranslation(0, _totalHeight);
    } completion:^(BOOL finished) {
         [self removeFromSuperview];
    }];
}

@end
