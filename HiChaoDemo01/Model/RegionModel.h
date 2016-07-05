//
//  RegionModel.h
//  HiChaoDemo01
//
//  Created by Mac on 16/7/4.
//  Copyright © 2016年 surker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegionModel : NSObject
@property (nonatomic,strong)NSArray *region_brands;
@property (nonatomic,strong)NSArray *region_name;
@property (nonatomic,strong)NSArray *region_pictures;
@property (nonatomic,strong)NSArray *region_skus;

- (instancetype)initRegionModelWith:(NSDictionary *)dataDic ;
+ (instancetype)createRegionModelWith:(NSDictionary *)dataDic ;


@end
