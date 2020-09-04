//
//  ArticleDetailResponseModels.h
//  MeliTest
//
//  Created by Lucas Furlan on 04/09/2020.
//  Copyright © 2020 Lucas Furlan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ArticleDetailResponseElement;
@class ArticleDetailBody;
@class ArticleDetailAttribute;
@class ArticleDetailValue;
@class ArticleDetailNonMercadoPagoPaymentMethod;
@class ArticleDetailPicture;
@class ArticleDetailSellerAddress;
@class ArticleDetailCity;
@class ArticleDetailSearchLocation;
@class ArticleDetailShipping;

NS_ASSUME_NONNULL_BEGIN

typedef NSArray<ArticleDetailResponseElement *> ArticleDetailResponse;

#pragma mark - Top-level marshaling functions

ArticleDetailResponse *_Nullable ArticleDetailResponseFromData(NSData *data, NSError **error);
ArticleDetailResponse *_Nullable ArticleDetailResponseFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData                *_Nullable ArticleDetailResponseToData(ArticleDetailResponse *response, NSError **error);
NSString              *_Nullable ArticleDetailResponseToJSON(ArticleDetailResponse *response, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface ArticleDetailResponseElement : NSObject
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) ArticleDetailBody *body;
@end

@interface ArticleDetailBody : NSObject
@property (nonatomic, copy)           NSString *title;
@property (nonatomic, nullable, copy) id subtitle;
@property (nonatomic, assign)         NSInteger price;
@property (nonatomic, assign)         NSInteger basePrice;
@property (nonatomic, nullable, copy) id originalPrice;
@property (nonatomic, assign)         NSInteger initialQuantity;
@property (nonatomic, assign)         NSInteger availableQuantity;
@property (nonatomic, assign)         NSInteger soldQuantity;
@property (nonatomic, copy)           NSString *condition;
@property (nonatomic, copy)           NSArray<ArticleDetailPicture *> *pictures;
@property (nonatomic, assign)         BOOL isAcceptsMercadopago;
@property (nonatomic, copy)           NSArray<ArticleDetailNonMercadoPagoPaymentMethod *> *nonMercadoPagoPaymentMethods;
@property (nonatomic, strong)         ArticleDetailShipping *shipping;
@property (nonatomic, copy)           NSString *internationalDeliveryMode;
@property (nonatomic, strong)         ArticleDetailSellerAddress *sellerAddress;
@property (nonatomic, copy)           NSArray<ArticleDetailAttribute *> *attributes;
@end

@interface ArticleDetailAttribute : NSObject
@property (nonatomic, copy)           NSString *identifier;
@property (nonatomic, copy)           NSString *name;
@property (nonatomic, copy)           NSString *valueID;
@property (nonatomic, copy)           NSString *valueName;
@property (nonatomic, nullable, copy) id valueStruct;
@property (nonatomic, copy)           NSArray<ArticleDetailValue *> *values;
@property (nonatomic, copy)           NSString *attributeGroupID;
@property (nonatomic, copy)           NSString *attributeGroupName;
@end

@interface ArticleDetailValue : NSObject
@property (nonatomic, copy)           NSString *identifier;
@property (nonatomic, copy)           NSString *name;
@property (nonatomic, nullable, copy) id valueStruct;
@end

@interface ArticleDetailNonMercadoPagoPaymentMethod : NSObject
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *theDescription;
@property (nonatomic, copy) NSString *type;
@end

@interface ArticleDetailPicture : NSObject
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *secureURL;
@property (nonatomic, copy) NSString *size;
@property (nonatomic, copy) NSString *maxSize;
@property (nonatomic, copy) NSString *quality;
@end

@interface ArticleDetailSellerAddress : NSObject
@property (nonatomic, strong) ArticleDetailCity *city;
@property (nonatomic, strong) ArticleDetailCity *state;
@property (nonatomic, strong) ArticleDetailCity *country;
@property (nonatomic, strong) ArticleDetailSearchLocation *searchLocation;
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;
@property (nonatomic, assign) NSInteger identifier;
@end

@interface ArticleDetailCity : NSObject
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *name;
@end

@interface ArticleDetailSearchLocation : NSObject
@property (nonatomic, strong) ArticleDetailCity *city;
@property (nonatomic, strong) ArticleDetailCity *state;
@end

@interface ArticleDetailShipping : NSObject
@property (nonatomic, copy)           NSString *mode;
@property (nonatomic, nullable, copy) id dimensions;
@property (nonatomic, assign)         BOOL isLocalPickUp;
@property (nonatomic, assign)         BOOL isFreeShipping;
@property (nonatomic, copy)           NSString *logisticType;
@property (nonatomic, assign)         BOOL isStorePickUp;
@end

NS_ASSUME_NONNULL_END

