//
//  ViewController.m
//  YFLNavSlideTitleView
//
//  Created by 杨丰林 on 16/11/16.
//  Copyright © 2016年 杨丰林. All rights reserved.
//

#import "ViewController.h"
#import "titleScrollView.h"
#import "UIView+Extension.h"
#define screenW [[UIScreen mainScreen]bounds].size.width
#define screenH [[UIScreen mainScreen]bounds].size.height
#define Color(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RandomColor Color(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))/** 随机色  */
static CGFloat const titleH=40.0f;          /*title   高度*/
static CGFloat const maxScale=1.2f;         /*最大缩放比率*/


@interface ViewController ()<UIScrollViewDelegate>
@property (nonatomic ,strong) titleScrollView *titleView;
@property (nonatomic ,strong) UIScrollView *contentScrollView;
@property (nonatomic ,strong) NSArray *titleArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleView=[[titleScrollView alloc]init];
    [self.titleView setFrame:CGRectMake(0,20,screenW , titleH)];
    [self.view addSubview:self.titleView];
    
    
    self.titleArr = @[@"美食",@"旅游",@"电影",@"招聘",@"娱乐",@"肯德基",@"美食",@"旅游",@"电影",@"招聘",@"娱乐",@"肯德基"];
    self.titleView.titleArr=_titleArr;
    
    
    self.contentScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 60, screenW, screenH-60)];
    self.contentScrollView.contentSize = CGSizeMake(_titleArr.count*screenW, 0);
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.showsHorizontalScrollIndicator  = NO;
    self.contentScrollView.delegate = self;
    self.contentScrollView.bounces = NO;
    [self.view addSubview:self.contentScrollView];
    
    

    for (NSInteger i=0; i<_titleArr.count; i++) {
        CGFloat X=screenW*i;
        UIView *contenV=[[UIView alloc]initWithFrame:CGRectMake(X, 0, screenW, self.contentScrollView.frame.size.height)];
        [contenV setBackgroundColor:Color(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))];
        [self.contentScrollView addSubview:contenV];
    }
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offset=scrollView.contentOffset.x;
    
    NSInteger leftIndex=offset/screenW;
    
    NSInteger rightIndex=leftIndex+1;
    
    UIButton *leftBtn=self.titleView.btnArrs[leftIndex];
    UIImageView *bgImageView=self.titleView.backImageView;
    UIButton *rightBtn=nil;
    
    if (rightIndex<self.titleView.btnArrs.count) {
        rightBtn=self.titleView.btnArrs[rightIndex];
    }

    CGFloat rightScale=offset/screenW-leftIndex;         //右边   偏移百分比
    CGFloat leftScale=1-rightScale;                      //左边   偏移百分比
    
    CGFloat scale=maxScale-1;
    
    leftBtn.transform=CGAffineTransformMakeScale(leftScale*scale+1, leftScale*scale+1);
    rightBtn.transform=CGAffineTransformMakeScale(rightScale*scale+1, rightScale*scale+1);
    
    
    //移动BgImageView
    [UIView animateWithDuration:0.2 animations:^{
        bgImageView.x=80*(offset/screenW);

    }];
    
    
    
/*
 主要技术点：
 偏移的使用
 动画缩放使用
 
 */
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat offsetX=scrollView.contentOffset.x;
    NSInteger index=offsetX/screenW;
    
    //移动BgImageView  校正位置偏差
    UIImageView *bgImageView=self.titleView.backImageView;
    bgImageView.x=bgImageView.width*index;
    
    UIButton *btn=nil;
    if (index<self.titleView.btnArrs.count) {
        btn=self.titleView.btnArrs[index];
    }
    
    if (btn!=nil) {
        [self.titleView titleClick:btn];
    }
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
