//
//  CommunitySupportUsersModel.h
//  HiChaoDemo01
//
//  Created by Mac on 16/7/5.
//  Copyright © 2016年 surker. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  点赞用的属性-头像、名字、id
 */
@interface CommunitySupportUsersModel : NSObject
@property(copy,nonatomic)NSString *userAvatar,*userId,*username;
-(instancetype)initWithNSDictionary:(NSDictionary *)dic;
+(instancetype)createCommunitySupportUsersModel:(NSDictionary *)dic;
@end
