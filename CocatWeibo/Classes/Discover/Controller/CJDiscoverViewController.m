//
//  CJDiscoverViewController.m
//  CocatWeibo
//
//  Created by chenjie on 11/9/15.
//  Copyright © 2015 atnv. All rights reserved.
//

#import "CJDiscoverViewController.h"
#import "CJSearchBar.h"

@interface CJDiscoverViewController ()

@end

@implementation CJDiscoverViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CJSearchBar *searchBar = [CJSearchBar searchBar];
    [searchBar setFrame:CGRectMake(0, 0, 300, 30)];
    self.navigationItem.titleView = searchBar;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
