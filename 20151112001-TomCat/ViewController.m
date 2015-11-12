//
//  ViewController.m
//  20151112001-TomCat
//
//  Created by Rainer on 15/11/12.
//  Copyright © 2015年 Sand. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *tomImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

/**
 *  按钮点击事件
 */
- (IBAction)didClickButtonAction:(UIButton *)sender {
    // 1.判断是否正在执行动画，如果正在执行则不做任何操作
    if (self.tomImageView.isAnimating) return;
    
    // 2.从plist文件中读取动画的图片
    NSString *tomImagePath = [[NSBundle mainBundle] pathForResource:@"tom" ofType:@"plist"];
    NSDictionary *tomDictionary = [NSDictionary dictionaryWithContentsOfFile:tomImagePath];
    
    // 3.获取当前按钮的标题，通过标题从字典中读取图片张数
    NSString *buttonCurrentTitle = sender.currentTitle;
    NSInteger count = [NSString stringWithFormat:@"%@", [tomDictionary objectForKey:buttonCurrentTitle]].integerValue;
    
    // 4.调用动画执行方法
    [self tomAnimationsWithName:buttonCurrentTitle count:count];
}

/**
 *  动画执行方法
 */
- (void)tomAnimationsWithName:(NSString *)name count:(NSInteger)count {
    // 1.定一个一个数组用来装序列帧动画的图片组
    NSMutableArray *imageArray = [NSMutableArray array];
    
    // 2.循环创建图片，并逐个添加到数组中
    for (int i = 0; i < count; i++) {
        NSString *imageName = [NSString stringWithFormat:@"%@_%02d.jpg", name, i];
        
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:nil];
        
        UIImage *tomeImage = [UIImage imageWithContentsOfFile:imagePath];
        
        [imageArray addObject:tomeImage];
    }
    
    // 3.设置序列帧动画属性
    self.tomImageView.animationImages = imageArray;
    self.tomImageView.animationRepeatCount = 1;
    self.tomImageView.animationDuration = count * 0.075;
    
    // 4.开始动画
    [self.tomImageView startAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
