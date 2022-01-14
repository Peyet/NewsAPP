//
//  ViewController.m
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/9.
//

#import "ViewController.h"
#import "MyNormalTableViewCell.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
}

#pragma mark - UITableViewDataSourceDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (!cell) {
        cell = [[MyNormalTableViewCell	 alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
    }
//    cell.textLabel.text = [NSString stringWithFormat:@"title - %@", @(indexPath.row)];
//    cell.detailTextLabel.text = @"detail label";
//    cell.imageView.image = [UIImage imageNamed:@"home@2x.png"];
    [cell layoutTableViewCell];
    return cell;
}

#pragma mark - UITableViewDataSourceDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.navigationItem.title = [NSString stringWithFormat:@"title - %@", @(indexPath.row)];
    viewController.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
