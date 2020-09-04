//
//  MeLiAPI.m
//  MeliTest
//
//  Created by Lucas Furlan on 04/09/2020.
//  Copyright © 2020 Lucas Furlan. All rights reserved.
//

#import "MeLiAPI.h"

@implementation MeLiAPI

NSString *scheme = @"https";
NSString *host = @"api.mercadolibre.com";
NSString *search = @"sites/MLA/search";
NSString *items = @"items";


+ (MeLiAPI *)sharedInstance {
    
    static MeLiAPI *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MeLiAPI alloc] init];
    });
    return sharedInstance;
}

- (void)fetchArticles:(NSString *)title completion:(void(^)(ArticlesListResponse *response))completion failure:(void(^)(NSError* error))failure {
    NSString *urlString =  [NSString stringWithFormat:@"%@://%@/%@?q=%@", scheme, host, search, title];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:urlString];
    
    [[session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        if(error) {
            failure(error);
        } else {
            ArticlesListResponse *response = [ArticlesListResponse fromData: data error: &error];
            completion(response);
        }
        
    }] resume];
}


- (void)fetchArticleDetail:(NSString *)idArticle
completion:(void(^)(ArticleDetailResponse *response))completion failure:(void(^)(NSError* error))failure{
    NSString *urlString =  [NSString stringWithFormat:@"%@://%@/%@?ids=%@", scheme, host, items, idArticle];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:urlString];
    
    [[session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        if(error) {
            failure(error);
        } else {
            ArticleDetailResponse *response = ArticleDetailResponseFromData(data, &error);
            completion(response);
        }
        
    }] resume];
}

@end

