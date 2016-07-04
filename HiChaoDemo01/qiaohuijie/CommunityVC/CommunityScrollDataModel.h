//
//  CommunityScrollDataModel.h
//  HiChaoDemo01
//
//  Created by Mac on 16/7/4.
//  Copyright © 2016年 surker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommunityScrollDataModel : NSObject
@property(copy,nonatomic)NSString *picUrl;
-(instancetype)initWithNSDictionary:(NSDictionary *)dic;
+(instancetype)createCommunityScrollDataModelWith:(NSDictionary *)dic;
@end
