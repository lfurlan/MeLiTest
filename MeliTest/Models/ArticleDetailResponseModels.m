//
//  ArticleDetailResponseModels.m
//  MeliTest
//
//  Created by Lucas Furlan on 04/09/2020.
//  Copyright © 2020 Lucas Furlan. All rights reserved.
//

#import "ArticleDetailResponseModels.h"


#define λ(decl, expr) (^(decl) { return (expr); })

static id NSNullify(id _Nullable x) {
    return (x == nil || x == NSNull.null) ? NSNull.null : x;
}

NS_ASSUME_NONNULL_BEGIN

@interface ArticleDetailResponseElement (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface ArticleDetailBody (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface ArticleDetailAttribute (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface ArticleDetailValue (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface ArticleDetailNonMercadoPagoPaymentMethod (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface ArticleDetailPicture (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface ArticleDetailSellerAddress (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface ArticleDetailCity (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface ArticleDetailSearchLocation (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface ArticleDetailShipping (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

static id map(id collection, id (^f)(id value)) {
    id result = nil;
    if ([collection isKindOfClass:NSArray.class]) {
        result = [NSMutableArray arrayWithCapacity:[collection count]];
        for (id x in collection) [result addObject:f(x)];
    } else if ([collection isKindOfClass:NSDictionary.class]) {
        result = [NSMutableDictionary dictionaryWithCapacity:[collection count]];
        for (id key in collection) [result setObject:f([collection objectForKey:key]) forKey:key];
    }
    return result;
}

#pragma mark - JSON serialization

ArticleDetailResponse *_Nullable ArticleDetailResponseFromData(NSData *data, NSError **error)
{
    @try {
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:error];
        return *error ? nil : map(json, λ(id x, [ArticleDetailResponseElement fromJSONDictionary:x]));
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

ArticleDetailResponse *_Nullable ArticleDetailResponseFromJSON(NSString *json, NSStringEncoding encoding, NSError **error)
{
    return ArticleDetailResponseFromData([json dataUsingEncoding:encoding], error);
}

NSData *_Nullable ArticleDetailResponseToData(ArticleDetailResponse *response, NSError **error)
{
    @try {
        id json = map(response, λ(id x, [x JSONDictionary]));
        NSData *data = [NSJSONSerialization dataWithJSONObject:json options:kNilOptions error:error];
        return *error ? nil : data;
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

NSString *_Nullable ArticleDetailResponseToJSON(ArticleDetailResponse *response, NSStringEncoding encoding, NSError **error)
{
    NSData *data = ArticleDetailResponseToData(response, error);
    return data ? [[NSString alloc] initWithData:data encoding:encoding] : nil;
}

@implementation ArticleDetailResponseElement
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"code": @"code",
        @"body": @"body",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[ArticleDetailResponseElement alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _body = [ArticleDetailBody fromJSONDictionary:(id)_body];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = ArticleDetailResponseElement.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = ArticleDetailResponseElement.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:ArticleDetailResponseElement.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"body": [_body JSONDictionary],
    }];

    return dict;
}
@end

@implementation ArticleDetailBody
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"title": @"title",
        @"subtitle": @"subtitle",
        @"price": @"price",
        @"base_price": @"basePrice",
        @"original_price": @"originalPrice",
        @"initial_quantity": @"initialQuantity",
        @"available_quantity": @"availableQuantity",
        @"sold_quantity": @"soldQuantity",
        @"condition": @"condition",
        @"pictures": @"pictures",
        @"accepts_mercadopago": @"isAcceptsMercadopago",
        @"non_mercado_pago_payment_methods": @"nonMercadoPagoPaymentMethods",
        @"shipping": @"shipping",
        @"international_delivery_mode": @"internationalDeliveryMode",
        @"seller_address": @"sellerAddress",
        @"attributes": @"attributes",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[ArticleDetailBody alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _pictures = map(_pictures, λ(id x, [ArticleDetailPicture fromJSONDictionary:x]));
        _nonMercadoPagoPaymentMethods = map(_nonMercadoPagoPaymentMethods, λ(id x, [ArticleDetailNonMercadoPagoPaymentMethod fromJSONDictionary:x]));
        _shipping = [ArticleDetailShipping fromJSONDictionary:(id)_shipping];
        _sellerAddress = [ArticleDetailSellerAddress fromJSONDictionary:(id)_sellerAddress];
        _attributes = map(_attributes, λ(id x, [ArticleDetailAttribute fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = ArticleDetailBody.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = ArticleDetailBody.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:ArticleDetailBody.properties.allValues] mutableCopy];

    for (id jsonName in ArticleDetailBody.properties) {
        id propertyName = ArticleDetailBody.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"pictures": map(_pictures, λ(id x, [x JSONDictionary])),
        @"accepts_mercadopago": _isAcceptsMercadopago ? @YES : @NO,
        @"non_mercado_pago_payment_methods": map(_nonMercadoPagoPaymentMethods, λ(id x, [x JSONDictionary])),
        @"shipping": [_shipping JSONDictionary],
        @"seller_address": [_sellerAddress JSONDictionary],
        @"attributes": map(_attributes, λ(id x, [x JSONDictionary])),
    }];

    return dict;
}
@end

@implementation ArticleDetailAttribute
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"id": @"identifier",
        @"name": @"name",
        @"value_id": @"valueID",
        @"value_name": @"valueName",
        @"value_struct": @"valueStruct",
        @"values": @"values",
        @"attribute_group_id": @"attributeGroupID",
        @"attribute_group_name": @"attributeGroupName",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[ArticleDetailAttribute alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _values = map(_values, λ(id x, [ArticleDetailValue fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = ArticleDetailAttribute.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = ArticleDetailAttribute.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:ArticleDetailAttribute.properties.allValues] mutableCopy];

    for (id jsonName in ArticleDetailAttribute.properties) {
        id propertyName = ArticleDetailAttribute.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"values": map(_values, λ(id x, [x JSONDictionary])),
    }];

    return dict;
}
@end

@implementation ArticleDetailValue
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"id": @"identifier",
        @"name": @"name",
        @"struct": @"valueStruct",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[ArticleDetailValue alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = ArticleDetailValue.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = ArticleDetailValue.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:ArticleDetailValue.properties.allValues] mutableCopy];

    for (id jsonName in ArticleDetailValue.properties) {
        id propertyName = ArticleDetailValue.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation ArticleDetailNonMercadoPagoPaymentMethod
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"id": @"identifier",
        @"description": @"theDescription",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[ArticleDetailNonMercadoPagoPaymentMethod alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = ArticleDetailNonMercadoPagoPaymentMethod.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = ArticleDetailNonMercadoPagoPaymentMethod.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:ArticleDetailNonMercadoPagoPaymentMethod.properties.allValues] mutableCopy];

    for (id jsonName in ArticleDetailNonMercadoPagoPaymentMethod.properties) {
        id propertyName = ArticleDetailNonMercadoPagoPaymentMethod.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation ArticleDetailPicture
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"id": @"identifier",
        @"url": @"url",
        @"secure_url": @"secureURL",
        @"size": @"size",
        @"max_size": @"maxSize",
        @"quality": @"quality",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[ArticleDetailPicture alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = ArticleDetailPicture.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = ArticleDetailPicture.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:ArticleDetailPicture.properties.allValues] mutableCopy];

    for (id jsonName in ArticleDetailPicture.properties) {
        id propertyName = ArticleDetailPicture.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation ArticleDetailSellerAddress
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"city": @"city",
        @"state": @"state",
        @"country": @"country",
        @"search_location": @"searchLocation",
        @"latitude": @"latitude",
        @"longitude": @"longitude",
        @"id": @"identifier",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[ArticleDetailSellerAddress alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _city = [ArticleDetailCity fromJSONDictionary:(id)_city];
        _state = [ArticleDetailCity fromJSONDictionary:(id)_state];
        _country = [ArticleDetailCity fromJSONDictionary:(id)_country];
        _searchLocation = [ArticleDetailSearchLocation fromJSONDictionary:(id)_searchLocation];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = ArticleDetailSellerAddress.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = ArticleDetailSellerAddress.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:ArticleDetailSellerAddress.properties.allValues] mutableCopy];

    for (id jsonName in ArticleDetailSellerAddress.properties) {
        id propertyName = ArticleDetailSellerAddress.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"city": [_city JSONDictionary],
        @"state": [_state JSONDictionary],
        @"country": [_country JSONDictionary],
        @"search_location": [_searchLocation JSONDictionary],
    }];

    return dict;
}
@end

@implementation ArticleDetailCity
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"id": @"identifier",
        @"name": @"name",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[ArticleDetailCity alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = ArticleDetailCity.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = ArticleDetailCity.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:ArticleDetailCity.properties.allValues] mutableCopy];

    for (id jsonName in ArticleDetailCity.properties) {
        id propertyName = ArticleDetailCity.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation ArticleDetailSearchLocation
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"city": @"city",
        @"state": @"state",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[ArticleDetailSearchLocation alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _city = [ArticleDetailCity fromJSONDictionary:(id)_city];
        _state = [ArticleDetailCity fromJSONDictionary:(id)_state];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = ArticleDetailSearchLocation.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = ArticleDetailSearchLocation.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:ArticleDetailSearchLocation.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"city": [_city JSONDictionary],
        @"state": [_state JSONDictionary],
    }];

    return dict;
}
@end

@implementation ArticleDetailShipping
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"mode": @"mode",
        @"dimensions": @"dimensions",
        @"local_pick_up": @"isLocalPickUp",
        @"free_shipping": @"isFreeShipping",
        @"logistic_type": @"logisticType",
        @"store_pick_up": @"isStorePickUp",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[ArticleDetailShipping alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = ArticleDetailShipping.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = ArticleDetailShipping.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:ArticleDetailShipping.properties.allValues] mutableCopy];

    for (id jsonName in ArticleDetailShipping.properties) {
        id propertyName = ArticleDetailShipping.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"local_pick_up": _isLocalPickUp ? @YES : @NO,
        @"free_shipping": _isFreeShipping ? @YES : @NO,
        @"store_pick_up": _isStorePickUp ? @YES : @NO,
    }];

    return dict;
}
@end

NS_ASSUME_NONNULL_END

