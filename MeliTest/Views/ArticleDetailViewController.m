//
//  ArticleDetailViewController.m
//  MeliTest
//
//  Created by Lucas Furlan on 04/09/2020.
//  Copyright © 2020 Lucas Furlan. All rights reserved.
//

#import "ArticleDetailViewController.h"
#import "JGProgressHUD.h"


@interface ArticleDetailViewController ()

@end

@implementation ArticleDetailViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.viewModel = [[ArticleDetailViewModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _arrayImages = [[NSMutableArray alloc] init];
    _arrayAttributes  = [[NSMutableArray alloc] init];
    _HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
}

-(void)getArticleDetail:(NSString *)articleID
{
    _HUD.textLabel.text = @"Loading";
    [_HUD showInView:self.view];
    if (articleID != nil) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            [_viewModel
             fetchArticleDetail:articleID
             completion:^(ArticleDetailResponse *response) {
                [_HUD dismiss];
                if (response.firstObject.body != nil){
                    self->_body = response.firstObject.body;
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSString *condition = @"";
                        if (self->_body.condition != nil){
                            if ([self->_body.condition  isEqual: @"new"]) {
                                condition = @"Nuevo";
                            } if ([self->_body.condition  isEqual: @"used"]) {
                                condition = @"Usado";
                            }
                        }
                        NSString *soldQuantity = @"";
                        if (self->_body.soldQuantity != nil){
                            soldQuantity = [@(self->_body.soldQuantity) stringValue];
                        }
                        
                        self->_descriptionTypeArticleCountLabel.text = [NSString stringWithFormat:@"%@ | %@ vendidos", condition, soldQuantity];
                        self->_descriptionLabel.text = self->_body.title;
                        self->_priceLabel.text = [NSString stringWithFormat:@"$ %@", [@(self->_body.price) stringValue]];
                        
                        for (id element in self->_body.pictures){
                            ArticleDetailPicture *picture = element;
                            if (picture.url != nil){
                                [self->_arrayImages addObject:picture.url];
                            }
                        }
                        if (self->_arrayImages.count > 0){
                            [self.collectionView reloadData];
                        }
                        
                        for (id element in self->_body.attributes){
                            ArticleDetailAttribute *atribute = element;
                            if (atribute.name != nil, atribute.valueName != nil){
                                [self->_arrayAttributes addObject:@[atribute.name, atribute.valueName]];
                            }
                        }
                        if (self->_arrayAttributes.count > 0){
                            [self.attributesTableView reloadData];
                        }
                        
                        NSString *isAcceptsMercadopago = @"";
                        if (self->_body.isAcceptsMercadopago != nil){
                            if (self->_body.isAcceptsMercadopago) {
                                isAcceptsMercadopago = @"Acepta Mercado Pago";
                            } else {
                                isAcceptsMercadopago = @"No acepta Mercado Pago";
                            }
                        }
                        self->_acceptsMercadopagoLabel.text = isAcceptsMercadopago;
                        
                    });
                }
            }
             failure:^(NSError *error) {
                [_HUD dismiss];
                NSLog(@"Failed: %@",error);
            }
             ];
        });
    }
}



- (IBAction)buttonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



// MARK: - Collection Functions Images
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _arrayImages.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(CGRectGetWidth(collectionView.frame), (CGRectGetHeight(collectionView.frame)));
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UIImageView *image1=(UIImageView *)[cell viewWithTag:1];
    
    NSString* webStringURL = [[_arrayImages objectAtIndex:indexPath.row] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    
    NSURL *url = [NSURL URLWithString:(webStringURL)];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:url];
        dispatch_async(dispatch_get_main_queue(), ^{
            image1.image = [UIImage imageWithData: data];;
        });
    });
    return cell;
}




// MARK: - TableView Functions attributes
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
(NSInteger)section{
    return self->_arrayAttributes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:
(NSIndexPath *)indexPath{
    static NSString *MyIdentifier = @"ArticleTableCell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier: @"attributesCell" forIndexPath:indexPath];
    UILabel *labelAttribute=(UILabel *)[cell viewWithTag:1];
    
    ;
    labelAttribute.text = [NSString stringWithFormat:@"%@:  %@", _arrayAttributes[indexPath.row][0], _arrayAttributes[indexPath.row][1]];
    return cell;
}
@end



