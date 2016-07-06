//
//  RegionModel.m
//  HiChaoDemo01
//
//  Created by Mac on 16/7/4.
//  Copyright © 2016年 surker. All rights reserved.
//

#import "RegionModel.h"

@implementation RegionModel

- (instancetype)initRegionModelWith:(NSDictionary *)dataDic  {
    
    if (self = [super init]) {
       
        NSArray *brandsArr = dataDic[@"region_brands"];
        NSMutableArray *brandsDataArr = [NSMutableArray array];
        for (NSDictionary *dic in brandsArr)
        {
            NSDictionary *componentDic = dic[@"component"];
            NSString *picUr = componentDic[@"picUrl"];
            
            [brandsDataArr addObject:picUr];
        }
        self.region_brands = brandsDataArr;
        
        NSArray *nameArr = dataDic[@"region_name"];
        NSMutableArray *nameDataArr = [NSMutableArray array];
        

        for (NSDictionary *dic in nameArr)
        {
            NSDictionary *componentDic = dic[@"component"];
            NSString *picUr = componentDic[@"picUrl"];
            
            [nameDataArr addObject:picUr];
        }
        self.region_name = nameDataArr;
                 
        NSArray *picturesArr = dataDic[@"region_pictures"];
        NSMutableArray *picturesDataArr = [NSMutableArray array];

        for (NSDictionary *dic in picturesArr)
        {
            NSDictionary *componentDic = dic[@"component"];
            NSString *picUr = componentDic[@"picUrl"];
            
            
            [picturesDataArr addObject:picUr];
        }
        self.region_pictures = picturesDataArr;
        
        
        NSArray *skusArr =dataDic[@"region_skus"];
        NSMutableArray *skusDataArr = [NSMutableArray array];
        
        for (NSDictionary *dic in skusArr) {
            NSDictionary *componentDic = dic[@"component"];
            GoodsMessageModel *model = [GoodsMessageModel createGoodsMessageModelWith:componentDic];
            
            [skusDataArr addObject:model];
         
        }
        self.region_skus = skusDataArr;
        
              
        
    }
    return self;
    
    
}
+ (instancetype)createRegionModelWith:(NSDictionary *)dataDic  {
    
    return [[self alloc]initRegionModelWith:dataDic];
    
    
    
}





@end
