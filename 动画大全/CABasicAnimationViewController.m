//
//  CABasicAnimationViewController.m
//  动画大全
//
//  Created by yuchen on 2017/7/21.
//  Copyright © 2017年 yuchen. All rights reserved.
//

#import "CABasicAnimationViewController.h"

@interface CABasicAnimationViewController ()<CAAnimationDelegate>

@end

@implementation CABasicAnimationViewController
- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView  *view = [[UIView alloc]initWithFrame:CGRectMake(10, 50, 50, 50)];
    view.center  = CGPointMake([UIScreen mainScreen].bounds.size.width / 2 - view.bounds.size.width / 2, view.center.y);
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
   
    
    // 一些常用的key
    /*   transform.scale	比例转化	@(0.8)
     transform.scale.x	宽的比例	@(0.8)
     transform.scale.y	高的比例	@(0.8)
     transform.rotation.x	围绕x轴旋转	@(M_PI)
     transform.rotation.y	围绕y轴旋转	@(M_PI)
     transform.rotation.z	围绕z轴旋转	@(M_PI)
     cornerRadius	圆角的设置	@(50)
     backgroundColor	背景颜色的变化	(id)[UIColor purpleColor].CGColor
     bounds	大小，中心不变	[NSValue valueWithCGRect:CGRectMake(0, 0, 200, 200)];
     position	位置(中心点的改变)	[NSValue valueWithCGPoint:CGPointMake(300, 300)];
     contents	内容，比如UIImageView的图片	imageAnima.toValue = (id)[UIImage imageNamed:@"to"].CGImage;
     opacity	透明度	@(0.7)
     contentsRect.size.width	横向拉伸缩放	@(0.4)最好是0~1之间的
     */
    
    
    
    
    
  /*  属性	说明
    duration	动画的时长
    repeatCount	重复的次数。不停重复设置为 HUGE_VALF
    repeatDuration	设置动画的时间。在该时间内动画一直执行，不计次数。
    beginTime	指定动画开始的时间。从开始延迟几秒的话，设置为【CACurrentMediaTime() + 秒数】 的方式
    timingFunction	设置动画的速度变化
    autoreverses	动画结束时是否执行逆动画
    fromValue	所改变属性的起始值
    toValue	所改变属性的结束时的值
    byValue	所改变属性相同起始值的改变量
   */
    
    CABasicAnimation *transformAnima = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    
    transformAnima.fromValue = @(M_PI_2);
    transformAnima.toValue = @(M_PI);
    transformAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transformAnima.autoreverses = YES;
    transformAnima.repeatCount = HUGE_VALF;
    transformAnima.beginTime = CACurrentMediaTime() + 1;
    
    
    // 这两个是在动画结束之后使view 到最终状态而不是原始状态  因为layer 层动画 其实view 本身frame 没有改变的
    transformAnima.removedOnCompletion = NO;
    transformAnima.fillMode = kCAFillModeForwards;
//    fillMode
  /* 该属性定义了你的动画在开始和结束时的动作。默认值是 kCAFillModeRemoved。
    取值的解释
    kCAFillModeRemoved 设置为该值，动画将在设置的 beginTime 开始执行（如没有设置beginTime属性，则动画立即执行），动画执行完成后将会layer的改变恢复原状。
    kCAFillModeForwards 设置为该值，动画即使之后layer的状态将保持在动画的最后一帧，而removedOnCompletion的默认属性值是 YES，所以为了使动画结束之后layer保持结束状态，应将removedOnCompletion设置为NO。
    kCAFillModeBackwards 设置为该值，将会立即执行动画的第一帧，不论是否设置了 beginTime属性。观察发现，设置该值，刚开始视图不见，还不知道应用在哪里。
    kCAFillModeBoth 该值是 kCAFillModeForwards 和 kCAFillModeBackwards的组合状态
    */
   
    
   // 添加动画
    [view.layer addAnimation:transformAnima forKey:@"A"];
   
    // 动画组合
    CABasicAnimation *positionAnima = [CABasicAnimation animationWithKeyPath:@"position.y"];
    positionAnima.duration = 0.8;
    positionAnima.fromValue = @(view.center.y);
    positionAnima.toValue =  @(view.center.y + 100);
    positionAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    positionAnima.repeatCount = HUGE_VALF;
//    positionAnima.repeatDuration = 2;
    positionAnima.removedOnCompletion = NO;
    positionAnima.fillMode = kCAFillModeForwards;
    positionAnima.delegate = self;
    positionAnima.autoreverses = YES; // 执行逆动画
    [view.layer addAnimation:positionAnima forKey:@"AnimationMoveY"];
    
 
    /* 放大缩小 */
    
    // 设定为缩放
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    // 动画选项设定
    animation.duration = 2.5; // 动画持续时间
    animation.repeatCount = HUGE_VALF; // 重复次数
    animation.autoreverses = YES; // 动画结束时执行逆动画
    // 缩放倍数
    animation.fromValue = [NSNumber numberWithFloat:1.0]; // 开始时的倍率
    animation.toValue = [NSNumber numberWithFloat:2.0]; // 结束时的倍率
    // 添加动画
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [view.layer addAnimation:animation forKey:@"scale-layer"];
    
    
//    /* 动画组 */
//    CAAnimationGroup *group = [CAAnimationGroup animation];
//    
//    // 动画选项设定
//    group.duration = 3.0;
//    group.repeatCount = 1;
//    group.animations = [NSArray arrayWithObjects:animation1, animation2, nil nil];  
//    [view.layer addAnimation:group forKey:@"scale-layer"];

    
    // 透明度
    
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"opacity"];
    anima.fromValue = [NSNumber numberWithFloat:1.0f];
    anima.toValue = [NSNumber numberWithFloat:0.2f];
    anima.duration = 1.0f;
    [view.layer addAnimation:anima forKey:@"opacityAniamtion"];
    
    
    
    /**
     *  旋转动画
     */
    
    CABasicAnimation *anima1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//绕着z轴为矢量，进行旋转(@"transform.rotation.z"==@@"transform.rotation")
        anima1.toValue = [NSNumber numberWithFloat:M_PI];
        anima1.duration = 1.0f;
        [view.layer addAnimation:anima1 forKey:@"rotateAnimation"];

    
    /**
     *  背景色变化动画
     */
    
        CABasicAnimation *anima11 = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
        anima11.toValue =(id) [UIColor greenColor].CGColor;
        anima11.duration = 1.0f;
        [view.layer addAnimation:anima11 forKey:@"backgroundAnimation"];
    
    
    
    
    // Do any additional setup after loading the view from its nib.
}


//动画开始时
- (void)animationDidStart:(CAAnimation *)anim
{
    NSLog(@"开始了");
}

//动画结束时
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    //方法中的flag参数表明了动画是自然结束还是被打断,比如调用了removeAnimationForKey:方法或removeAnimationForKey方法，flag为NO，如果是正常结束，flag为YES。
    NSLog(@"结束了");
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
