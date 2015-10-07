//
//  ViewController.m
//  InstagramLogin
//
//  Created by Admin on 04.10.15.
//  Copyright (c) 2015 Ignatenko_Alexandr. All rights reserved.
//

#import "ViewController.h"
#import "SANServerManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor yellowColor];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 300, 30)];
    [button setTitle:@"login" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    

}


- (void)login:(UIButton *)sender {
    SANServerManager *manager = [[SANServerManager alloc] init];
    [manager authorizeUser:^(SANUser *user) {
        NSLog(@"authorization");
    }];
}

@end
