//
//  IntroduceVC.h
//  HiChaoDemo01
//
//  Created by Mac on 16/7/2.
//  Copyright © 2016年 surker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlockTypeDefault.h"
@interface IntroduceVC : UIViewController

@property (nonatomic,copy) DidSelectedEnter block;
- (void)didEnterRootVC:(DidSelectedEnter) newBlock;

@end
