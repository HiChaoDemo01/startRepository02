//
//  QHJRequestDataTools.h
//  HiChaoDemo01
//
//  Created by Mac on 16/7/3.
//  Copyright © 2016年 surker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QHJRequestDataTools : NSObject
+(void)requestDataWithUrl:(NSString *)urlStr andWith:(ReturnValueBlock)block;
+(void)requestTableViewDataWithUrl:(NSString *)urlStr andWith:(ReturnValueBlock)block;
@end
