//
//  ViewController.m
//  DLThemesDemo
//
//  Created by Autel_Ling on 2020/2/25.
//  Copyright © 2020 DL_muyang. All rights reserved.
//

#import "ViewController.h"
#import "DLThemes.h"
#import "DLThemeManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundDLTuple:@[[UIColor blueColor], [UIColor orangeColor], [UIColor redColor]]];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 150, 100, 100)];
    label.text = @"UILabel";
    label.font = [UIFont systemFontOfSize:20];
    label.textDLTuple = @[[UIColor whiteColor], [UIColor redColor], [UIColor blackColor]];
    label.layer.borderColor = [UIColor lightGrayColor].CGColor;
    label.layer.borderWidth = 1;
    [self.view addSubview:label];
    
    UIButton *button0 = [UIButton buttonWithType:UIButtonTypeCustom];
    button0.frame = CGRectMake(200, 150, 100, 100);
    [button0 setTitle:@"UIButton0" forState:UIControlStateNormal];
    button0.titleLabel.font = [UIFont systemFontOfSize:20];
    [button0 setTitleDLTuple:@[[UIColor whiteColor], [UIColor redColor], [UIColor blackColor]] forState:UIControlStateNormal];
    [button0 setImageTuple:@[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon0" ofType:@"jpeg"]], [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon1" ofType:@"jpeg"]], [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon2" ofType:@"jpeg"]]] forState:UIControlStateNormal];
    button0.layer.borderColor = [UIColor lightGrayColor].CGColor;
    button0.layer.borderWidth = 1;
    [self.view addSubview:button0];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(50, 300, 100, 100);
    [button1 setTitle:@"UIButton1" forState:UIControlStateNormal];
    button1.titleLabel.font = [UIFont systemFontOfSize:20];
    [button1 setTitleDLTuple:@[[UIColor redColor], [UIColor blackColor], [UIColor whiteColor]] forState:UIControlStateSelected];
    [button1 setBackgroundImageTuple:@[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon1" ofType:@"jpeg"]], [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon2" ofType:@"jpeg"]], [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon0" ofType:@"jpeg"]]] forState:UIControlStateSelected];
    button1.selected = YES;
    button1.layer.borderColor = [UIColor lightGrayColor].CGColor;
    button1.layer.borderWidth = 1;
    [self.view addSubview:button1];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(200, 300, 100, 100)];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [imageView setImageTuple:@[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon2" ofType:@"jpeg"]], [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon0" ofType:@"jpeg"]], [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon1" ofType:@"jpeg"]]]];
    [self.view addSubview:imageView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSInteger rr = arc4random() % 3;
    [DLThemeManager defaultManager].themeNum = rr;
    NSLog(@"%@", @(rr));
}


@end
