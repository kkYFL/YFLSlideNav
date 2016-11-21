//
//  titleScrollView.h
//  YFLNavSlideTitleView
//
//  Created by 杨丰林 on 16/11/16.
//  Copyright © 2016年 杨丰林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface titleScrollView : UIView
@property (nonatomic ,strong) NSArray *titleArr;            //title  数组
@property (nonatomic ,strong) UIButton *selectedBtn;        //选中btn
@property (nonatomic ,strong) NSMutableArray *btnArrs;      //按钮数组
@property (nonatomic ,strong) UIImageView *backImageView;


-(void)addChildViewController:(UIViewController *)childVC title:(NSString *)vcTitle;
-(void)titleClick:(UIButton *)sender;
@end
