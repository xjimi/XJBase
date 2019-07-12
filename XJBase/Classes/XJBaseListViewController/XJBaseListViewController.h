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

- (UIScrollView *)createBaseScrollView;
- (void)refreshData;

@optional

- (void)addLoadMore;
- (void)addPullToRefresh;

- (void)parserRefreshData:(id)responseObject;
- (void)parserLoadMoreData:(id)responseObject;


- (void)loadMoreData;

- (void)showLoadMore;
- (void)finishLoadMore;
- (void)finishPullToRefresh;
- (void)showNetworkError;

@end


@interface XJBaseListViewController : UIViewController

@property (nonatomic, weak, readonly) UIScrollView *baseScrollView;

@property (nonatomic, strong, readonly) XJScrollViewStateManager *scrollViewState;

/** 程序啟始時如需關閉網路監聽，請在 [super viewDidLoad] 前或 init 時設定完成 **/
@property (nonatomic, assign, getter=isNetworkStatusDisabled) BOOL networkStatusDisabled;

@end

NS_ASSUME_NONNULL_END
