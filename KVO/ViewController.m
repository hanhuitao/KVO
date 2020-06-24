//
//  ViewController.m
//  KVO
//
//  Created by 韩惠涛 on 2020/6/24.
//  Copyright © 2020 韩惠涛. All rights reserved.
//

#import "ViewController.h"
#import "Dog.h"
@interface ViewController ()
@property(nonatomic, strong)Dog * dog;
@property(nonatomic, strong) UILabel * dogEyeColorChangeLab;
@property(nonatomic, strong) UILabel * dogHealthLab;
@property(nonatomic, strong)NSMutableArray * dogEyeColorArray;



@end

@implementation ViewController
-(NSMutableArray*)dogEyeColorArray
{
    if (!_dogEyeColorArray) {
        _dogEyeColorArray=[NSMutableArray new];
    }
    return _dogEyeColorArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //黑色和深褐色正常，米黄色：肝脏有可能病变，苍白色：角膜炎或贫血，蓝灰色：肝炎
    [self.dogEyeColorArray addObjectsFromArray:@[@"黑色",@"深褐色",@"米黄色",@"苍白色",@"蓝灰色"]];
    Dog *dog = [[Dog alloc]init];
    self.dog = dog;
    dog.eyeColorStr = @"黑色";

    UILabel *dogEyeColorChangeLab = [[UILabel alloc]init];
    dogEyeColorChangeLab.frame = CGRectMake(100, 100, 200, 40);
    dogEyeColorChangeLab.text = [NSString stringWithFormat:@"%@",dog.eyeColorStr];
    dogEyeColorChangeLab.textAlignment=NSTextAlignmentCenter;
    dogEyeColorChangeLab.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:dogEyeColorChangeLab];
    self.dogEyeColorChangeLab = dogEyeColorChangeLab;
    
    [dog addObserver:self forKeyPath:@"eyeColorStr" options:NSKeyValueObservingOptionNew context:nil];
    
    
    UILabel *dogHealthLab = [[UILabel alloc]init];
    dogHealthLab.frame = CGRectMake(100, 200, 200, 40);
    dogHealthLab.text = @"狗狗眼睛健康";
    dogHealthLab.textAlignment=NSTextAlignmentCenter;
    dogHealthLab.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:dogHealthLab];
    self.dogHealthLab = dogHealthLab;
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    int index = arc4random() % self.dogEyeColorArray.count;
    self.dog.eyeColorStr = self.dogEyeColorArray[index];
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
   
    NSLog(@"keyPath=%@,object=%@,change=%@,context=%@",keyPath,object,change,context);
    self.dogEyeColorChangeLab.text = [change objectForKey:@"new"];
    
    if ([[NSString stringWithFormat:@"%@",[change objectForKey:@"new"]] isEqualToString:@"黑色"]||[[NSString stringWithFormat:@"%@",[change objectForKey:@"new"]] isEqualToString:@"深褐色"]) {
        
        self.dogHealthLab.text = @"狗狗眼睛健康";

        
    }else if([[NSString stringWithFormat:@"%@",[change objectForKey:@"new"]] isEqualToString:@"米黄色"])
    {
        self.dogHealthLab.text = @"肝脏病变";

    }else if([[NSString stringWithFormat:@"%@",[change objectForKey:@"new"]] isEqualToString:@"苍白色"])
    {
        self.dogHealthLab.text = @"角膜炎或贫血";

    }else if([[NSString stringWithFormat:@"%@",[change objectForKey:@"new"]] isEqualToString:@"蓝灰色"])
    {
        self.dogHealthLab.text = @"肝炎";

    }

}

@end
