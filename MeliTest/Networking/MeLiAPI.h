//
//  MeLiAPI.h
//  MeliTest
//
//  Created by Lucas Furlan on 04/09/2020.
//  Copyright © 2020 Lucas Furlan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArticlesListResponseModels.h"
#import "ArticleDetailResponseModels.h"

NS_ASSUME_NONNULL_BEGIN

@interface MeLiAPI : NSObject

+ (MeLiAPI *)sharedInstance;

- (void)fetchArticles:(NSString *)title
                      completion:(void(^)(ArticlesListResponse *response))completion failure:(void(^)(NSError* error))failure;

- (void)fetchArticleDetail:(NSString *)idArticle
completion:(void(^)(ArticleDetailResponse *response))completion failure:(void(^)(NSError* error))failure;

@end

NS_ASSUME_NONNULL_END
