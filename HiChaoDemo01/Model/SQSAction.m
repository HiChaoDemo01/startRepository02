//
//  SQSAction.m
//
//  Created by Mac  on 16/7/5
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "SQSAction.h"


NSString *const kSQSActionActionType = @"actionType";
NSString *const kSQSActionHeight = @"height";
NSString *const kSQSActionSource = @"source";
NSString *const kSQSActionId = @"id";
NSString *const kSQSActionWidth = @"width";
NSString *const kSQSActionSourceId = @"sourceId";
NSString *const kSQSActionTrackValue = @"trackValue";
NSString *const kSQSActionType = @"type";
NSString *const kSQSActionCollectionCount = @"collectionCount";
NSString *const kSQSActionMainImage = @"main_image";


@interface SQSAction ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SQSAction

@synthesize actionType = _actionType;
@synthesize height = _height;
@synthesize source = _source;
@synthesize actionIdentifier = _actionIdentifier;
@synthesize width = _width;
@synthesize sourceId = _sourceId;
@synthesize trackValue = _trackValue;
@synthesize type = _type;
@synthesize collectionCount = _collectionCount;
@synthesize mainImage = _mainImage;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.actionType = [self objectOrNilForKey:kSQSActionActionType fromDictionary:dict];
            self.height = [self objectOrNilForKey:kSQSActionHeight fromDictionary:dict];
            self.source = [self objectOrNilForKey:kSQSActionSource fromDictionary:dict];
            self.actionIdentifier = [self objectOrNilForKey:kSQSActionId fromDictionary:dict];
            self.width = [self objectOrNilForKey:kSQSActionWidth fromDictionary:dict];
            self.sourceId = [self objectOrNilForKey:kSQSActionSourceId fromDictionary:dict];
            self.trackValue = [self objectOrNilForKey:kSQSActionTrackValue fromDictionary:dict];
            self.type = [self objectOrNilForKey:kSQSActionType fromDictionary:dict];
            self.collectionCount = [self objectOrNilForKey:kSQSActionCollectionCount fromDictionary:dict];
            self.mainImage = [[self objectOrNilForKey:kSQSActionMainImage fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.actionType forKey:kSQSActionActionType];
    [mutableDict setValue:self.height forKey:kSQSActionHeight];
    [mutableDict setValue:self.source forKey:kSQSActionSource];
    [mutableDict setValue:self.actionIdentifier forKey:kSQSActionId];
    [mutableDict setValue:self.width forKey:kSQSActionWidth];
    [mutableDict setValue:self.sourceId forKey:kSQSActionSourceId];
    [mutableDict setValue:self.trackValue forKey:kSQSActionTrackValue];
    [mutableDict setValue:self.type forKey:kSQSActionType];
    [mutableDict setValue:self.collectionCount forKey:kSQSActionCollectionCount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.mainImage] forKey:kSQSActionMainImage];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.actionType = [aDecoder decodeObjectForKey:kSQSActionActionType];
    self.height = [aDecoder decodeObjectForKey:kSQSActionHeight];
    self.source = [aDecoder decodeObjectForKey:kSQSActionSource];
    self.actionIdentifier = [aDecoder decodeObjectForKey:kSQSActionId];
    self.width = [aDecoder decodeObjectForKey:kSQSActionWidth];
    self.sourceId = [aDecoder decodeObjectForKey:kSQSActionSourceId];
    self.trackValue = [aDecoder decodeObjectForKey:kSQSActionTrackValue];
    self.type = [aDecoder decodeObjectForKey:kSQSActionType];
    self.collectionCount = [aDecoder decodeObjectForKey:kSQSActionCollectionCount];
    self.mainImage = [aDecoder decodeDoubleForKey:kSQSActionMainImage];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_actionType forKey:kSQSActionActionType];
    [aCoder encodeObject:_height forKey:kSQSActionHeight];
    [aCoder encodeObject:_source forKey:kSQSActionSource];
    [aCoder encodeObject:_actionIdentifier forKey:kSQSActionId];
    [aCoder encodeObject:_width forKey:kSQSActionWidth];
    [aCoder encodeObject:_sourceId forKey:kSQSActionSourceId];
    [aCoder encodeObject:_trackValue forKey:kSQSActionTrackValue];
    [aCoder encodeObject:_type forKey:kSQSActionType];
    [aCoder encodeObject:_collectionCount forKey:kSQSActionCollectionCount];
    [aCoder encodeDouble:_mainImage forKey:kSQSActionMainImage];
}

- (id)copyWithZone:(NSZone *)zone
{
    SQSAction *copy = [[SQSAction alloc] init];
    
    if (copy) {

        copy.actionType = [self.actionType copyWithZone:zone];
        copy.height = [self.height copyWithZone:zone];
        copy.source = [self.source copyWithZone:zone];
        copy.actionIdentifier = [self.actionIdentifier copyWithZone:zone];
        copy.width = [self.width copyWithZone:zone];
        copy.sourceId = [self.sourceId copyWithZone:zone];
        copy.trackValue = [self.trackValue copyWithZone:zone];
        copy.type = [self.type copyWithZone:zone];
        copy.collectionCount = [self.collectionCount copyWithZone:zone];
        copy.mainImage = self.mainImage;
    }
    
    return copy;
}


@end
