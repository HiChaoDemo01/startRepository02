//
//  GoodsMessageModel.h
//  HiChaoDemo01
//
//  Created by Mac on 16/7/4.
//  Copyright © 2016年 surker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsMessageModel : NSObject

@property (nonatomic,strong)NSString *picUrl;
@property (nonatomic,strong)NSString*origin_price;
@property (nonatomic,strong)NSString *price;
- (instancetype)initGoodsMessageModelWith:(NSDictionary *)dic;
+ (instancetype)createGoodsMessageModelWith:(NSDictionary *)dic;
@end
