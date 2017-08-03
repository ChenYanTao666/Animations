//
//  CAKeyFrameAnimationViewController.m
//  动画大全
//
//  Created by yuchen on 2017/7/21.
//  Copyright © 2017年 yuchen. All rights reserved.
//

#import "CAKeyFrameAnimationViewController.h"
#define kAngleToRadian(angle) ((angle) / 180.0 * M_PI)
@interface CAKeyFrameAnimationViewController ()
@property (weak, nonatomic) IBOutlet UIButton *paly;
@property (nonatomic , strong)CALayer * rectLayer;
@property (weak, nonatomic) IBOutlet UIImageView *imagev;
@property (weak, nonatomic) IBOutlet UIButton *stop;
@end

@implementation CAKeyFrameAnimationViewController
- (IBAction)blackAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (IBAction)play:(id)sender {
    [self resumeLayer:self.rectLayer];
    
}
- (IBAction)stop:(id)sender {
    
    [self pauseLayer:self.rectLayer];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    //绕矩形循环跑
    [self initRectLayer];
    
//    // CAGradientLayer 颜色渐变
//    [self CAGradientLayer];
//    
//    
//    // 绘制图形
//    [self CAShapeLayer];
    
    [self.view bringSubviewToFront:self.paly];
    [self.view bringSubviewToFront:self.stop];
    
    
    // 抖动
    [self initWithDoudong];
    
    // 贝塞尔
    [self handleGroupAnimation];
    
    
    
    // Do any additional setup after loading the view from its nib.
}



- (void)initWithDoudong {
    // 创建帧动画对象
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    
    // 设置动画属性
    anim.keyPath = @"transform.rotation";

    anim.values = @[@(kAngleToRadian(-5)), @(kAngleToRadian(5))];
  
    // 设置动画执行次数
    anim.repeatCount = HUGE_VALF;
    
    // 设置动画的执行时长
    anim.duration = 0.1;
    
    // 设置动画的自动反转效果
    anim.autoreverses = YES;
    
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    
    
    // 将动画效果添加到lionImage的layer上
    [self.imagev.layer addAnimation:anim forKey:nil];
    
    
    
    
//    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];//在这里@"transform.rotation"==@"transform.rotation.z"
//    NSValue *value1 = [NSNumber numberWithFloat:-M_PI/180*4];
//    NSValue *value2 = [NSNumber numberWithFloat:M_PI/180*4];
//    NSValue *value3 = [NSNumber numberWithFloat:-M_PI/180*4];
//    anima.values = @[value1,value2,value3];
//    anima.repeatCount = MAXFLOAT;
//    
//    [_demoView.layer addAnimation:anima forKey:@"shakeAnimation"];
    
}




- (void)CAShapeLayer{
    CAShapeLayer *grasslandOne = [CAShapeLayer new];
    UIBezierPath *pathOne = [UIBezierPath new];
    [pathOne moveToPoint:CGPointMake(0, self.view.bounds.size.height - 20)];
    [pathOne addLineToPoint:CGPointMake(0, self.view.bounds.size.height - 100)];
    [pathOne addQuadCurveToPoint:CGPointMake(self.view.bounds.size.width / 3.0, self.view.bounds.size.height - 20) controlPoint:CGPointMake(self.view.bounds.size.width / 6.0, self.view.bounds.size.height - 100)];
    grasslandOne.path = pathOne.CGPath;
    grasslandOne.fillColor = [UIColor colorWithRed:82.0/255.0  green: 177.0/255.0 blue: 44.0/255.0 alpha: 1.0].CGColor;
    [self.view.layer addSublayer:grasslandOne];
    
    
}

- (void)CAGradientLayer {
    CAGradientLayer *layer = [[CAGradientLayer alloc]init];
    layer.frame = [UIScreen mainScreen].bounds;
    layer.colors = @[(id)[UIColor colorWithRed:178.0 / 255.0 green:226.0 / 255.0 blue:248.0 / 255.0 alpha:1].CGColor,(id)[UIColor colorWithRed:232.0 / 255.0 green:234.0 / 255.0 blue:193.0 / 255.0 alpha:1].CGColor];
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(1, 1);
    [self.view.layer addSublayer:layer];
}


