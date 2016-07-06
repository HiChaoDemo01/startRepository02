//
//  SQSItems.m
//
//  Created by Mac  on 16/7/5
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "SQSItems.h"


NSString *const kSQSItemsCateNames = @"cate_names";
NSString *const kSQSItemsNavName = @"nav_name";
NSString *const kSQSItemsNavCatIds = @"nav_cat_ids";


@interface SQSItems ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SQSItems

@synthesize cateNames = _cateNames;
@synthesize navName = _navName;
@synthesize navCatIds = _navCatIds;


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
            self.cateNames = [self objectOrNilForKey:kSQSItemsCateNames fromDictionary:dict];
            self.navName = [self objectOrNilForKey:kSQSItemsNavName fromDictionary:dict];
            self.navCatIds = [self objectOrNilForKey:kSQSItemsNavCatIds fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.cateNames forKey:kSQSItemsCateNames];
    [mutableDict setValue:self.navName forKey:kSQSItemsNavName];
    [mutableDict setValue:self.navCatIds forKey:kSQSItemsNavCatIds];

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

    self.cateNames = [aDecoder decodeObjectForKey:kSQSItemsCateNames];
    self.navName = [aDecoder decodeObjectForKey:kSQSItemsNavName];
    self.navCatIds = [aDecoder decodeObjectForKey:kSQSItemsNavCatIds];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_cateNames forKey:kSQSItemsCateNames];
    [aCoder encodeObject:_navName forKey:kSQSItemsNavName];
    [aCoder encodeObject:_navCatIds forKey:kSQSItemsNavCatIds];
}

- (id)copyWithZone:(NSZone *)zone
{
    SQSItems *copy = [[SQSItems alloc] init];
    
    if (copy) {

        copy.cateNames = [self.cateNames copyWithZone:zone];
        copy.navName = [self.navName copyWithZone:zone];
        copy.navCatIds = [self.navCatIds copyWithZone:zone];
    }
    
    return copy;
}


@end
