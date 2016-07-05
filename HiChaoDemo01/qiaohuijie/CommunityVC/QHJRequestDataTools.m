//
//  QHJRequestDataTools.m
//  HiChaoDemo01
//
//  Created by Mac on 16/7/3.
//  Copyright © 2016年 surker. All rights reserved.
//

#import "QHJRequestDataTools.h"

@implementation QHJRequestDataTools
+(void)requestDataWithUrl:(NSString *)urlStr andWith:(ReturnValueBlock)block
{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", nil];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (responseObject) {
               // NSLog(@"%@",[[NSString alloc]initWithData:responseObject encoding:4]);
                NSDictionary *dataDic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                NSArray *itemsArr=dataDic[@"data"][@"items"];
                NSMutableArray *dataArr=[NSMutableArray new];
                for (NSDictionary *tempDic in itemsArr) {
                    [dataArr addObject:[CommunityScrollDataModel createCommunityScrollDataModelWith:tempDic[@"component"]]];
                }
                if (block) {
                    block(dataArr);
                }
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error.localizedDescription);
        }];
    });
}
@end