- (void)handleGroupAnimation{
    
    // 分组动画
    // 使用关键帧动画创建按照圆形轨迹移动的动画
    CAKeyframeAnimation *keyFrame = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //获取圆形的半径
    CGFloat redius = [UIScreen mainScreen].bounds.size.height / 2.0;
    // 使用贝塞尔曲线 获取圆形轨迹
    UIBezierPath *bezier = [UIBezierPath bezierPathWithArcCenter:CGPointMake(0, redius) radius:redius startAngle:- M_PI_2 endAngle:M_PI_2 clockwise:YES];
//    CAShapeLayer *grasslandOne = [CAShapeLayer new];
//    grasslandOne.path = bezier.CGPath;
//    grasslandOne.fillColor = [UIColor colorWithRed:82.0/255.0  green: 177.0/255.0 blue: 44.0/255.0 alpha: 1.0].CGColor;
//    [self.view.layer addSublayer:grasslandOne];
    // 将气球指定的轨迹为该半圆形轨迹
    keyFrame.path = bezier.CGPath;
    // 设置动画时间
    keyFrame.duration = 5.0;
    //设置重复次数
    keyFrame.repeatCount = 10000;
    //  [self.ballon.layer addAnimation:keyFrame forKey:nil];
    
    CAKeyframeAnimation *keyFrame2 = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    // 设置每一帧动画的放大比例
    keyFrame2.values = @[@1.0,@1.2,@1.4,@1.6,@1.8,@2.0,@1.8,@1.6,@1.4,@1.2,@1.0];
    keyFrame2.duration = 5.0;
    keyFrame2.repeatCount = 10000;
    //  [self.ballon.layer addAnimation:keyFrame2 forKey:nil];
    // 分组动画将多个动画加入到一个分组中同时进行
    //创建分组动画  放多个动画实现同时进行
    CAAnimationGroup *group = [CAAnimationGroup animation];
    //向分组中添加动画
    group.animations = @[keyFrame,keyFrame2];
    // 设置动画的时间
    group.duration = 5;
    // 设置动画重复的次数
    group.repeatDuration = 10000;
    
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    
    [self.imagev.layer addAnimation:group forKey:nil];
    
    
    
//    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(SCREEN_WIDTH/2-100, SCREEN_HEIGHT/2-100, 200, 200)];
//    anima.path = path.CGPath;
//    anima.duration = 2.0f;
//    [_demoView.layer addAnimation:anima forKey:@"pathAnimation"];

    
    
    
}


//绕矩形循环跑
- (void)initRectLayer
{
    
    CALayer * rectLayer = [[CALayer alloc] init];
    rectLayer.frame = CGRectMake(15, 200, 30, 30);
    rectLayer.cornerRadius = 15;
    rectLayer.backgroundColor = [[UIColor blackColor] CGColor];
    [self.view.layer addSublayer:rectLayer];
    CAKeyframeAnimation *rectRunAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //设定关键帧位置，必须含起始与终止位置
    rectRunAnimation.values = @[[NSValue valueWithCGPoint:rectLayer.frame.origin],
                                [NSValue valueWithCGPoint:CGPointMake([UIScreen mainScreen].bounds.size.width - 15,
                                                                      rectLayer.frame.origin.y)],
                                [NSValue valueWithCGPoint:CGPointMake([UIScreen mainScreen].bounds.size.width - 15,
                                                                      rectLayer.frame.origin.y + 100)],
                                [NSValue valueWithCGPoint:CGPointMake(15, rectLayer.frame.origin.y + 100)],
                                [NSValue valueWithCGPoint:rectLayer.frame.origin]];
    
    
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGPathMoveToPoint(path, NULL, rectLayer.position.x - 15, rectLayer.position.y - 15);
//    CGPathAddLineToPoint(path, NULL, 320 - 15, rectLayer.frame.origin.y);
//    CGPathAddLineToPoint(path, NULL, 320 - 15, rectLayer.frame.origin.y + 100);
//    CGPathAddLineToPoint(path, NULL, 15, rectLayer.frame.origin.y + 100);
//    CGPathAddLineToPoint(path, NULL, 15, rectLayer.frame.origin.y);
//    rectRunAnimation.path = path;
//    CGPathRelease(path);
    
    
    
    //设定每个关键帧的时长，如果没有显式地设置，则默认每个帧的时间=总duration/(values.count - 1)
    rectRunAnimation.keyTimes = @[[NSNumber numberWithFloat:0.0], [NSNumber numberWithFloat:0.6],
                                  [NSNumber numberWithFloat:0.7], [NSNumber numberWithFloat:0.8],
                                  [NSNumber numberWithFloat:1]];
    
//    1 kCAMediaTimingFunctionLinear//线性
//    2 kCAMediaTimingFunctionEaseIn//淡入
//    3 kCAMediaTimingFunctionEaseOut//淡出
//    4 kCAMediaTimingFunctionEaseInEaseOut//淡入淡出
//    5 kCAMediaTimingFunctionDefault//默认
    
    
    rectRunAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    rectRunAnimation.repeatCount = 1000;
    rectRunAnimation.autoreverses = NO;
    
//    1 const kCAAnimationLinear//线性，默认
//    2 const kCAAnimationDiscrete//离散，无中间过程，但keyTimes设置的时间依旧生效，物体跳跃地出现在各个关键帧上
//    3 const kCAAnimationPaced//平均，keyTimes跟timeFunctions失效
//    4 const kCAAnimationCubic//平均，同上
//    5 const kCAAnimationCubicPaced//平均，同上
    
    rectRunAnimation.calculationMode = kCAAnimationLinear;
    rectRunAnimation.duration = 4;
    rectRunAnimation.removedOnCompletion = NO;
    rectRunAnimation.fillMode = kCAFillModeForwards;
    [rectLayer addAnimation:rectRunAnimation forKey:@"rectRunAnimation"];
    self.rectLayer = rectLayer;
}

// 暂定
-(void)pauseLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

// 开始
-(void)resumeLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
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
