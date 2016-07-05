//
//  SQSComponent.m
//
//  Created by Mac  on 16/7/5
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "SQSComponent.h"
#import "SQSAction.h"


NSString *const kSQSComponentId = @"id";
NSString *const kSQSComponentTrackValue = @"trackValue";
NSString *const kSQSComponentDescription = @"description";
NSString *const kSQSComponentNationalFlag = @"nationalFlag";
NSString *const kSQSComponentPublishDate = @"publish_date";
NSString *const kSQSComponentPicUrl = @"picUrl";
NSString *const kSQSComponentEventIcon = @"eventIcon";
NSString *const kSQSComponentStateMessage = @"stateMessage";
NSString *const kSQSComponentComponentType = @"componentType";
NSString *const kSQSComponentAction = @"action";
NSString *const kSQSComponentPrice = @"price";
NSString *const kSQSComponentCollectionCount = @"collectionCount";
NSString *const kSQSComponentOriginPrice = @"origin_price";
NSString *const kSQSComponentSales = @"sales";
NSString *const kSQSComponentCountry = @"country";


@interface SQSComponent ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SQSComponent

@synthesize componentIdentifier = _componentIdentifier;
@synthesize trackValue = _trackValue;
@synthesize componentDescription = _componentDescription;
@synthesize nationalFlag = _nationalFlag;
@synthesize publishDate = _publishDate;
@synthesize picUrl = _picUrl;
@synthesize eventIcon = _eventIcon;
@synthesize stateMessage = _stateMessage;
@synthesize componentType = _componentType;
@synthesize action = _action;
@synthesize price = _price;
@synthesize collectionCount = _collectionCount;
@synthesize originPrice = _originPrice;
@synthesize sales = _sales;
@synthesize country = _country;


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
            self.componentIdentifier = [self objectOrNilForKey:kSQSComponentId fromDictionary:dict];
            self.trackValue = [self objectOrNilForKey:kSQSComponentTrackValue fromDictionary:dict];
            self.componentDescription = [self objectOrNilForKey:kSQSComponentDescription fromDictionary:dict];
            self.nationalFlag = [self objectOrNilForKey:kSQSComponentNationalFlag fromDictionary:dict];
            self.publishDate = [self objectOrNilForKey:kSQSComponentPublishDate fromDictionary:dict];
            self.picUrl = [self objectOrNilForKey:kSQSComponentPicUrl fromDictionary:dict];
            self.eventIcon = [self objectOrNilForKey:kSQSComponentEventIcon fromDictionary:dict];
            self.stateMessage = [self objectOrNilForKey:kSQSComponentStateMessage fromDictionary:dict];
            self.componentType = [self objectOrNilForKey:kSQSComponentComponentType fromDictionary:dict];
            self.action = [SQSAction modelObjectWithDictionary:[dict objectForKey:kSQSComponentAction]];
            self.price = [self objectOrNilForKey:kSQSComponentPrice fromDictionary:dict];
            self.collectionCount = [self objectOrNilForKey:kSQSComponentCollectionCount fromDictionary:dict];
            self.originPrice = [self objectOrNilForKey:kSQSComponentOriginPrice fromDictionary:dict];
            self.sales = [self objectOrNilForKey:kSQSComponentSales fromDictionary:dict];
            self.country = [self objectOrNilForKey:kSQSComponentCountry fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.componentIdentifier forKey:kSQSComponentId];
    [mutableDict setValue:self.trackValue forKey:kSQSComponentTrackValue];
    [mutableDict setValue:self.componentDescription forKey:kSQSComponentDescription];
    [mutableDict setValue:self.nationalFlag forKey:kSQSComponentNationalFlag];
    [mutableDict setValue:self.publishDate forKey:kSQSComponentPublishDate];
    [mutableDict setValue:self.picUrl forKey:kSQSComponentPicUrl];
    [mutableDict setValue:self.eventIcon forKey:kSQSComponentEventIcon];
    [mutableDict setValue:self.stateMessage forKey:kSQSComponentStateMessage];
    [mutableDict setValue:self.componentType forKey:kSQSComponentComponentType];
    [mutableDict setValue:[self.action dictionaryRepresentation] forKey:kSQSComponentAction];
    [mutableDict setValue:self.price forKey:kSQSComponentPrice];
    [mutableDict setValue:self.collectionCount forKey:kSQSComponentCollectionCount];
    [mutableDict setValue:self.originPrice forKey:kSQSComponentOriginPrice];
    [mutableDict setValue:self.sales forKey:kSQSComponentSales];
    [mutableDict setValue:self.country forKey:kSQSComponentCountry];

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

    self.componentIdentifier = [aDecoder decodeObjectForKey:kSQSComponentId];
    self.trackValue = [aDecoder decodeObjectForKey:kSQSComponentTrackValue];
    self.componentDescription = [aDecoder decodeObjectForKey:kSQSComponentDescription];
    self.nationalFlag = [aDecoder decodeObjectForKey:kSQSComponentNationalFlag];
    self.publishDate = [aDecoder decodeObjectForKey:kSQSComponentPublishDate];
    self.picUrl = [aDecoder decodeObjectForKey:kSQSComponentPicUrl];
    self.eventIcon = [aDecoder decodeObjectForKey:kSQSComponentEventIcon];
    self.stateMessage = [aDecoder decodeObjectForKey:kSQSComponentStateMessage];
    self.componentType = [aDecoder decodeObjectForKey:kSQSComponentComponentType];
    self.action = [aDecoder decodeObjectForKey:kSQSComponentAction];
    self.price = [aDecoder decodeObjectForKey:kSQSComponentPrice];
    self.collectionCount = [aDecoder decodeObjectForKey:kSQSComponentCollectionCount];
    self.originPrice = [aDecoder decodeObjectForKey:kSQSComponentOriginPrice];
    self.sales = [aDecoder decodeObjectForKey:kSQSComponentSales];
    self.country = [aDecoder decodeObjectForKey:kSQSComponentCountry];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_componentIdentifier forKey:kSQSComponentId];
    [aCoder encodeObject:_trackValue forKey:kSQSComponentTrackValue];
    [aCoder encodeObject:_componentDescription forKey:kSQSComponentDescription];
    [aCoder encodeObject:_nationalFlag forKey:kSQSComponentNationalFlag];
    [aCoder encodeObject:_publishDate forKey:kSQSComponentPublishDate];
    [aCoder encodeObject:_picUrl forKey:kSQSComponentPicUrl];
    [aCoder encodeObject:_eventIcon forKey:kSQSComponentEventIcon];
    [aCoder encodeObject:_stateMessage forKey:kSQSComponentStateMessage];
    [aCoder encodeObject:_componentType forKey:kSQSComponentComponentType];
    [aCoder encodeObject:_action forKey:kSQSComponentAction];
    [aCoder encodeObject:_price forKey:kSQSComponentPrice];
    [aCoder encodeObject:_collectionCount forKey:kSQSComponentCollectionCount];
    [aCoder encodeObject:_originPrice forKey:kSQSComponentOriginPrice];
    [aCoder encodeObject:_sales forKey:kSQSComponentSales];
    [aCoder encodeObject:_country forKey:kSQSComponentCountry];
}

- (id)copyWithZone:(NSZone *)zone
{
    SQSComponent *copy = [[SQSComponent alloc] init];
    
    if (copy) {

        copy.componentIdentifier = [self.componentIdentifier copyWithZone:zone];
        copy.trackValue = [self.trackValue copyWithZone:zone];
        copy.componentDescription = [self.componentDescription copyWithZone:zone];
        copy.nationalFlag = [self.nationalFlag copyWithZone:zone];
        copy.publishDate = [self.publishDate copyWithZone:zone];
        copy.picUrl = [self.picUrl copyWithZone:zone];
        copy.eventIcon = [self.eventIcon copyWithZone:zone];
        copy.stateMessage = [self.stateMessage copyWithZone:zone];
        copy.componentType = [self.componentType copyWithZone:zone];
        copy.action = [self.action copyWithZone:zone];
        copy.price = [self.price copyWithZone:zone];
        copy.collectionCount = [self.collectionCount copyWithZone:zone];
        copy.originPrice = [self.originPrice copyWithZone:zone];
        copy.sales = [self.sales copyWithZone:zone];
        copy.country = [self.country copyWithZone:zone];
    }
    
    return copy;
}


@end
