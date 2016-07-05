//
//  CommunitySupportUsersModel.m
//  HiChaoDemo01
//
//  Created by Mac on 16/7/5.
//  Copyright © 2016年 surker. All rights reserved.
//

#import "CommunitySupportUsersModel.h"

@implementation CommunitySupportUsersModel
-(instancetype)initWithNSDictionary:(NSDictionary *)dic
{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dic];
//        NSLog(@"%@==%@==%@",self.userAvatar,self.userId,self.username);
    }
    return self;
}
+(instancetype)createCommunitySupportUsersModel:(NSDictionary *)dic
{
    return [[self alloc]initWithNSDictionary:dic];
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{}
@end
