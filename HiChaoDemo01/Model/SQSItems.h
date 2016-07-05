//
//  SQSItems.h
//
//  Created by Mac  on 16/7/5
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SQSItems : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *cateNames;
@property (nonatomic, strong) NSString *navName;
@property (nonatomic, strong) NSString *navCatIds;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
