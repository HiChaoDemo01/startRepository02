//
//  CommunityShareModel.m
//  HiChaoDemo01
//
//  Created by Mac on 16/7/5.
//  Copyright © 2016年 surker. All rights reserved.
//

#import "CommunityShareModel.h"

@implementation CommunityShareModel
-(instancetype)initWithNSDictionary:(NSDictionary *)dic
{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dic];
//        NSLog(@"%@--%@--%@--%@",self.descrip,self.title,self.detailUrl,self.picUrl);
    }
    return self;
}
+(instancetype)createCommunityShareModelWith:(NSDictionary *)dic
{
    return [[self alloc]initWithNSDictionary:dic];
}
-(void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"description"]) {
        self.descrip = value;
    }
    else
    {
        [super setValue:value forKey:key];
    }
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{}
@end
