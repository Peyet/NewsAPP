//
//  MyNewsViewController.m
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/9.
//

#import "MyNewsViewController.h"
#import "MyNormalTableViewCell.h"
#import "MyDetailViewController.h"
#import "MyDeleteCellView.h"
#import "MyListLoader.h"
#import "MyListItem.h"
#import "MySearchBar.h"

@interface MyNewsViewController () <UITableViewDataSource, UITableViewDelegate, MyNormalTableViewCellDelegate>
@property (nonatomic, strong, readwrite) UITableView *tableView;
@property (nonatomic, strong, readwrite) NSMutableArray *dataArray;
@property (nonatomic, strong, readwrite) MyListLoader *listLoader;
@end

@implementation MyNewsViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"新闻";
        self.tabBarItem.image = [UIImage imageNamed:@"page@2x.png"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"page@2x_selected.png"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    self.listLoader = [[MyListLoader alloc] init];
    __weak typeof(self)wself = self;
    [self.listLoader loadListDataWithFinishBlock:^(BOOL success, NSArray<MyListItem *> * _Nonnull dataArray) {
        __strong typeof(wself) strongSelf = wself;
        strongSelf.dataArray = [dataArray mutableCopy];
        [strongSelf.tableView reloadData];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    [self.tabBarController.navigationItem setTitleView:({
        MySearchBar *searchBar = [[MySearchBar alloc] initWithFrame:CGRectMake(0, 0, self.navigationController.navigationBar.bounds.size.width, self.navigationController.navigationBar.bounds.size.height)];
        searchBar;
    })];
}

#pragma mark - UITableViewDataSourceDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (!cell) {
        cell = [[MyNormalTableViewCell	 alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
    }
    cell.delegate = self;
//    cell.textLabel.text = [NSString stringWithFormat:@"title - %@", @(indexPath.row)];
//    cell.detailTextLabel.text = @"detail label";
//    cell.imageView.image = [UIImage imageNamed:@"home@2x.png"];
    [cell layoutTableViewCellWithItem:self.dataArray[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MyListItem *item = self.dataArray[indexPath.row];
    MyDetailViewController *viewController = [[MyDetailViewController alloc] initWithUrlString:item.url];
    viewController.navigationItem.title = [NSString stringWithFormat:@"%@", item.title];
    viewController.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:viewController animated:YES];
    
    // 文章已读标记
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:item.uniquekey];
}

#pragma mark - MyNormalTableViewCellDelegate
- (void)tableViewCell:(UITableViewCell *)tableViewCell clickDeleteButton:(UIButton *)deleteButton {
    MyDeleteCellView *deleteView = [[MyDeleteCellView alloc] initWithFrame:self.view.bounds];
    CGRect rect = [tableViewCell convertRect:deleteButton.frame toView:nil];
    
    __weak typeof(self)wself = self;
    [deleteView showDeleteViewFromPoint:rect.origin clickBlock:^{
        __strong typeof(wself) strongSelf = wself;
//        [strongSelf.dataArray removeLastObject];
        NSIndexPath *selectedRow = [@[[strongSelf.tableView indexPathForCell:tableViewCell]] lastObject];
        [strongSelf.dataArray removeObjectAtIndex:(selectedRow.row)];
        [strongSelf.tableView deleteRowsAtIndexPaths:@[[strongSelf.tableView indexPathForCell:tableViewCell]] withRowAnimation:UITableViewRowAnimationTop];
    }];
    
}


@end
