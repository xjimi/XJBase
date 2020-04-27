//
//  XJBaseListViewController.h
//  XJBase
//
//  Created by XJIMI on 2019/6/13.
//  Copyright © 2019 XJIMI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <XJScrollViewStateManager/XJScrollViewStateManager.h>
#import <XJCollectionViewManager/XJCollectionViewManager.h>
#import <XJTableViewManager/XJTableViewManager.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XJBaseListViewControllerProtocol <NSObject>

@required

/** 建造 UITableView 或 UICollectionView **/
- (UIScrollView *)createBaseScrollView;

- (void)refreshData;

@optional

- (void)addPullToRefresh;

- (void)addLoadMore;

- (void)loadMoreData;

- (void)showLoadMore;
- (void)finishLoadMore;
- (void)finishPullToRefresh;
- (void)showLoading;
- (void)showNetworkError;

- (void)adjustContentInset;

@end


@interface XJBaseListViewController : UIViewController

@property (nonatomic, weak, readonly) UIScrollView *baseScrollView;

@property (nonatomic, strong, readonly) XJScrollViewStateManager *scrollViewState;

@property (nonatomic, assign, readonly) CGFloat contentInsetOffset;

@end

NS_ASSUME_NONNULL_END
