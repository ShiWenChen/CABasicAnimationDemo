//
//  ViewController.m
//  CBAnmintionDemo
//
//  Created by ShiWen on 2017/7/5.
//  Copyright © 2017年 ShiWen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<CAAnimationDelegate>
@property (nonatomic,strong)UIView *testView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.testView];
    
    //指定position属性
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.delegate = self;
//    动画时长
    animation.duration = 3;
//    重复次数
    animation.repeatCount = 1000;
//    动画结束后是否执行逆动画
    animation.autoreverses = YES;
//    动画执行模式 先加速后减速
    /*
//     匀速
     CA_EXTERN NSString * const kCAMediaTimingFunctionLinear
     CA_AVAILABLE_STARTING (10.5, 2.0, 9.0, 2.0);
     //先减速后加速
     CA_EXTERN NSString * const kCAMediaTimingFunctionEaseIn
     CAfAVAILABLE_STARTING (10.5, 2.0, 9.0, 2.0);
     //先加速后减速
     CA_EXTERN NSString * const kCAMediaTimingFunctionEaseOut
     CA_AVAILABLE_STARTING (10.5, 2.0, 9.0, 2.0);
//     逐步变快
     CA_EXTERN NSString * const kCAMediaTimingFunctionEaseInEaseOut
     CA_AVAILABLE_STARTING (10.5, 2.0, 9.0, 2.0);
//     慢快慢
     CA_EXTERN NSString * const kCAMediaTimingFunctionDefault
     CA_AVAILABLE_STARTING (10.6, 3.0, 9.0, 2.0);
     */
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//    开始移动的点   以中心点为坐标原点
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
//    结束的点
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(375, 667)];
//    添加动画
//    [self.testView.layer addAnimation:animation forKey:@"moveAction"];
    
//    旋转动画 以Y轴旋转
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
//    动画持续时间
    rotateAnimation.duration = 2.5;
//    动画重复次数
    rotateAnimation.repeatCount = 4;
//旋转角度起始角度
    rotateAnimation.fromValue = [NSNumber numberWithFloat:0.0];
//    结束时角度
    rotateAnimation.toValue = [NSNumber numberWithFloat:2*M_PI];
//    [self.testView.layer addAnimation:rotateAnimation forKey:@"rotationAction"];
    
//    缩放动画
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.duration = 2.5;
    scaleAnimation.repeatCount = 4;
    scaleAnimation.fromValue = [NSNumber numberWithBool:1.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:2.0];
    scaleAnimation.autoreverses = YES;
//    [self.testView.layer addAnimation:scaleAnimation forKey:@"scaleAction"];
    
//    动画组
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    group.duration = 3;
    group.repeatCount = 3;
    group.animations = @[animation,rotateAnimation,scaleAnimation];
//    是否执行反动画
//    group.autoreverses = YES;
//    设置动画结束后停留位置
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeBoth;

    [self.testView.layer addAnimation:group forKey:@"moveAndRotationAndScale"];
    
    

}
//动画开始时代理
-(void)animationDidStart:(CAAnimation *)anim{
//    通过动画添加的View的layer上，可以获取anim，和当前anim对比即可
    NSLog(@"%@",[self.testView.layer animationForKey:@"moveAction"]);
}
//动画结束时候代理
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"动画结束");
}
-(UIView*)testView{
    if (!_testView) {
        _testView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
        _testView.center = self.view.center;
        _testView.backgroundColor = [UIColor redColor];
    }
    return _testView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
