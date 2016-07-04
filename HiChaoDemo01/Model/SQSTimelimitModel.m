//
//  SQSTimelimitModel.m
//  HiChaoDemo01
//
//  Created by Mac on 16/7/4.
//  Copyright © 2016年 surker. All rights reserved.
//

#import "SQSTimelimitModel.h"

@implementation SQSTimelimitModel

- (instancetype)initTimelimitModelWith:(NSDictionary *)dataDic {
    self = [super init];
    if (self) {
        
    [self setValuesForKeysWithDictionary:dataDic];
        
        
    }
    return self;
    
    
}

+ (instancetype)createTimelimitModelWith:(NSDictionary *)dataDic {
    
    
    return  [[self alloc]initTimelimitModelWith:dataDic];
    
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
}



@end
