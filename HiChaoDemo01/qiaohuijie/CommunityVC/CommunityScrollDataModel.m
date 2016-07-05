//
//  CommunityScrollDataModel.m
//  HiChaoDemo01
//
//  Created by Mac on 16/7/4.
//  Copyright © 2016年 surker. All rights reserved.
//

#import "CommunityScrollDataModel.h"

@implementation CommunityScrollDataModel
-(instancetype)initWithNSDictionary:(NSDictionary *)dic
{
    if (self=[super init]) {
        self.picUrl=dic[@"picUrl"];
    }
    return self;
}
+(instancetype)createCommunityScrollDataModelWith:(NSDictionary *)dic
{
    return [[self alloc]initWithNSDictionary:dic];
}
@end
