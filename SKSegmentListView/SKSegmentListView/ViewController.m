//
//  ViewController.m
//  SKSegmentListView
//
//  Created by AY on 2017/11/7.
//  Copyright © 2017年 AY. All rights reserved.
//

#import "ViewController.h"
#import "SKSegmentBtnView.h"
@interface ViewController ()<SKSegmentDelegate>

@property (nonatomic,strong)SKSegmentBtnView *segView;


// 标记选中多少行
@property (nonatomic,strong)UILabel *showLbl;


@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	/**
		2 height 3 btn 数组 4 正常背景色 5 选中背景 6 正常字体颜色 7 选中字体颜色 8 标题字体大小
	*/
	
	self.view.backgroundColor = [UIColor cyanColor];
	_segView = [[SKSegmentBtnView alloc]initWithHeight:50 array:@[@"默认",@"销量",@"价格",@"质量"] norBg:[UIColor grayColor] selBg:[UIColor colorWithRed:25/255.0f green:172/255.0f blue:126/255.0f alpha:1] norFont:[UIColor redColor] selFont:[UIColor blackColor] fontSize:18.0f];
	_segView.userInteractionEnabled = YES;
	_segView.frame = CGRectMake(0, 100, SCREEN_WIDTH, 350);
	_segView.backgroundColor = [UIColor clearColor];
	_segView.delegate = self;
	[self.view addSubview:_segView];
	
	
	_showLbl = [[UILabel alloc]init];
	_showLbl.text = @"显示结果";
	_showLbl.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5];
	_showLbl.textAlignment = NSTextAlignmentCenter;
	[self.view addSubview:_showLbl];
	
	[_showLbl mas_makeConstraints:^(MASConstraintMaker *make) {
		make.width.equalTo(SCREEN_WIDTH);
		make.height.equalTo(35);
		make.left.equalTo(self.view.mas_left).offset(0);
		make.bottom.equalTo(self.view.mas_bottom).offset(-120);
	}];

	
	
}

// 实现代理方法
- (void)selectCurrentIdx:(NSInteger)idx rowIndex:(NSInteger)rowIdx
{
	
	self.showLbl.text = [NSString stringWithFormat:@"选中item--%ld--第%ld行",idx,rowIdx];
	

}








- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
