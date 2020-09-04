//
//  ArticleDetailViewModel.m
//  MeliTest
//
//  Created by Lucas Furlan on 04/09/2020.
//  Copyright © 2020 Lucas Furlan. All rights reserved.
//

#import "ArticleDetailViewModel.h"

@implementation ArticleDetailViewModel

    - (void)fetchArticleDetail:(NSString *)idArticle
    completion:(void(^)(ArticleDetailResponse *response))completion failure:(void(^)(NSError* error))failure{
        [[MeLiAPI sharedInstance]
         fetchArticleDetail: idArticle
         completion:^(ArticleDetailResponse *response) {
            completion(response);
        }
         failure:^(NSError *error) {
            failure(error);
        }
        ];
    }
@end
