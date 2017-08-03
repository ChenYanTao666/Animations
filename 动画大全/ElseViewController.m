//
//  ElseViewController.m
//  动画大全
//
//  Created by yuchen on 2017/8/3.
//  Copyright © 2017年 yuchen. All rights reserved.
//

#import "ElseViewController.h"
#import "BaseAnimationController.h"
#import "KeyFrameAnimationController.h"
#import "GroupAnimationController.h"
#import "TransitionAnimationController.h"
#import "ComprehensiveCaseController.h"
#import "AffineTransformController.h"

@interface ElseViewController ()

@end

@implementation ElseViewController

- (IBAction)black:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)buttonAction:(UIButton *)sender {
    
    UIViewController *viewController;
    switch (sender.tag - 10000) {
        case 0:
            viewController = [[BaseAnimationController alloc] init];
            break;
        case 1:
            viewController = [[KeyFrameAnimationController alloc] init];
            break;
        case 2:
            viewController = [[GroupAnimationController alloc] init];
            break;
        case 3:
            viewController = [[TransitionAnimationController alloc] init];
            break;
        case 4:
            viewController = [[AffineTransformController alloc] init];
            break;
        case 5:
            viewController = [[ComprehensiveCaseController alloc] init];
            break;
        default:
            break;
    }
    
    [self.navigationController pushViewController:viewController animated:YES];
    
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
