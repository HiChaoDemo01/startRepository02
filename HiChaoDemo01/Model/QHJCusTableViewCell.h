//
//  QHJCusTableViewCell.h
//  HiChaoDemo01
//
//  Created by Mac on 16/7/5.
//  Copyright © 2016年 surker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunityTableDataModel.h"
@interface QHJCusTableViewCell : UITableViewCell
@property(strong,nonatomic)CommunityTableDataModel *model;
-(void)removeView;
@end
