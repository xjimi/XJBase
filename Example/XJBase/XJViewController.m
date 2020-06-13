//
//  XJViewController.m
//  XJBase
//
//  Created by xjimi on 06/18/2019.
//  Copyright (c) 2019 xjimi. All rights reserved.
//

#import "XJViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <Masonry/Masonry.h>
#import "AlbumCell.h"
#import "AlbumModel.h"
#import "AlbumHeader.h"

@interface XJViewController ()

@property (nonatomic, strong) XJTableViewManager *tableView;

@property (nonatomic, strong) AFNetworkReachabilityManager *reachability;

@end

@implementation XJViewController

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setupScrollViewState];
    [self showLoading];
    [self addNetworkStatus];
}

- (UIScrollView *)createBaseScrollView {
    return self.tableView = [self createTableView];
}

- (void)refreshData
{
    //[self showNetworkError];
    //return;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        XJTableViewDataModel *dataModel = [XJTableViewDataModel
                                           modelWithHeader:nil
                                           rows:[self createRows]];
        [self.tableView refreshDataModel:dataModel];
        
        [self finishPullToRefresh];
        [self addPullToRefresh];
        [self addLoadMore];
        
    });
}

- (void)loadMoreData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        XJTableViewDataModel *newDataModel = [XJTableViewDataModel
                                              modelWithHeader:[self createSection]
                                              rows:[self createRows]];
        [self.tableView appendDataModel:newDataModel];
        [self showLoadMore];
        
    });
}

- (NSMutableArray *)createRows
{
    NSMutableArray *rows = [NSMutableArray array];
    for (int i = 0; i < 15; i++)
    {
        AlbumModel *model = [[AlbumModel alloc] init];
        model.albumName = @"Scorpion (OVO Updated Version) [iTunes][2018]";
        model.artistName = @"Drake";
        model.imageName = @"drake";

        XJTableViewCellModel *cellModel = [XJTableViewCellModel
                                           modelWithReuseIdentifier:[AlbumCell identifier]
                                           cellHeight:80.0f
                                           data:model];
        [rows addObject:cellModel];
    }
    return rows;
}

- (XJTableViewHeaderModel *)createSection
{
    NSString *setion = [NSString stringWithFormat:@"New Album %ld", (long)self.tableView.allDataModels.count];
    XJTableViewHeaderModel *headerModel = [XJTableViewHeaderModel
                                           modelWithReuseIdentifier:[AlbumHeader identifier]
                                           headerHeight:50.0f
                                           data:setion];
    return headerModel;
}

- (void)setupScrollViewState
{
    [self adjustContentInset];
    self.scrollViewState.messageBar.font = [UIFont systemFontOfSize:20 weight:UIFontWeightBold];
    __weak typeof(self)weakSelf = self;
    [self.scrollViewState emptyDataSetConfigBlock:^(XJEmptyDataSetConfig * _Nonnull config) {
        
        //XJEmptyDataSetConfig 屬性修正
        config.props.emptySpaceHeight = 0;
        config.props.emptyVerticalOffset = weakSelf.contentInsetOffset;
        config.emptyViewTapBlock = ^(UIView * _Nonnull view) {
            
            [weakSelf showLoading];
            [weakSelf refreshData];
            
        };
        
    }];
}

- (void)addNetworkStatus
{
    AFNetworkReachabilityManager *reachability = [AFNetworkReachabilityManager manager];
    __weak typeof(self)weakSelf = self;
    [reachability setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
            {
                [weakSelf showNetworkError];
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi:
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                [weakSelf showNetworkError];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                        if (weakSelf.scrollViewState.isEmptyData) {
                            //[weakSelf refreshData];
                        }

                });
                break;
            }
            default:
                break;
        }
    }];
    [reachability startMonitoring];
    self.reachability = reachability;
}

- (XJTableViewManager *)createTableView
{
    XJTableViewManager *tableView = [XJTableViewManager managerWithStyle:UITableViewStyleGrouped];
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [tableView disableGroupHeaderHeight];
    [tableView disableGroupFooterHeight];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    return tableView;
}


@end
