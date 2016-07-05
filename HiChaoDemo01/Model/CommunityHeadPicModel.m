//
//  CommunityHeadPicModel.m
//  HiChaoDemo01
//
//  Created by Mac on 16/7/4.
//  Copyright © 2016年 surker. All rights reserved.
//

#import "CommunityHeadPicModel.h"

@implementation CommunityHeadPicModel
-(instancetype)initWithNSDictionary:(NSDictionary *)dic
{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
+(instancetype)createCommunityHeadPicModelWithDic:(NSDictionary *)dic
{
    return [[self alloc]initWithNSDictionary:dic];
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}
@end
