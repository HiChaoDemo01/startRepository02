//
//  SQSRequest.h
//  HiChaoDemo01
//
//  Created by Mac on 16/7/4.
//  Copyright © 2016年 surker. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SQSRequest : NSObject

//发送引导页请求图片
+ (void)sendRequestFroIntroduceImage:(void(^)(NSString *imageUrl))complete;
//发送首页的topscrollView请求图片
+ (void)sendRequestForMianVcTopScrollViewImage:(void(^)(NSArray *imageArray))complete;

+ (void)sendRequestForTimelimitInfo:(void(^)(NSArray *infoArr))complete;
//发送请求各国商品数据
+ (void)sendRequestFroGoodsMessage:(void(^)(NSArray *messageArr))complete;

//发送请求，获得首页的collectionView数据
+ (void)sendRequestFroCollectionViewData:(void(^)(NSArray *dataArr))complete;
//发送请求，获得collectionView的头标题
+ (void)sendRequestFrocollectionViewHeaderTitile:(void(^)(NSArray *titleArr))complete;

@end
