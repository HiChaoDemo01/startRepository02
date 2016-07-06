//
//  SQSComponent.h
//
//  Created by Mac  on 16/7/5
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SQSAction;

@interface SQSComponent : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *componentIdentifier;
@property (nonatomic, strong) NSString *trackValue;
@property (nonatomic, strong) NSString *componentDescription;
@property (nonatomic, strong) NSString *nationalFlag;
@property (nonatomic, strong) NSString *publishDate;
@property (nonatomic, strong) NSString *picUrl;
@property (nonatomic, strong) NSString *eventIcon;
@property (nonatomic, strong) NSString *stateMessage;
@property (nonatomic, strong) NSString *componentType;
@property (nonatomic, strong) SQSAction *action;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *collectionCount;
@property (nonatomic, strong) NSString *originPrice;
@property (nonatomic, strong) NSString *sales;
@property (nonatomic, strong) NSString *country;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
