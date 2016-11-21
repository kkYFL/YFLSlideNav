//
//  titleScrollView.m
//  YFLNavSlideTitleView
//
//  Created by 杨丰林 on 16/11/16.
//  Copyright © 2016年 杨丰林. All rights reserved.
//

#import "titleScrollView.h"
#import "UIView+Extension.h"
#define screenW [[UIScreen mainScreen]bounds].size.width
#define screenH [[UIScreen mainScreen]bounds].size.height
#define RandomColor Color(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))/** 随机色  */

@interface titleScrollView ()<UIScrollViewDelegate>
@property (nonatomic ,strong) UIScrollView *titleScrollView;
@end

@implementation titleScrollView
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
        [self initView];
        
        _btnArrs=[NSMutableArray array];
    }
    return self;
}

-(void)addChildViewController:(UIViewController *)childVC title:(NSString *)vcTitle{
    
}

-(void)setTitleArr:(NSArray *)titleArr{
    _titleArr=titleArr;
    
    NSInteger count=_titleArr.count;
    
    CGFloat W=80.0f;
    CGFloat H=self.frame.size.height;
    CGFloat X=0.0f;
    CGFloat Y=0.0f;
    
    self.titleScrollView.contentSize=CGSizeMake(W*count, 0);
    
    self.backImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, W, H)];
    self.backImageView.image=[UIImage imageNamed:@"b1"];
    [self.titleScrollView addSubview:self.backImageView];

    if (_btnArrs.count) {
        [_btnArrs removeAllObjects];
    }
    
    for (NSInteger i=0; i<count; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius=2.0f;
        btn.layer.masksToBounds=YES;
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [btn setTitle:_titleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        //[btn setBackgroundColor:[UIColor yellowColor]];
        X=W*i;
        [btn setFrame:CGRectMake(X, Y, W, H)];
        [self.titleScrollView addSubview:btn];
        
        [_btnArrs addObject:btn];
        
        if (i==0) {
            [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            self.selectedBtn=btn;

        }
    }
    
    
    
}

-(void)titleClick:(UIButton *)sender{
    [self.selectedBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    UIButton *btn=(UIButton *)sender;

    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    self.selectedBtn=btn;

    [self titleScrollChangeContentOfsetWithBtn:btn];
    

}

-(void)titleScrollChangeContentOfsetWithBtn:(UIButton *)sender{
    
    UIButton *btn=(UIButton *)sender;
    
    CGFloat offset=btn.center.x-0.5*screenW;
    if (offset<0) {
        offset=0;
    }
    
    CGFloat maxOffset=self.titleScrollView.contentSize.width-screenW;
    if (offset>maxOffset && maxOffset>0) {
        offset=maxOffset;
    }
    
    //[self.titleScrollView setContentOffset:CGPointMake(offset, 0) animated:YES];
    __weak typeof(self) weakSelf=self;
    [UIView animateWithDuration:0.1 animations:^{
        [weakSelf.titleScrollView setContentOffset:CGPointMake(offset, 0)];
        weakSelf.backImageView.centerX=btn.centerX;
    }];
}


-(void)initView{
    self.titleScrollView=[[UIScrollView alloc]init];
    //self.titleScrollView.backgroundColor=[UIColor greenColor];
    self.titleScrollView.delegate=self;
    [self addSubview:self.titleScrollView];
    

}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    //布局调整
    [self.titleScrollView setFrame:CGRectMake(0, 0, screenW, self.frame.size.height)];
    
}




@end
