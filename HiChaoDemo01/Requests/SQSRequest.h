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



@end
