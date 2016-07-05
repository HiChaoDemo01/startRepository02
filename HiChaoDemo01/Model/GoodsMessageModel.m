//
//  GoodsMessageModel.m
//  HiChaoDemo01
//
//  Created by Mac on 16/7/4.
//  Copyright © 2016年 surker. All rights reserved.
//

#import "GoodsMessageModel.h"

@implementation GoodsMessageModel

- (instancetype)initGoodsMessageModelWith:(NSDictionary *)dic {
    
    if (self= [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
        
        
        
        
    }
    return self;
    
    
    
}
+ (instancetype)createGoodsMessageModelWith:(NSDictionary *)dic {
    
    
    return [[self alloc]initGoodsMessageModelWith:dic];
    
    
    
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
    
    
    
}





@end
