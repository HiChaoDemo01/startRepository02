//
//  SQSRequest.m
//  HiChaoDemo01
//
//  Created by Mac on 16/7/4.
//  Copyright © 2016年 surker. All rights reserved.
//

#import "SQSRequest.h"

@implementation SQSRequest
#pragma mark----请求引导页的图片
+ (void)sendRequestFroIntroduceImage:(void(^)(NSString *imageUrl))complete {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    
    [manager GET:@"http://api-v2.mall.hichao.com/app/splash" parameters:@{@"gc":@"appstore",@"gf":@"iphone",@"gn":@"mxyc_ip",@"gv":@"6.6.3",@"gi":@"27C3F6CE-7F12-493C-813C-DD71A58525A7",@"gs":@"640x1136",@"gos":@"9.2.1",@"access_token":@""} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *imageDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (imageDic) {
            
            NSString *imageUrl = imageDic[@"message"];
            if (imageUrl) {
                
                if (complete) {
                    
                    complete(imageUrl);
                    
                }
                
            }
            
        }
              
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error.localizedDescription);
        
    }];
    
    
}
#pragma mark-----请求首页的上面scrollView的图片
+ (void)sendRequestForMianVcTopScrollViewImage:(void(^)(NSArray *imageArray))complete {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    
    [manager GET:@"http://api-v2.mall.hichao.com/mall/banner?gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=282DC040-8A37-4D6D-92A1-55AC237988B1&gs=640x1136&gos=8.4&access_token=" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dataDic = dic[@"data"];
        NSArray *itemsArr = dataDic[@"items"];
        NSMutableArray *imageDataArr = [NSMutableArray array];
        
        for (NSDictionary *dic in itemsArr) {
            
            NSDictionary *imageDic = dic[@"component"];
            NSString *imageUrl = imageDic[@"picUrl"];
            [imageDataArr addObject:imageUrl];
           
        }
        
        if (complete) {
            
            complete(imageDataArr);
        }
       
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        NSLog(@"%@",error.localizedDescription);
    }];
    
    
}

#pragma mark----请求中间的限时抢购信息

+ (void)sendRequestForTimelimitInfo:(void(^)(NSArray *infoArr))complete {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    [manager POST:@"http://api-v2.mall.hichao.com/active/flash/list?gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=282DC040-8A37-4D6D-92A1-55AC237988B1&gs=640x1136&gos=8.4&access_token=" parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary *responseDic = dic[@"response"];
        NSDictionary *dataDic = responseDic[@"data"];
        NSArray *itemsArr = dataDic[@"items"];
        
        NSMutableArray *dataArr = [NSMutableArray array];
            if (itemsArr) {
                for (NSDictionary *dic in itemsArr) {
            
            NSDictionary *componentDic = dic[@"component"];
            
            SQSTimelimitModel *modle  = [SQSTimelimitModel createTimelimitModelWith:componentDic];
            
            [dataArr addObject:modle];
           }
                
                if (complete) {
                    
                    complete(dataArr);
                }
            
        }
    }
      
            
            
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error.localizedDescription);
        
    }];
    
      
    
}

#pragma mark-----请求各国商品信息
+ (void)sendRequestFroGoodsMessage:(void(^)(NSArray *messageArr))complete {
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    
    NSMutableArray *goodsDataArr = [NSMutableArray array];
    
    for (NSInteger i = 1; i < 7; i++) {
        [manager GET:[NSString stringWithFormat:@"http://api-v2.mall.hichao.com/mall/region/new?region_id=%ld&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=282DC040-8A37-4D6D-92A1-55AC237988B1&gs=640x1136&gos=8.4&access_token=",(long)i] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSDictionary *dataDic = dic[@"data"];
            RegionModel *model = [RegionModel createRegionModelWith:dataDic];
            

            [goodsDataArr addObject:model];
            
            if (i==6 && complete) {
                
                complete(goodsDataArr);
            }
            
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSLog(@"%@",error.localizedDescription);
            
        }];
        
    }
    
}
#pragma mark----请求collectionView的数据
+ (void)sendRequestFroCollectionViewData:(void(^)(NSArray *dataArr))complete {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    manager.requestSerializer.timeoutInterval = 10.f;
    [manager GET:@"http://api-v2.mall.hichao.com/sku/list?more_items=1&type=selection&flag=90246&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=282DC040-8A37-4D6D-92A1-55AC237988B1&gs=640x1136&gos=8.4&access_token" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        if (responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary *dataDic =dic[@"data"];
        NSArray *itemsArr = dataDic[@"items"];
        
        NSMutableArray *dataArray = [NSMutableArray array];
        for (NSDictionary *dic in itemsArr) {
            NSDictionary *componentDic = dic[@"component"];
            SQSComponent *model =[SQSComponent modelObjectWithDictionary:componentDic];
            [dataArray addObject:model];
            
            
        }
            if (complete) {
                
                complete(dataArray);
            }
        
    }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error.localizedDescription);
        
    }];
  }

#pragma mark------请求collectionView的头的标题
+ (void)sendRequestFrocollectionViewHeaderTitile:(void(^)(NSArray *titleArr))complete {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    [manager GET:@"http://api-v2.mall.hichao.com/region/detail/goods-nav?region=0&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=282DC040-8A37-4D6D-92A1-55AC237988B1&gs=640x1136&gos=8.4&access_token=" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
          
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary *dataDic = dic[@"data"];
        NSArray *itemsArr = dataDic[@"items"];
        NSMutableArray *titleArr = [NSMutableArray array];
        for (NSDictionary *dic in itemsArr) {
            SQSItems *titlemodel = [SQSItems modelObjectWithDictionary:dic];
            
            NSLog(@"%@",titlemodel.navName);
            [titleArr addObject:titlemodel];
            
        }
        
            if (complete) {
                
                complete(titleArr);
            }
        
        
     }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error.localizedDescription);
        
    }];
    
    
    
    
    
}


@end
