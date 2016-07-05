//
//  CommunityCommentsModel.m
//  HiChaoDemo01
//
//  Created by Mac on 16/7/5.
//  Copyright © 2016年 surker. All rights reserved.
//

#import "CommunityCommentsModel.h"

@implementation CommunityCommentsModel
-(instancetype)initWithNSDictionary:(NSDictionary *)dic
{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dic];
//        NSLog(@"%@-->%@-->%@",self.username,self.content,self.title);
    }
    return self;
}
+(instancetype)createCommunityCommentsModelWith:(NSDictionary *)dic
{
    return [[self alloc]initWithNSDictionary:dic];
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{}
@end
