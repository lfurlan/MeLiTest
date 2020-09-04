//
//  ArticleDetailViewController.h
//  MeliTest
//
//  Created by Lucas Furlan on 04/09/2020.
//  Copyright © 2020 Lucas Furlan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleDetailViewModel.h"
#import "JGProgressHUD.h"


NS_ASSUME_NONNULL_BEGIN

@interface ArticleDetailViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic , strong) NSString *articleID;


- (IBAction)buttonAction:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *descriptionTypeArticleCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UILabel *installmentsLabel;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UILabel *acceptsMercadopagoLabel;
@property (strong, nonatomic) IBOutlet UITableView *attributesTableView;




@property (nonatomic, strong) ArticleDetailViewModel * viewModel;
@property (nonatomic, strong) ArticleDetailBody *body;
@property (nonatomic, strong) NSMutableArray *arrayImages;
@property (nonatomic, strong) NSMutableArray *arrayAttributes;
@property (nonatomic, strong) JGProgressHUD *HUD;

- (void) getArticleDetail:(NSString *)articleID;

@end

NS_ASSUME_NONNULL_END
