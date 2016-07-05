//
//  IntroduceVC.m
//  HiChaoDemo01
//
//  Created by Mac on 16/7/2.
//  Copyright © 2016年 surker. All rights reserved.
//

#import "IntroduceVC.h"

@interface IntroduceVC ()

@end

@implementation IntroduceVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //创建引导页视图
    
    [self createView];
    //延时调用进入主界面
    [self performSelector:@selector(btnClick:) withObject:nil afterDelay:1.5];

    
    
    
    }

- (void)createView {
    
    //发送请求引导页图片
    
        [SQSRequest sendRequestFroIntroduceImage:^(NSString *imageUrl) {
            
            UIImageView *bgImage = [[UIImageView alloc]initWithFrame:kMainBounds];
            if ([imageUrl isEqualToString:@""]) {
                
                bgImage.image = [UIImage imageNamed:@"960-640-1"];
                
            } else {
                
                [bgImage sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
                
            }
            
            
            [self.view addSubview:bgImage];
            
        }];
    
    
}

- (void)didEnterRootVC:(DidSelectedEnter)newBlock {
    
    
    
    self.block = newBlock;
}


- (void)btnClick:(UIButton *)sender {
    
    self.block();
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
