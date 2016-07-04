//
//  SQSTimelimitModel.h
//  HiChaoDemo01
//
//  Created by Mac on 16/7/4.
//  Copyright © 2016年 surker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQSTimelimitModel : NSObject
@property(nonatomic,copy)NSString *end_time;
@property (nonatomic,copy)NSString *img_index;
- (instancetype)initTimelimitModelWith:(NSDictionary *)dataDic;

+ (instancetype)createTimelimitModelWith:(NSDictionary *)dataDic;

@end
