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



@end
