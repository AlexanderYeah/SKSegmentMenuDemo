//
//  SKSegBtn.m
//  SKSegmentListView
//
//  Created by AY on 2017/11/7.
//  Copyright © 2017年 AY. All rights reserved.
//

#import "SKSegBtn.h"

@implementation SKSegBtn

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame]) {
		[self setupUI];
	}
	return self;
}

- (void)setupUI
{
	
	self.titleLabel.textAlignment = NSTextAlignmentCenter;
	
}

- (void)layoutSubviews
{
    
    [super layoutSubviews];
	// 文字
	
	
	CGFloat self_height = self.frame.size.height;
	CGFloat self_width = self.frame.size.width;
	
	
    
	
	CGFloat t_h = self_height/2;
    CGFloat t_w = self_width / 2 * 1.3;
	CGFloat t_y = self_height/2 - t_h/2;
	CGFloat t_x = self_width / 2-t_w/2 -12;
    self.titleLabel.frame = CGRectMake(t_x, t_y, t_w, t_h);
	//self.titleLabel.backgroundColor = SFRandomColor;
	[self layoutIfNeeded];
    // 图片
    CGFloat imgWidth = 12;
    CGFloat imgHeight = imgWidth;
    CGFloat img_x = t_x + t_w - 3;
    CGFloat img_y = self_height/2 - imgHeight/2;
    
    CGFloat x = img_x;
    CGFloat y = img_y;
    CGFloat w = imgWidth;
    CGFloat h = imgHeight;
    
    self.imageView.frame = CGRectMake(x, y, w, h);
	

    
    //  重绘
    [self setNeedsDisplay];
    
}


@end
