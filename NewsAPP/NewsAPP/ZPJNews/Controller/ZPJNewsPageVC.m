//
//  ZPJNewsPageVC.m
//  NewsAPP
//
//  Created by PeyetZhao on 2022/2/11.
//

#import "ZPJNewsPageVC.h"
#import "ZPJListLoader.h"
#import "ZPJListItem.h"
#import "ZPJNormalNewsCell.h"
#import "ZPJDeleteView.h"
#import "ZPJNewsDetailVC.h"
#import <MJRefresh/MJRefresh.h>
#import "ZPJHeader.h"
#import "ZPJMultiPicNewsCell.h"

@interface ZPJNewsPageVC () <UITableViewDataSource, UITableViewDelegate, ZPJNormalNewsCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) ZPJListLoader *listLoader;
@property (nonatomic, strong) NSMutableDictionary *channelInfo;

@end

@implementation ZPJNewsPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self setupRefresh];
}

#pragma mark - UITableViewDataSourceDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZPJNormalNewsCell *cell ;//= [tableView dequeueReusableCellWithIdentifier:kZPJCellReuseIdentifierNewsCell];ZPJMultiPicNewsCell
    
    ZPJListItem *model = self.dataArray[indexPath.item];
//    if (model.thumbnail_pic_s || model.thumbnail_pic_s02 || model.thumbnail_pic_s03) {
//        cell = [tableView dequeueReusableCellWithIdentifier:kZPJCellReuseIdentifierNewsMultiPicCell];
//        if (!cell) {
//            cell = [[NSBundle mainBundle]loadNibNamed:@"ZPJMultiPicNewsCell" owner:self options:nil].firstObject;
//        }
//        [cell layoutTableViewCellWithItem:model];
//    } else {
    cell = [tableView dequeueReusableCellWithIdentifier:kZPJCellReuseIdentifierNewsCell];
    if (!cell) {
        cell = [[ZPJNormalNewsCell     alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kZPJCellReuseIdentifierNewsCell];
    }
    cell.delegate = self;
    [cell layoutTableViewCellWithItem:self.dataArray[indexPath.row]];
//    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZPJListItem *item = self.dataArray[indexPath.row];
    ZPJNewsDetailVC *viewController = [[ZPJNewsDetailVC alloc] initWithUrlString:item.url];
    viewController.navigationItem.title = [NSString stringWithFormat:@"%@", item.title];
    viewController.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:viewController animated:YES];
    
    // 文章已读标记
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:item.uniquekey];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
}

#pragma mark - MyNormalTableViewCellDelegate
- (void)tableViewCell:(UITableViewCell *)tableViewCell clickDeleteButton:(UIButton *)deleteButton {
    ZPJDeleteView *deleteView = [[ZPJDeleteView alloc] initWithFrame:self.view.bounds];
    CGRect rect = [tableViewCell convertRect:deleteButton.frame toView:nil];
    
    __weak typeof(self)wself = self;
    [deleteView showDeleteViewFromPoint:rect.origin clickBlock:^{
        __strong typeof(wself) strongSelf = wself;
        NSIndexPath *selectedRow = [@[[strongSelf.tableView indexPathForCell:tableViewCell]] lastObject];
        [strongSelf.dataArray removeObjectAtIndex:(selectedRow.row)];
        [strongSelf.tableView deleteRowsAtIndexPaths:@[[strongSelf.tableView indexPathForCell:tableViewCell]] withRowAnimation:UITableViewRowAnimationTop];
    }];
}

#pragma mark - Life Cycle
/// 初始化tableView
- (void)setupTableView {
    _tableView =[[UITableView alloc] init];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    CGSize pageSize = CGSizeMake(kZPJScreenWidth, kZPJScreenHeight - kZPJScreenNavigationBarHeight);//[_channelInfo[kZPJModelKeyNewsChannelPageSize] CGSizeValue];
    self.view.frame = CGRectMake(0, 0, pageSize.width, pageSize.height);
    self.tableView.frame = CGRectMake(0, 0, pageSize.width, pageSize.height);
    
    // 加载数据
    self.listLoader = [ZPJListLoader sharedMyListLoader];
    __weak typeof(self)wself = self;
    [self.listLoader loadListDataWithChannelInfo:self.channelInfo FinishBlock:^(BOOL success, NSArray<ZPJListItem *> * _Nonnull dataArray) {
        __strong typeof(wself) strongSelf = wself;
        strongSelf.dataArray = [dataArray mutableCopy];
        [strongSelf.tableView reloadData];
    }];
}

/// 创建上下拉刷新
- (void)setupRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewmodels)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoremodels)];
    self.tableView.backgroundColor = [UIColor whiteColor];
}

/// 加载下拉数据
- (void)loadNewmodels {
    __weak typeof(self)wself = self;
    [self.listLoader loadListDataWithChannelInfo:self.channelInfo FinishBlock:^(BOOL success, NSArray<ZPJListItem *> * _Nonnull dataArray) {
        __strong typeof(wself) strongSelf = wself;
        if (success) {
            strongSelf.dataArray = [dataArray mutableCopy];
            [strongSelf.tableView.mj_header endRefreshing];
            [strongSelf.tableView reloadData];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [strongSelf.tableView.mj_header endRefreshing];
                [strongSelf.tableView reloadData];
            });
        }
    }];
}

/// 加载上拉数据
- (void)loadMoremodels {
    __weak typeof(self)wself = self;
    [self.listLoader loadListDataWithChannelInfo:self.channelInfo FinishBlock:^(BOOL success, NSArray<ZPJListItem *> * _Nonnull dataArray) {
        __strong typeof(wself) strongSelf = wself;
        if (success) {
            [strongSelf.dataArray addObjectsFromArray:dataArray];
            [strongSelf.tableView.mj_header endRefreshing];
            [strongSelf.tableView reloadData];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [strongSelf.dataArray addObjectsFromArray:dataArray];
                [strongSelf.tableView.mj_header endRefreshing];
                [strongSelf.tableView reloadData];
            });
        }
    }];

}

- (void)setPageChannleInfo:(NSDictionary *)channelInfo {
    self.channelInfo = [channelInfo mutableCopy];
    // 设置初始页
    [self.channelInfo setObject:@(1) forKey:kZPJModelKeyNewsChannelPage];
    self.title = channelInfo[kZPJModelKeyNewsChannelTitle];

}

@end
