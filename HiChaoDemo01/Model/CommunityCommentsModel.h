//
//  CommunityCommentsModel.h
//  HiChaoDemo01
//
//  Created by Mac on 16/7/5.
//  Copyright © 2016年 surker. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  评论者信息--评论者名字，评论内容，评论标题
 */
@interface CommunityCommentsModel : NSObject
@property(copy,nonatomic)NSString *username,*content,*title;
-(instancetype)initWithNSDictionary:(NSDictionary *)dic;
+(instancetype)createCommunityCommentsModelWith:(NSDictionary *)dic;
@end
