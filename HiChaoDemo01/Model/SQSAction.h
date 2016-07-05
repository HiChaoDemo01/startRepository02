//
//  SQSAction.h
//
//  Created by Mac  on 16/7/5
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SQSAction : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *actionType;
@property (nonatomic, strong) NSString *height;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, strong) NSString *actionIdentifier;
@property (nonatomic, strong) NSString *width;
@property (nonatomic, strong) NSString *sourceId;
@property (nonatomic, strong) NSString *trackValue;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *collectionCount;
@property (nonatomic, assign) double mainImage;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
