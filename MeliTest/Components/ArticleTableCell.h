//
//  ArticleTableCell.h
//  PruebaML
//
//  Created by Lucas Furlan on 30/08/2020.
//  Copyright © 2020 Lucas Furlan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ArticleTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageArticle;
@property (weak, nonatomic) IBOutlet UILabel *descriptionArticle;
@property (weak, nonatomic) IBOutlet UILabel *priceArticle;

@end

NS_ASSUME_NONNULL_END
