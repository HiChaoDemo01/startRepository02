//
//  CommunityHeadPicModel.h
//  HiChaoDemo01
//
//  Created by Mac on 16/7/4.
//  Copyright © 2016年 surker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommunityHeadPicModel : NSObject
@property(copy,nonatomic)NSString *userAvatar;
-(instancetype)initWithNSDictionary:(NSDictionary *)dic;
+(instancetype)createCommunityHeadPicModelWithDic:(NSDictionary *)dic;
@end
