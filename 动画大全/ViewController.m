//
//  ViewController.m
//  动画大全
//
//  Created by yuchen on 2017/7/19.
//  Copyright © 2017年 yuchen. All rights reserved.
//

#import "ViewController.h"
#import "CABasicAnimationViewController.h"
#import "CAKeyFrameAnimationViewController.h"
#import "TransitionViewController.h"
#import "CAEmitterLayerViewController.h"
#import "ElseViewController.h"


/**
 动画分类
 
 
                                                 |---  属性动画
                                                 |
                    |--------  UIView 动画 -------  过渡动画
                    |
                    |
  动画 -------
                    |
                    |
                    | -------- layer 层动画 ----------  属性动画
                                            |                        |---CABasicAnimation
                                            |                        |
                                            |---CoreAnimation隐式动画--
                                            |                        |
                                            |--- CAAnimationGroup    |---CAKeyframeAnimation
                                            |
                                            |--- CATransition
 
 
 
 
 
 
 
 CAAnimation{
        CAPropertyAnimation{
             CABasicAnimation{
               CASpringAnimation
              }
       CAKeyframeAnimation
 }
     CATransition
     CAAnimationGroup
 }
 
 
 
 */



@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (nonatomic ,strong)NSMutableArray *viewArray;
@property (nonatomic ,strong)NSMutableArray *labelArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    self.title = @"UIview 属性动画";
    
    self.viewArray  = [NSMutableArray new];
    self.labelArray = [NSMutableArray new];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, 100, 40)];
    label.center = CGPointMake(self.view.center.x, 30);
    label.textColor = [UIColor redColor];
    label.text = @"UIview 属性动画";
    [label sizeToFit];
    [self.contentView addSubview:label];
    
    
    
    for (int i = 0; i < 16; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 200, 50 + i * 60, 10, 10)];
        label.font = [UIFont systemFontOfSize:12];
        label.tag = 1000 + i;
        [self.contentView addSubview:label];
        [self.labelArray addObject:label];
        label.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [label addGestureRecognizer:tap];
        int R = (arc4random() % 256) ;
        int G = (arc4random() % 256) ;
        int B = (arc4random() % 256) ;
        UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(20, 50 + i * 60, 50, 40)];
        view1.backgroundColor = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1];
        [self.contentView addSubview:view1];
        [self.viewArray addObject:view1];
        
        if (i == 9) {
            label.center = CGPointMake(self.contentView.center.x, view1.center.y);
            label.font = [UIFont systemFontOfSize:17];
            label.text = @"lay层的动画";
            label.textColor = [UIColor redColor];
            view1.hidden = YES;
            [label sizeToFit];
            // 从第10开始
        }
        
        
        if (i == 13) {
            label.center = CGPointMake(self.contentView.center.x, view1.center.y);
            label.font = [UIFont systemFontOfSize:17];
            label.text = @"转场切换";
            label.textColor = [UIColor redColor];
            view1.hidden = YES;
            [label sizeToFit];
        }
        
        if (i == 14) {
            label.center = CGPointMake(self.contentView.center.x, view1.center.y);
            label.font = [UIFont systemFontOfSize:17];
            label.text = @"粒子效果";
            label.textColor = [UIColor redColor];
            view1.hidden = YES;
            [label sizeToFit];
        }
        
        if (i == 15) {
            label.center = CGPointMake(self.contentView.center.x, view1.center.y);
            label.font = [UIFont systemFontOfSize:17];
            label.text = @"其他整合";
            label.textColor = [UIColor redColor];
            view1.hidden = YES;
            [label sizeToFit];
        }
        
    

        
    }
    
    
    
    //UIview 属性动画
    [self handlePreopertyAnimation];
    
    
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.5 repeats:YES block:^(NSTimer * _Nonnull timer) {
        //block 属性动画
        [self baseBlockPropertyAnimation];
    }];
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    [timer fire];
 
    
    // layer   层动画
    [self layerAnimation];
   
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self handlePreopertyAnimation];
}



