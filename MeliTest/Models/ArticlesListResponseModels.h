//
//  ArticlesListResponseModels.h
//  MeliTest
//
//  Created by Lucas Furlan on 04/09/2020.
//  Copyright © 2020 Lucas Furlan. All rights reserved.
//

#import <Foundation/Foundation.h>


@class ArticlesListResponse;
@class ArticlesListResult;
@class ArticlesListShipping;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Object interfaces

@interface ArticlesListResponse : NSObject
@property (nonatomic, copy) NSArray<ArticlesListResult *> *results;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface ArticlesListResult : NSObject
@property (nonatomic, copy)           NSString *identifier;
@property (nonatomic, copy)           NSString *title;
@property (nonatomic, assign)         NSInteger price;
@property (nonatomic, copy)           NSString *thumbnail;
@property (nonatomic, strong)         ArticlesListShipping *shipping;
@property (nonatomic, nullable, copy) id originalPrice;
@end

@interface ArticlesListShipping : NSObject
@property (nonatomic, assign) BOOL isFreeShipping;
@property (nonatomic, copy)   NSString *mode;
@property (nonatomic, copy)   NSArray<NSString *> *tags;
@property (nonatomic, copy)   NSString *logisticType;
@property (nonatomic, assign) BOOL isStorePickUp;
@end

NS_ASSUME_NONNULL_END
