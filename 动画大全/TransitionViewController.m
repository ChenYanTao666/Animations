//
//  TransitionViewController.m
//  动画大全
//
//  Created by yuchen on 2017/7/27.
//  Copyright © 2017年 yuchen. All rights reserved.
//

#import "TransitionViewController.h"

@interface TransitionViewController ()
@property (nonatomic,strong)UIView *view1;
@property (nonatomic,strong)UIView *view2;
@property (nonatomic,strong)UIView *view3;
@end

@implementation TransitionViewController

- (void)viewDidLoad {
    
    
    UIView *view = [[UIView alloc]initWithFrame: CGRectMake(10, 10, 300, 500)];
    [self.view addSubview:view];
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view1 = [[UIView alloc]initWithFrame:CGRectMake(50, 50, 100, 100)];
    self.view1.backgroundColor = [UIColor redColor];
    self.view1.layer.shadowColor =  [UIColor blackColor].CGColor;
    self.view1.layer.shadowOffset = CGSizeMake(-30, -30); // 设置阴影方向
    self.view1.layer.shadowOpacity = 0.5; // 阴影的透明度
    self.view1.layer.shadowRadius = 10;    // 设置阴影的圆角
    
    
    
    
    
    [view addSubview:self.view1];
    self.view3 = view;
    self.view2 = [[UIView alloc]initWithFrame:CGRectMake(50, 50, 100, 100)];
    self.view2.backgroundColor = [UIColor orangeColor];
    [view addSubview:self.view2];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 400, 80, 50);
    [button setTitle:@"转场" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
     [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    // Do any additional setup after loading the view.
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(10, 10, 80, 50);
    [button1 setTitle:@"返回" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(black) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

}


- (void)black{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)buttonAction{
    
//
    
    
      // 把 view1  从父视图上移除
//        [UIView transitionFromView:self.view1 toView:self.view2 duration:2 options:UIViewAnimationOptionTransitionFlipFromBottom completion:^(BOOL finished) {
//          
//        }];
    
    
  /*
   UIViewAnimationOptionLayoutSubviews            //提交动画的时候布局子控件，表示子控件将和父控件一同动画。
   
   UIViewAnimationOptionAllowUserInteraction      //动画时允许用户交流，比如触摸
   
   UIViewAnimationOptionBeginFromCurrentState     //从当前状态开始动画
   
   UIViewAnimationOptionRepeat                    //动画无限重复
   
   UIViewAnimationOptionAutoreverse               //执行动画回路,前提是设置动画无限重复
   
   UIViewAnimationOptionOverrideInheritedDuration //忽略外层动画嵌套的执行时间
   
   UIViewAnimationOptionOverrideInheritedCurve    //忽略外层动画嵌套的时间变化曲线
   
   UIViewAnimationOptionAllowAnimatedContent      //通过改变属性和重绘实现动画效果，如果key没有提交动画将使用快照
   
   UIViewAnimationOptionShowHideTransitionViews   //用显隐的方式替代添加移除图层的动画效果
   
   UIViewAnimationOptionOverrideInheritedOptions  //忽略嵌套继承的选项
   
   //时间函数曲线相关
   
   UIViewAnimationOptionCurveEaseInOut            //时间曲线函数，由慢到快
   
   UIViewAnimationOptionCurveEaseIn               //时间曲线函数，由慢到特别快
   
   UIViewAnimationOptionCurveEaseOut              //时间曲线函数，由快到慢
   
   UIViewAnimationOptionCurveLinear               //时间曲线函数，匀速
   
   //转场动画相关的
   
   UIViewAnimationOptionTransitionNone            //无转场动画
   
   UIViewAnimationOptionTransitionFlipFromLeft    //转场从左翻转
   
   UIViewAnimationOptionTransitionFlipFromRight   //转场从右翻转
   
   UIViewAnimationOptionTransitionCurlUp          //上卷转场
   
   UIViewAnimationOptionTransitionCurlDown        //下卷转场
   
   UIViewAnimationOptionTransitionCrossDissolve   //转场交叉消失
   
   UIViewAnimationOptionTransitionFlipFromTop     //转场从上翻转
   
   UIViewAnimationOptionTransitionFlipFromBottom  //转场从下翻转
   
   */

    if (self.view1.hidden == YES) {
        [UIView transitionWithView:self.view3 duration:1 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
            self.view1.hidden = NO;
            self.view2.hidden = YES;
        } completion:^(BOOL finished) {
            
        }];
    }else{
        [UIView transitionWithView:self.view3 duration:1 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
            self.view1.hidden = YES;
            self.view2.hidden = NO;
        } completion:^(BOOL finished) {
            
        }];
    }

  
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