- (void)handlePreopertyAnimation{
    
    for (int i = 0; i< 4; i++) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelay:1];
        [UIView setAnimationDuration:2];
        [UIView setAnimationRepeatCount:100];
        [UIView setAnimationRepeatAutoreverses: YES];  // 翻转
        [UIView setAnimationCurve:i]; //设置动画变化的曲线
        UIView *view = self.viewArray[i];
        view.alpha = 0;
        view.center = CGPointMake(view.center.x + 300, view.center.y);
        [UIView setAnimationDelegate:self];   // 设置代理 监测动画结束的
        [UIView setAnimationDidStopSelector:@selector(shopAction)];
        [UIView commitAnimations];
      
        
        UILabel *label = self.labelArray[i];
        switch (i) {
            case 0:
                label.text = @"UIViewAnimationCurveEaseInOut";
                break;
            case 1:
                label.text = @"UIViewAnimationCurveEaseIn";
                break;
            case 2:
                label.text = @"UIViewAnimationCurveEaseOut";
                break;
            case 3:
                label.text = @"UIViewAnimationCurveLinear";
                break;
                
            default:
                break;
        }
        [label sizeToFit];

        
    }
    
}


- (void)baseBlockPropertyAnimation{
    
    //1.0 基于Block的属性动画
    [UIView animateWithDuration:0.5 animations:^{
        
        UIView *view = self.viewArray[4];
       view.transform = CGAffineTransformRotate(view.transform, M_2_PI); // 顺时针旋转
    }];
    
    
    [UIView animateKeyframesWithDuration:2 delay:0 options:UIViewKeyframeAnimationOptionRepeat animations:^{
        UIView *view = self.viewArray[5];
       view.transform = CGAffineTransformMakeScale(2, 1);//宽高伸缩比例;
    } completion:^(BOOL finished) {
        if (finished) {
           UIView *view = self.viewArray[5];
           view.backgroundColor = [UIColor colorWithRed: arc4random()%256 / 255.0 green:arc4random()%256 / 255.0 blue:arc4random()%256/ 255.0  alpha:1.0];
        }
    }];
    [UIView animateKeyframesWithDuration:5 delay:0 options:UIViewKeyframeAnimationOptionRepeat animations:^{
         UIView *view = self.viewArray[6];
        view.transform = CGAffineTransformMakeTranslation(300, 6);//xy移动距离;
    } completion:^(BOOL finished) {
        if (finished) {
            UIView *view = self.viewArray[6];
            view.backgroundColor = [UIColor colorWithRed: arc4random()%256 / 255.0 green:arc4random()%256 / 255.0 blue:arc4random()%256/ 255.0  alpha:1.0];
        }
        
    }];
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionRepeat animations:^{
          UIView *view = self.viewArray[7];
          view.transform = CGAffineTransformMake(1.5, 1, 2, 2, 1,1);//自定义形变,参数自拟;
        
    } completion:^(BOOL finished) {
        if (finished) {
               UIView *view = self.viewArray[7];
               view.backgroundColor = [UIColor colorWithRed: arc4random()%256 / 255.0 green:arc4random()%256 / 255.0 blue:arc4random()%256/ 255.0  alpha:1.0];
        }
        
    }];
    
    // 弹簧效果  // 一  动画执行的时间   二  动画延迟执行的时间  第三个  弹簧震动的频率 0 - 1 值越小频率越高 四 弹簧的起始抖动的速度  五 代表动画的效果  六 具体执行的动画   七 执行完之后 的操作
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.1 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
             UIView *view = self.viewArray[8];
        if (view.center.x > [UIScreen mainScreen].bounds.size.width) {
            view.center = CGPointMake(0, view.center.y);
        }else{
            view.center = CGPointMake(view.center.x + 10, view.center.y);
        }
        
        
        
    } completion:^(BOOL finished) {
        
    }];
    
    
    for (int i = 4; i<= 8; i++) {
        UILabel *label = self.labelArray[i];
        switch (i) {
            case 4:
                     label.text = @"CGAffineTransformRotate";
                break;
            case 5:
                label.text = @"CGAffineTransformMakeScale";
                break;
            case 6:
                label.text = @"CGAffineTransformMakeTranslation";
                break;
            case 7:
                label.text = @"CGAffineTransformMake";
                break;
            case 8:
                label.text = @"弹簧效果";
                break;

                
            default:
                break;
        }
        [label sizeToFit];


    }

}
- (void)handleTransitionAnimation{
    
    UIView *view1 = self.viewArray[9];
    UIView *view2 = self.viewArray[10];
    // uiview  单一视图的过渡动画
    [UIView transitionWithView:view1 duration:2.0 options:UIViewAnimationOptionRepeat animations:^{
        
        view1.transform = CGAffineTransformScale(view1.transform, 0.9, 0.9);
        
        
    } completion:^(BOOL finished) {
        
        view1.transform = CGAffineTransformScale(view1.transform, 1.0 / 0.9, 1.0 / 0.9);
        
    }];
    // 两个视图的切换
    
    [UIView transitionFromView:view2  toView:view1 duration:1.0 options:UIViewAnimationOptionRepeat completion:^(BOOL finished) {
        
    }];
    
    
}


