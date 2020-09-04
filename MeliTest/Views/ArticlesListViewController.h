//
//  ArticlesListViewController.h
//  MeliTest
//
//  Created by Lucas Furlan on 04/09/2020.
//  Copyright © 2020 Lucas Furlan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticlesListViewModel.h"
#import "JGProgressHUD.h"

@interface ArticlesListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    
    NSMutableArray *arrayArticles;
    NSString *searchTextString;
    
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIView *placeHolderView;


@property (nonatomic, strong) ArticlesListViewModel * viewModel;
@property (nonatomic, strong) JGProgressHUD *HUD;

@end

