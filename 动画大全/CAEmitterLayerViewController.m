//
//  CAEmitterLayerViewController.m
//  动画大全
//
//  Created by yuchen on 2017/7/27.
//  Copyright © 2017年 yuchen. All rights reserved.
//

#import "CAEmitterLayerViewController.h"

@interface CAEmitterLayerViewController ()
@property (nonatomic,strong)CAEmitterLayer *fireEmitter;

@end
static NSString *kX = @"curveX";
static NSString *kY = @"curveY";
@implementation CAEmitterLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(10, 10, 80, 50);
    [button1 setTitle:@"返回" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(black) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    self.view.backgroundColor = [UIColor whiteColor];
    [self effectOfParticle];
    
    [self CAEmitterLayer];
    // Do any additional setup after loading the view.
}
- (void)black{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}



- (void) CAEmitterLayer{
//    self.view.backgroundColor=[UIColor blackColor];
    //设置发射器
    _fireEmitter=[[CAEmitterLayer alloc]init];
    _fireEmitter.emitterPosition=CGPointMake(self.view.frame.size.width/2,self.view.frame.size.height-20);
    _fireEmitter.emitterSize=CGSizeMake(self.view.frame.size.width-100, 20);
    _fireEmitter.renderMode = kCAEmitterLayerAdditive;
    //发射单元
    //火焰
    CAEmitterCell * fire = [CAEmitterCell emitterCell];
    fire.birthRate=800;
    fire.lifetime=2.0;
    fire.lifetimeRange=1.5;
    fire.color=[[UIColor colorWithRed:0.8 green:0.4 blue:0.2 alpha:0.1]CGColor];
    fire.contents=(id)[[UIImage imageNamed:@"2.png"]CGImage];
    [fire setName:@"fire"];
    fire.velocity=160;
    fire.velocityRange=80;
    fire.emissionLongitude=M_PI+M_PI_2;
    fire.emissionRange=M_PI_2;
    fire.scaleSpeed=0.3;
    fire.spin=0.2;
    
    //烟雾
    CAEmitterCell * smoke = [CAEmitterCell emitterCell];
    smoke.birthRate=400;
    smoke.lifetime=3.0;
    smoke.lifetimeRange=1.5;
    smoke.color=[[UIColor colorWithRed:1 green:1 blue:1 alpha:0.05]CGColor];
    smoke.contents=(id)[[UIImage imageNamed:@"2.png"]CGImage];
    [fire setName:@"smoke"];
    smoke.velocity=250;
    smoke.velocityRange=100;
    smoke.emissionLongitude=M_PI+M_PI_2;
    smoke.emissionRange=M_PI_2;
    
    _fireEmitter.emitterCells=[NSArray arrayWithObjects:smoke,fire,nil];
    [self.view.layer addSublayer:_fireEmitter];
}

//粒子效果
-(void)effectOfParticle{
    /*
     
     CAEmitterLayer 粒子发射器
     
     spin：粒子的旋转位置
     
     scale：粒子的缩放大小
     
     seed：初始化随机的粒子种子
     
     lifetime：粒子的存活时间，默认为1s
     
     birthRate：粒子的创建速率，默认为1/s
     
     velocity：粒子的运动速度
     
     emitterCells：粒子单元数组
     
     emitterSize：发射器尺寸大小
     
     emitterDepth：设置发射器的深度，在某些模式下会产生立体效果
     
     emitterPosition：发射器在xy平面的中心位置
     
     emitterZPosition：发射器在z平面的位置
     
     preservesDepth：是否开启三维空间效果
     
     emitterShape：发射器的形状，这个参数的几个系统字符串如下：
     
     kCAEmitterLayerLine：线的形状，粒子从一条线发出
     
     kCAEmitterLayerPoint：点的形状，粒子从一个点发出
     
     kCAEmitterLayerRectangle：矩形形状，粒子从一个矩形发出
     
     kCAEmitterLayerCuboid：立方体形状，会影响z平面的效果
     
     kCAEmitterLayerCircle：圆形形状，粒子会在圆形范围内发出
     
     kCAEmitterLayerSphere：球形
     
     emitterMode：发射器的发射模式，参数如下：
     
     kCAEmitterLayerPoints：从发射器中发出
     
     kCAEmitterLayerOutline：从发射器边缘发出
     
     kCAEmitterLayerSurface：从发射器表面发出
     
     kCAEmitterLayerVolume：从发射器中点发出
     
     renderMode：发射器渲染模式，参数如下：
     
     kCAEmitterLayerUnordered：这种模式下，粒子是无序出现的，多个发射源将混合
     
     kCAEmitterLayerOldestFirst：这种模式下，声明久的粒子会被渲染在最上层
     
     kCAEmitterLayerOldestLast：这种模式下，年轻的粒子会被渲染在最上层
     
     kCAEmitterLayerBackToFront：这种模式下，粒子的渲染按照Z轴的前后顺序进行
     
     kCAEmitterLayerAdditive：这种模式会进行粒子混合
     
  */
   
    /*
    
    CAEmitterCell
    name：设置发射单元的名称
    
    enabled：是否允许发射器渲染
    
    birthRate：粒子的创建速率
    
    lifetime：粒子的生存时间
    
    lifetimeRange：粒子的生存时间容差
    
    emissionLatitude：粒子在Z轴方向的发射角度
    
    emissionLongitude：粒子在xy平面的发射角度
    
    emissionRange：粒子发射角度的容差
    
    velocity：粒子的速度
    
    velocityRange：粒子速度的容差
    
    xAcceleration：x方向的加速度
    
    yAcceleration：y方向的加速度
    
    zAcceleration：z方向的加速度
    
    spin：旋转度
    
    spinRange：旋转度容差
    
    contents：渲染粒子，可以设置为一个CGImage的对象
    
    contentsRect：渲染的范围
    */
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width / 2 , self.view.bounds.size.height / 5.0, 100, 100)];
    // view.backgroundColor = [UIColor yellowColor];
    view.layer.cornerRadius = 50;
    [self.view addSubview:view];
    //create particle emmitter layer
    //CAEmitterLayer负责发射粒子(粒子也可以发射粒子)
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    emitter.frame = view.bounds;
    //决定粒子发射形状的中心点
    //  emitterPosition：发射器在xy平面的中心位置
    emitter.emitterPosition = CGPointMake(10, 10);
   //    发射器在z平面的位置
    emitter.emitterZPosition = 3.0;
