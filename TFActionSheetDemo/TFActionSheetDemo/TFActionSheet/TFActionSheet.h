//
//  TFActionSheet.h
//  TFActionSheetDemo
//
//  Created by RaInVis on 16/11/11.
//  Copyright © 2016年 RaInVis. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^actionSheetBlock)();

@interface TFActionSheet : UIView

// 初始化控件
- (instancetype)initWithTitle:(NSAttributedString *)title cancelButtonTitle:(NSAttributedString *)cancelButtonTitle;
// 添加Item
- (instancetype)addButtonTitle:(NSAttributedString *)buttonTitle buttonAction:(actionSheetBlock)block;
// 显示在屏幕上
- (void)show;

@end
