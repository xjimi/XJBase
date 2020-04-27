//
//  XJBaseListViewController.m
//  XJBase
//
//  Created by XJIMI on 2019/6/13.
//  Copyright © 2019 XJIMI. All rights reserved.
//

#import "XJBaseListViewController.h"

@interface XJBaseListViewController ()

@property (nonatomic, weak) UIScrollView *baseScrollView;

@property (nonatomic, strong) XJScrollViewStateManager *scrollViewState;

@property (nonatomic, assign) CGFloat contentInsetOffset;


@end

@implementation XJBaseListViewController

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.baseScrollView = [self createBaseScrollView];
    [self createScrollViewState];
}

- (UIScrollView *)createBaseScrollView {
    return nil;
}

- (void)createScrollViewState
{
    self.scrollViewState = [XJScrollViewStateManager
                            managerWithScrollView:self.baseScrollView];
}

#pragma mark - Process Pull to Refresh Data

- (void)addPullToRefresh
{
    __weak typeof(self)weakSelf = self;
    [self.scrollViewState pullToRefreshBlock:^{
        [weakSelf refreshData];
    }];
}

- (void)refreshData {
}

#pragma mark - Process Load More Data

- (void)addLoadMore
{
    __weak typeof(self)weakSelf = self;
    [self.scrollViewState loadMoreBlock:^{
        [weakSelf loadMoreData];
    }];
}

- (void)loadMoreData {
}

- (void)finishPullToRefresh {
    [self.scrollViewState finishPullToRefresh];
}

- (void)showLoadMore {
    [self.scrollViewState showLoadMore];
}

- (void)finishLoadMore {
    [self.scrollViewState finishLoadMore];
}

- (void)showLoading {
    [self.scrollViewState showLoading];
}

- (void)showNetworkError {
    [self.scrollViewState showNetworkError];
}

- (void)adjustContentInset
{
    if (self.navigationController.navigationBar)
    {
        if (@available(iOS 11.0, *)) {
            self.baseScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
        } else {
            self.edgesForExtendedLayout = UIRectEdgeTop;
        }
        
        CGFloat offset = CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
        offset += CGRectGetHeight(self.navigationController.navigationBar.frame);
        self.scrollViewState.messageBar.startPosY = -offset;
        self.contentInsetOffset = -offset;
    }
}

@end
