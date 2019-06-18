//
//  XJBaseListViewController.m
//  XJBase
//
//  Created by XJIMI on 2019/6/13.
//  Copyright © 2019 XJIMI. All rights reserved.
//

#import "XJBaseListViewController.h"

@interface XJBaseListViewController ()

@property (nonatomic, weak, readwrite) UIScrollView *baseScrollView;

@property (nonatomic, strong, readwrite) XJScrollViewStateManager *scrollViewState;

@end

@implementation XJBaseListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    self.baseScrollView = [self createBaseScrollView];
    [self createScrollViewState];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.scrollViewState reloadEmptyDataSet];
}

- (UIScrollView *)createBaseScrollView {
    return nil;
}

- (void)createScrollViewState
{
    self.scrollViewState = [XJScrollViewStateManager
                            managerWithScrollView:self.baseScrollView];
    __weak typeof(self)weakSelf = self;
    [self.scrollViewState addNetworkStatusChangeBlock:^(NetworkStatus netStatus)
     {
         if (netStatus != NotReachable) {
             [weakSelf refreshData];
         } else {
             [weakSelf.scrollViewState showNetworkError];
         }
     }];

    [self.scrollViewState addDidTapNetworkErrorView:^{
        [weakSelf refreshData];
    }];
}

#pragma mark - Process Pull to Refresh Data

- (void)addPullToRefresh
{
    __weak typeof(self)weakSelf = self;
    [self.scrollViewState addPullToRefreshWithActionHandler:^{
        [weakSelf refreshData];
    }];
}

- (void)refreshData {
}

- (void)parserRefreshData:(id)responseObject {
}

#pragma mark - Process Load More Data

- (void)addLoadMore
{
    __weak typeof(self)weakSelf = self;
    [self.scrollViewState addLoadMoreWithActionHandler:^{
        [weakSelf loadMoreData];
    }];
}

- (void)loadMoreData {
}

- (void)parserLoadMoreData:(id)responseObject {
}

- (void)showLoadMore {
    [self.scrollViewState showLoadMore];
}

- (void)finishLoadMore {
    [self.scrollViewState finishLoadMore];
}

- (void)finishPullToRefresh {
    [self.scrollViewState finishPullToRefresh];
}

- (void)showNetworkError {
    [self.scrollViewState showNetworkError];
}

@end
