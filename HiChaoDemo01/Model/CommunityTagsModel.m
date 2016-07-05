//
//  CommunityTagsModel.m
//  HiChaoDemo01
//
//  Created by Mac on 16/7/5.
//  Copyright © 2016年 surker. All rights reserved.
//
/******标签model******/
#import "CommunityTagsModel.h"

@implementation CommunityTagsModel
-(instancetype)initWithNSDictionary:(NSDictionary *)dic
{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dic];
//        NSLog(@"category: %@",self.category);
    }
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{}
+(instancetype)createCommunityTagsModelWithDic:(NSDictionary *)dic
{
    return [[self alloc]initWithNSDictionary:dic];
}
@end
