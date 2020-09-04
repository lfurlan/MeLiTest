//
//  ArticlesListViewController.m
//  MeliTest
//
//  Created by Lucas Furlan on 04/09/2020.
//  Copyright © 2020 Lucas Furlan. All rights reserved.
//

#import "ArticlesListViewController.h"
#import "MeLiAPI.h"
#import "ArticleTableCell.h"



@interface ArticlesListViewController ()

@end

@implementation ArticlesListViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.viewModel = [[ArticlesListViewModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.searchTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    arrayArticles = [[NSMutableArray alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"ArticleTableCell" bundle:nil] forCellReuseIdentifier:@"ArticleTableCell"];
    _HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
}


-(void)textFieldDidChange:(UITextField *)textField
{
    searchTextString=textField.text;
    if(searchTextString.length == 0){
        _deleteButton.hidden = YES;
        //self.placeHolderView.hidden = NO;
    } else {
        _deleteButton.hidden = NO;
        //self.placeHolderView.hidden = YES;
    }
}


- (IBAction)fetchAction:(id)sender {
    if(searchTextString.length>0)
    {
        _HUD.textLabel.text = @"Loading";
        [_HUD showInView:self.view];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            [self.viewModel
             fetchArticles: searchTextString
             completion:^(ArticlesListResponse *response) {
                //[SVProgressHUD dismiss];
                [_HUD dismiss];
                NSLog(@"Response: %@",response);
                if (response.results != nil){
                    arrayArticles = [response.results mutableCopy];//[[response.results subarrayWithRange:NSMakeRange(0, [response.results count])] mutableCopy];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tableView reloadData];
                    });
                }
            }
             failure:^(NSError *error) {
                NSLog(@"Failed: %@",error);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [arrayArticles removeAllObjects];
                    [self.tableView reloadData];
                    _deleteButton.hidden = YES;
                    _placeHolderView.hidden = NO;
                });
            }
             ];
        });
    }
}


- (IBAction)deleteAction:(id)sender {
    [arrayArticles removeAllObjects];
    [self.tableView reloadData];
    _deleteButton.hidden = YES;
    _placeHolderView.hidden = NO;
    _searchTextField.text = @"";
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
(NSInteger)section{
    if (arrayArticles.count == 0) {
        self.placeHolderView.hidden = NO;
    } else {
        self.placeHolderView.hidden = YES;
    }
    
    return [arrayArticles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:
(NSIndexPath *)indexPath{
    static NSString *MyIdentifier = @"ArticleTableCell";
    
    ArticleTableCell*cell = [tableView dequeueReusableCellWithIdentifier: MyIdentifier];
    
    
    
    ArticlesListResult *article = arrayArticles[indexPath.row];
    cell.descriptionArticle.text = article.title;
    cell.priceArticle.text = [NSString stringWithFormat:@"$ %@", [@(article.price) stringValue]];
    NSString* webStringURL = [article.thumbnail stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    
    NSURL *url = [NSURL URLWithString:(webStringURL)];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:url];
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.imageArticle.image = [UIImage imageWithData: data];
        });
    });
    
    
    return cell;
}

@end