//    emitterShape：发射器的形状，
//    kCAEmitterLayerLine：线的形状，粒子从一条线发出
//    kCAEmitterLayerPoint：点的形状，粒子从一个点发出
//    kCAEmitterLayerRectangle：矩形形状，粒子从一个矩形发出
//    kCAEmitterLayerCuboid：立方体形状，会影响z平面的效果
//    kCAEmitterLayerCircle：圆形形状，粒子会在圆形范围内发出
//    kCAEmitterLayerSphere：球形
    emitter.emitterShape = kCAEmitterLayerSphere;//发射器形状
    
//    emitterMode：发射器的发射模式，参数如下：
//    kCAEmitterLayerPoints：从发射器中发出
//    kCAEmitterLayerOutline：从发射器边缘发出
//    kCAEmitterLayerSurface：从发射器表面发出
//    kCAEmitterLayerVolume：从发射器中点发出
    emitter.emitterMode = kCAEmitterLayerOutline;//3d圆形的体积内发射
    emitter.preservesDepth = YES; //是否开启三维空间模式
    emitter.emitterDepth = 2.0;//发射器的深度，有时可能会产生立体效果
    emitter.spin = 50;//粒子的旋转角度
    [view.layer addSublayer:emitter];
    
    //configure emitter
    
//    renderMode：发射器渲染模式，参数如下：
//    kCAEmitterLayerUnordered：这种模式下，粒子是无序出现的，多个发射源将混合
//    kCAEmitterLayerOldestFirst：这种模式下，声明久的粒子会被渲染在最上层
//    kCAEmitterLayerOldestLast：这种模式下，年轻的粒子会被渲染在最上层
//    kCAEmitterLayerBackToFront：这种模式下，粒子的渲染按照Z轴的前后顺序进行
//    kCAEmitterLayerAdditive：这种模式会进行粒子混合

    emitter.renderMode = kCAEmitterLayerAdditive;//渲染模式
    //emitter.emitterPosition = CGPointMake(emitter.frame.size.width /2.0, emitter.frame.size.height / 2.0);
    //creat a particle template]
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
//       contents：渲染粒子，可以设置为一个CGImage的对象
    cell.contents = (__bridge id _Nullable)([UIImage imageNamed:@"2.png"].CGImage);
//        birthRate：粒子的创建速率
    cell.birthRate = 15.0;
//      lifetime：粒子的存活时间，默认为1s
    cell.lifetime = 10.0;
    cell.enabled = YES;//是否打开粒子的渲染效果
    //  cell.color = [UIColor colorWithRed:1 green:0.5 blue:0.1 alpha:1.0].CGColor;
    cell.alphaSpeed = -0.4;
    cell.velocity = 50; //粒子的速度    velocity：粒子的运动速度
    cell.velocityRange = 70;//粒子的速度范围  粒子速度的容差
    cell.emissionRange = M_PI * 2.0;   // 粒子发射角度的容差
    //creat a particle template]
    CAEmitterCell *cell2 = [[CAEmitterCell alloc] init];
    cell2.contents = (__bridge id _Nullable)([UIImage imageNamed:@"2.png"].CGImage);
    cell2.birthRate = 15.0;
    cell2.lifetime = 10.0;
    cell2.color = [UIColor colorWithRed:1 green:0.5 blue:0.1 alpha:1.0].CGColor;
    cell2.alphaSpeed = -0.4;
    cell2.velocity = 50;
    cell2.velocityRange = 50;
    cell2.emissionRange = M_PI * 2.0;
    //add pareticle template to emitter
    emitter.emitterCells = @[cell,cell2];
    
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