- (void)layerAnimation{
    UIView *view = self.viewArray[10];
    view.layer.borderWidth = 6;
    view.layer.borderColor = [UIColor redColor].CGColor;
    view.layer.cornerRadius = 10;
    
   //  锚点 和  基准点  锚点和基准点 默认都是在中心的  而且 锚点是自动向基准点靠拢的 所有修改任何一个点都会引起视图的移动  描点是以自身坐标系( 0 - 1) 而基准点是以其父视图为准的
    CGPoint archP = view.layer.anchorPoint;
    CGPoint postion = view.layer.position;
    //打印锚点的坐标
    NSLog(@"%f %f",archP.x,archP.y);
    NSLog(@"%@",NSStringFromCGPoint(postion));
    NSLog(@"%@",NSStringFromCGPoint(view.center));
    view.layer.anchorPoint = CGPointMake(0, 0);
    
    
    
    
    UIView *view1 = self.viewArray[11];
    UILabel *label1 = self.labelArray[11];
    label1.text = @"CABasicAnimation";
    [label1 sizeToFit];
  
    
    // layer 动画   CABasicAnimation 最终不会修改其属性  只是为了做动画使用
    // 设置需要修改的layer层属性
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    //设置对应的控件Layer层position.x 的起始值
    basicAnimation.fromValue = @(-112);
    // 设置最终值
    basicAnimation.toValue = @(425);
    // 设置时间
    basicAnimation.duration = 4;
    // 设置动画重复的次数
    basicAnimation.repeatCount = 1000000;
    // 将动画添加到对应视图的layer层上
    [view1.layer addAnimation:basicAnimation forKey:nil];
    
    
//     关键帧动画
    
    
    UIView *view12 = self.viewArray[12];
    UILabel *label12 = self.labelArray[12];
    label12.text = @"CAKeyframeAnimation";
    [label12 sizeToFit];
    // 关键帧动画
    // 指定动画需要修改的属性
    CAKeyframeAnimation *keyFrameA = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    // 获得起始的点
    CGPoint point1 = view12.layer.position;
    // 第二个点
    CGPoint point2 = CGPointMake(375 / 2.0, -50);
    // 第三个点
    CGPoint point3 = CGPointMake(375 + 50, point1.y);
    // 第四个点
    CGPoint point4 = point1;
    NSValue *pointV1 = [NSValue valueWithCGPoint:point1];
    NSValue *pointV2 = [NSValue valueWithCGPoint:point2];
    NSValue *pointV3 = [NSValue valueWithCGPoint:point3];
    NSValue *pointV4 = [NSValue valueWithCGPoint:point4];
    keyFrameA.values = @[pointV1,pointV2,pointV3,pointV4];
    // 设置每帧动画的起始和结束点
    keyFrameA.duration = 5;
    // 设置重复的次数
    keyFrameA.repeatCount = 1000;
    //将动画添加到指定的控件的layer上；
    [view12.layer addAnimation:keyFrameA forKey:nil];

    
    
    
    
   
}


- (void)tapAction:(UITapGestureRecognizer *)sender{
    UILabel *label  =(UILabel *)sender.view;

    switch (label.tag - 1000) {
        case 11:
        {
            NSLog(@"CABasicAnimation");
            CABasicAnimationViewController *CABasicView = [[CABasicAnimationViewController alloc]init];
            [self presentViewController:CABasicView animated:YES completion:nil];
        
            
        }
            break;
            
        case 12:
        {
            CAKeyFrameAnimationViewController *vc = [[CAKeyFrameAnimationViewController alloc]init];
            [self presentViewController:vc animated:YES completion:nil];
        }
            
            break;
            
        case 13:
        {
            TransitionViewController *vc = [[TransitionViewController alloc]init];
            [self presentViewController:vc animated:YES completion:nil];
        }
            
                 break;
        case 14:
        {
            CAEmitterLayerViewController *vc = [[CAEmitterLayerViewController alloc]init];
            [self presentViewController:vc animated:YES completion:nil];
        }
                 break;
        case 15:
        {
            ElseViewController *vc = [[ElseViewController alloc]init];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
            [self presentViewController:nav animated:YES completion:nil];
        }
            
            
            
       
        default:
            break;
    }
    
    
    
    
    
}



- (void)shopAction{
    NSLog(@"动画结束了");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
