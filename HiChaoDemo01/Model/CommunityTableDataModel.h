//
//  CommunityTableDataModel.h
//  HiChaoDemo01
//
//  Created by Mac on 16/7/4.
//  Copyright © 2016年 surker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommunityTagsModel.h"
#import "CommunityCommentsModel.h"
#import "CommunityHeadPicModel.h"
#import "CommunitySupportUsersModel.h"
#import "CommunityShareModel.h"
@interface CommunityTableDataModel : NSObject
@property(copy,nonatomic)NSString *userName,*datatime,*commentCount,*content;
@property(strong,nonatomic)CommunityHeadPicModel *avatarModel;
@property(strong,nonatomic)CommunityShareModel *shareModel;
@property(strong,nonatomic)NSMutableArray *pics;
@property(strong,nonatomic)NSMutableArray *tags;
@property(strong,nonatomic)NSMutableArray *users;
@property(strong,nonatomic)NSMutableArray *comments;
-(instancetype)initWithNSDictionary:(NSDictionary *)dic;
+(instancetype)CreateCommunityTableDataModel:(NSDictionary *)dic;

@end
