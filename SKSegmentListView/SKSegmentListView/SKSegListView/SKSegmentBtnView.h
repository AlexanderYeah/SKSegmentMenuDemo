//
//  SKSegmentBtnView.h
//  SKSegmentListView
//
//  Created by AY on 2017/11/7.
//  Copyright © 2017年 AY. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SKSegmentDelegate <NSObject>

- (void)selectCurrentIdx:(NSInteger)idx rowIndex:(NSInteger)rowIdx;

@end


@interface SKSegmentBtnView : UIView


@property (nonatomic,assign)id<SKSegmentDelegate> delegate;


/**
		2 height 3 btn 数组 4 正常背景色 5 选中背景 6 正常字体颜色 7 选中字体颜色 8 标题字体大小
		
*/

- (instancetype)initWithHeight:(CGFloat)height array:(NSArray *)btnArr norBg:(UIColor *)norBgColor selBg:(UIColor *)selBgColor norFont:(UIColor *)norFontColor selFont:(UIColor *)selFontColor fontSize:(CGFloat)fontSize;


@end
