//
//  NCPProgressViewController.m
//  NoiseComplain
//
//  Created by mura on 4/8/16.
//  Copyright © 2016 sysu. All rights reserved.
//

#import "NCPProgressViewController.h"
#import "NCPComplainForm.h"
#import "NCPComplainProgress.h"
#import "NCPProgressTableCell.h"
#import "NCPDataPersistence.h"

#pragma mark - 常量定义

// 去向记录详情的Segue标识符
static NSString *const kNCPSegueIdToDetail = @"ComplainProcessToDetail";

// 跳转投诉详情单元格标识符
static NSString *const kNCPCellIdToDetail = @"toDetailCell";
// 受理标题单元格标识符
static NSString *const kNCPCellIdProgressTitle = @"progressTitleCell";
// 受理进度单元格标识符
static NSString *const kNCPCellIdProgress = @"progressCell";

@interface NCPProgressViewController ()

// 进度数组
@property(nonatomic) NSArray *progresses;
// 最新进度
@property(nonatomic) NCPComplainProgress *latestProgress;

@end

@implementation NCPProgressViewController

#pragma mark - ViewController生命周期

// 视图载入完毕
- (void)viewDidLoad {
    [super viewDidLoad];

    // 从SQLite中载入进度数组
    self.progresses = [NCPDataPersistence selectAllComplainProgressForForm:self.form];
    self.latestProgress = [NCPDataPersistence selectLatestComplainProgressForForm:self.form];
}

#pragma mark - 表视图点击事件

// 表视图点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 取消选择焦点
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 表视图数据源

// 节数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

// 节头
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"点击查看更多投诉详情";
    } else if (section == 1) {
        return @"受理进度列表";
    }
    return [super tableView:tableView titleForFooterInSection:section];
}

// 每节行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 1 + self.progresses.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row >= 1) {
        return 54;
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}


// 计算单元格所处的位置
- (NCPProgressTableCellPosition)calPosition:(NSIndexPath *)indexPath {
    if (self.progresses.count <= 1) {
        // 最多只有一条进度记录
        return NCPProgressTableCellPositionUnique;
    } else if (self.progresses.count == 2) {
        // 有两条进度记录
        if (indexPath.row == 1) {
            return NCPProgressTableCellPositionTop;
        } else {
            return NCPProgressTableCellPositionBottom;
        }
    } else {
        // 有多条进度记录
        if (indexPath.row == 1) {
            return NCPProgressTableCellPositionTop;
        } else if (indexPath.row == self.progresses.count) {
            return NCPProgressTableCellPositionBottom;
        } else {
            return NCPProgressTableCellPositionMiddle;
        }
    }
}

// 获取单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        // 投诉详情按钮
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kNCPCellIdToDetail];
        cell.textLabel.text = self.form.dateShort;
        cell.detailTextLabel.text = self.form.address;
        return cell;
    } else if (indexPath.section == 1 && indexPath.row == 0) {
        // 受理进度标题
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kNCPCellIdProgressTitle];
        if (self.latestProgress && self.latestProgress.finished.boolValue) {
            // 受理结束
            cell.detailTextLabel.text = @"受理完成";
        } else {
            cell.detailTextLabel.text = @"受理中...";
        }
        return cell;
    } else if (indexPath.section == 1 && indexPath.row >= 1) {
        // 受理进度单元格
        NCPProgressTableCell *cell = [tableView dequeueReusableCellWithIdentifier:kNCPCellIdProgress];
        // 设置进度单元格内容
        NCPComplainProgress *progress = self.progresses[(NSUInteger) (indexPath.row - 1)];
        cell.progress = progress;
        cell.labelTitle.text = progress.title;
        cell.labelComment.text = progress.comment;
        cell.labelDate.text = progress.dateShort;
        [cell setPosition:[self calPosition:indexPath]];
        return cell;
    }
    return nil;
}

#pragma mark - Segue跳转

// Segue跳转前传值
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kNCPSegueIdToDetail]) {
        // 如果是去向记录详情的Segue
        id dest = segue.destinationViewController;
        [dest setValue:self.form forKey:@"form"];
    }
    [super prepareForSegue:segue sender:sender];
}

@end
