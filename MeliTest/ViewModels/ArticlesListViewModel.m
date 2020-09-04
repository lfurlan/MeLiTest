//
//  ArticlesListViewModel.m
//  MeliTest
//
//  Created by Lucas Furlan on 04/09/2020.
//  Copyright © 2020 Lucas Furlan. All rights reserved.
//

#import "ArticlesListViewModel.h"
#import "MeLiAPI.h"

@implementation ArticlesListViewModel

- (void)fetchArticles:(NSString *)title completion:(void(^)(ArticlesListResponse *response))completion failure:(void(^)(NSError* error))failure {
    [[MeLiAPI sharedInstance]
     fetchArticles: title
     completion:^(ArticlesListResponse *response) {
        completion(response);
    }
     failure:^(NSError *error) {
        failure(error);
    }
     ];
}
@end
