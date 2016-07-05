//
//  CommunityShareModel.h
//  HiChaoDemo01
//
//  Created by Mac on 16/7/5.
//  Copyright © 2016年 surker. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  分享信息--标题、描述、图片url、详情url
 */
@interface CommunityShareModel : NSObject
@property(copy,nonatomic)NSString *title,*descrip,*picUrl,*detailUrl;
-(instancetype)initWithNSDictionary:(NSDictionary *)dic;
+(instancetype)createCommunityShareModelWith:(NSDictionary *)dic;
@end
