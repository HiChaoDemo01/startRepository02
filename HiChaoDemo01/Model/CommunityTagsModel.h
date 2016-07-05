//
//  CommunityTagsModel.h
//  HiChaoDemo01
//
//  Created by Mac on 16/7/5.
//  Copyright © 2016年 surker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommunityTagsModel : NSObject
@property(copy,nonatomic)NSString *category;
-(instancetype)initWithNSDictionary:(NSDictionary *)dic;
+(instancetype)createCommunityTagsModelWithDic:(NSDictionary *)dic;
@end
