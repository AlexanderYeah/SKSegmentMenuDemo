//
//  SKSegmentBtnView.m
//  SKSegmentListView
//
//  Created by AY on 2017/11/7.
//  Copyright © 2017年 AY. All rights reserved.
//

#import "SKSegmentBtnView.h"
#import "SKSegBtn.h"

#define kAnimationDuration 0.5

@interface SKSegmentBtnView()<UITableViewDelegate,UITableViewDataSource>

/** 下拉菜单 */
@property (nonatomic,strong)UITableView *mainTableView;
/** 标记当前选中的按钮 */
@property (nonatomic,strong)UIButton *currentSelectBtn;
/** 标题按钮数组 */
@property (nonatomic,copy)NSArray *titleBtnArray;
/** 选中按钮的颜色 */
@property (nonatomic,strong)UIColor *selectBtnBgColor;
/** 未选中按钮的颜色 */
@property (nonatomic,strong)UIColor *normalBtnBgColor;
/** 标记当前btn的高度 */
@property (nonatomic,assign)CGFloat titleBtnHeight;
/** 标记选中的索引 */
@property (nonatomic,assign)NSInteger currentSelectIdx;

// 数据源数组
@property (nonatomic,copy)NSMutableArray *dataArr;

// 模拟数据
@property (nonatomic,copy)NSMutableArray *normalArr;
// 销量
@property (nonatomic,copy)NSMutableArray *saleArr;
// 价格
@property (nonatomic,copy)NSMutableArray *priceArr;
// 质量
@property (nonatomic,copy)NSMutableArray *qualityArr;

@end

@implementation SKSegmentBtnView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)initData{

	_normalArr = [NSMutableArray array];
	_saleArr = [NSMutableArray array];
	_priceArr = [NSMutableArray array];
	_qualityArr = [NSMutableArray array];
	
	
	
	for (int i = 0; i < 12; i ++) {
	
		[_normalArr addObject:[NSString stringWithFormat:@"默认--%d",i]];
		[_saleArr addObject:[NSString stringWithFormat:@"销量--%d",i]];
		[_priceArr addObject:[NSString stringWithFormat:@"价格--%d",i]];
		[_qualityArr addObject:[NSString stringWithFormat:@"质量--%d",i]];
	}
	
	
	self.dataArr = _normalArr;
	
	
	

}


#pragma mark - 初始化操作
- (instancetype)initWithHeight:(CGFloat)height array:(NSArray *)btnArr norBg:(UIColor *)norBgColor selBg:(UIColor *)selBgColor norFont:(UIColor *)norFontColor selFont:(UIColor *)selFontColor fontSize:(CGFloat)fontSize
{
	if (self = [super init]) {
		[self initData];
		_titleBtnArray = btnArr;
		_selectBtnBgColor = selBgColor;
		_normalBtnBgColor = norBgColor;
		_titleBtnHeight = height;
		// 1 按钮
		CGFloat seg_btn_w = SCREEN_WIDTH / btnArr.count;
		CGFloat seg_btn_h = height;
		for (int i = 0; i < btnArr.count; i ++) {
		SKSegBtn *segBtn = [[SKSegBtn alloc]init];
		
		[segBtn setTitle:btnArr[i] forState:UIControlStateNormal];
		[segBtn setImage:[UIImage imageNamed:@"down-nav"] forState:UIControlStateNormal];

		segBtn.backgroundColor = norBgColor;
		
		[segBtn setTitleColor:norFontColor forState:UIControlStateNormal];
		[segBtn setTitleColor:selFontColor forState:UIControlStateSelected];
		
		segBtn.tag = 660 + i;
		[segBtn addTarget:self action:@selector(segBtnClick:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:segBtn];
		segBtn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
		[segBtn mas_makeConstraints:^(MASConstraintMaker *make) {
			make.width.equalTo(seg_btn_w);
			make.height.equalTo(seg_btn_h);
			make.left.equalTo(self.mas_left).offset(i * seg_btn_w);
			make.top.equalTo(self.mas_top).offset(0);
		}];
		
		
		
		// 2 tableview 创建

		self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, 0) style:UITableViewStylePlain];
    	self.mainTableView.delegate = self;
    	self.mainTableView.dataSource = self;
    	self.mainTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    	self.mainTableView.showsVerticalScrollIndicator = NO;
    	[self addSubview:self.mainTableView];
		
		
		
		}
		
		
	}
	return self;
}


#pragma mark - 3 代理方法


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.dataArr.count;
	
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cellID";

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

	
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }

	
	cell.selectionStyle = UITableViewCellSelectionStyleNone;

	cell.textLabel.text = self.dataArr[indexPath.row];

    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	return 40;
	
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	[self.delegate selectCurrentIdx:self.currentSelectIdx rowIndex:indexPath.row];
}




- (void)segBtnClick:(UIButton *)btn
{
	
	NSInteger idx = btn.tag - 660;
	
	btn.selected = !btn.selected;
	
	_currentSelectBtn = btn;
	
	self.currentSelectIdx = idx;
	
	if (btn.selected) {
		SFLog(@"%ld",(long)idx);
		// 改变选中btn 的状态
		[btn setImage:[UIImage imageNamed:@"up-nav"] forState:UIControlStateNormal];
		[btn setTitleColor:[UIColor colorWithRed:25/255.0f green:172/255.0f blue:126/255.0f alpha:1] forState:UIControlStateNormal];
		btn.backgroundColor = self.selectBtnBgColor;
		
		// 其他btn的状态应该是未选中
		UIView *super_View = [btn superview];
		for (int i = 0; i < self.titleBtnArray.count; i ++) {
			if (i != idx) {
				UIButton *btn = [super_View viewWithTag:(660 + i)];
				[btn setImage:[UIImage imageNamed:@"down-nav"] forState:UIControlStateNormal];
				[btn setTitleColor:[UIColor colorWithRed:112/255.0f green:125/255.0f blue:142/255.0f alpha:1] forState:UIControlStateNormal];
				btn.backgroundColor = self.normalBtnBgColor;
				btn.selected = NO;
			}

		}
		
		// 选中btn 之后 进行tableView 数据源的切换 只有重新加载tableview
		// 此处模拟数据
		
		switch (idx) {
			case 0:
   				 {
				self.dataArr = _normalArr;
				 }
		break;
			case 1:
   				 {
				self.dataArr = _saleArr;
				 }
		break;
			case 2:
   				 {
				self.dataArr = _priceArr;
				 }
		break;
			case 3:
   				 {
				self.dataArr = _qualityArr;
				 }
		break;
  		default:
   		 break;
		}
		
		[UIView animateWithDuration:kAnimationDuration animations:^{
			self.mainTableView.frame = CGRectMake(0, self.titleBtnHeight, SCREEN_WIDTH, 300);
			
		}];
		[self.mainTableView reloadData];
		
		
		
		
	}else{
		
		[btn setImage:[UIImage imageNamed:@"down-nav"] forState:UIControlStateNormal];
		[btn setTitleColor:[UIColor colorWithRed:112/255.0f green:125/255.0f blue:142/255.0f alpha:1] forState:UIControlStateNormal];
		
		
		[UIView animateWithDuration:kAnimationDuration animations:^{
			self.mainTableView.frame = CGRectMake(0, self.titleBtnHeight, SCREEN_WIDTH, 0);
			
		}];
		
		
	}
	

}






@end
