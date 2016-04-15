//
//  NCPComplainGuideViewController.m
//  NoiseComplain
//
//  Created by mura on 12/1/15.
//  Copyright © 2015 sysu. All rights reserved.
//

#import "NCPHistoryViewController.h"
#import "NCPComplainForm.h"
#import "NCPComplainProgress.h"
#import "NCPDataPersistence.h"

#import "LGAlertView.h"
#import "NCPWebService.h"

#pragma mark - 常量定义

// 历史投诉表格单元格标识符
static NSString *const kNCPCellIdHistory = @"historyCell";
// 空历史投诉单元格标识符
static NSString *const kNCPCellIdEmptyHistory = @"emptyHistoryCell";
// 投诉按钮单元格标识符
static NSString *const kNCPCellIdComplain = @"complainCell";

// 提交投诉Segue标识符
static NSString *const kNCPSegueIdToComplainForm = @"ComplainGuideToComplainForm";
// 投诉记录详情Segue标识符
static NSString *const kNCPSegueIdToProcess = @"ComplainGuideToProcess";

@interface NCPHistoryViewController ()

#pragma mark - StoryBoard输出口

// 历史投诉TableView
@property(weak, nonatomic) IBOutlet UITableView *tableView;

#pragma mark - 成员变量

// 历史投诉列表
@property(nonatomic) NSArray *historyArray;

// 选择的投诉记录索引
@property(nonatomic) NSUInteger historyIndex;

// 检查进度有更新标识位
@property(nonatomic) BOOL checkProgressUpdate;
// 检查进度更新失败标识位
@property(nonatomic) BOOL checkProgressFailed;

@end

@implementation NCPHistoryViewController

#pragma mark - ViewController生命周期

// 视图载入
- (void)viewDidLoad {
    // 设置编辑按钮
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

// 视图即将显示
- (void)viewWillAppear:(BOOL)animated {
    // 检查历史投诉
    [self reloadHistoryData];
    [self.tableView reloadData];

    // 检查受理进度是否有更新
    self.checkProgressFailed = NO;
    self.checkProgressUpdate = NO;
    [self checkProgress];
}

#pragma mark - 表格数据源

// 重新载入投诉记录数据
- (void)reloadHistoryData {
    self.historyArray = [NCPDataPersistence selectAllComplainForm];
    [self.tableView reloadData];
}

// 表格Section数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

// 表格每Section行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            // 第一个Section只有一个投诉按钮
            return 1;
        case 1: {
            if (self.historyArray.count == 0) {
                // 如果没有投诉记录, 返回一个空行
                return 1;
            } else {
                // 有投诉记录, 每个记录返回一行
                return self.historyArray.count;
            }
        }
        default:
            return 0;
    }
}

// 表格Section的Header
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        if (self.checkProgressUpdate) {
            return @"投诉记录列表 - 有新消息";
        } else {
            return @"投诉记录列表";
        }
    }
    return nil;
}

// 表格Section的Footer
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (section == 1 && self.checkProgressFailed) {
        return @"无法检查投诉受理进度";
    }
    return nil;
}

// 表格单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    switch (indexPath.section) {
        case 0: {
            // 提交投诉按钮Section
            return [tableView dequeueReusableCellWithIdentifier:kNCPCellIdComplain];
        }
        case 1: {
            // 历史投诉Section
            if (self.historyArray.count == 0) {
                // 没有历史投诉
                return [tableView dequeueReusableCellWithIdentifier:kNCPCellIdEmptyHistory];
            } else {

                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kNCPCellIdHistory];
                // 设置表格行显示内容
                NCPComplainForm *form = self.historyArray[(NSUInteger) indexPath.row];
                cell.textLabel.text = [NSString stringWithFormat:@"%@", form.dateShort];
                cell.detailTextLabel.text = form.address;
                // 设置地址显示方式
                return cell;
            }
        }
        default:
            break;
    }
    return nil;
}

#pragma mark - 表格点击事件与Segue跳转

// 表格点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        // 点击了"点击开始投诉"单元格
        [self performSegueWithIdentifier:kNCPSegueIdToComplainForm sender:self];
    } else if (indexPath.section == 1) {
        if (self.historyArray.count == 0) {
            // 点击了"没有投诉记录"单元格
            LGAlertView *complainAlert = [LGAlertView alertViewWithTitle:@"没有投诉记录"
                                                                 message:@"还没有进行过投诉，要发起新的噪声投诉吗？"
                                                                   style:LGAlertViewStyleAlert
                                                            buttonTitles:@[@"投诉"]
                                                       cancelButtonTitle:@"取消"
                                                  destructiveButtonTitle:nil
                                                           actionHandler:^(LGAlertView *alertView, NSString *title, NSUInteger index) {
                                                               [self performSegueWithIdentifier:kNCPSegueIdToComplainForm sender:self];
                                                           }
                                                           cancelHandler:nil
                                                      destructiveHandler:nil];
            [complainAlert showAnimated:YES completionHandler:nil];
        } else {
            // 点击了某个投诉记录
            self.historyIndex = (NSUInteger) indexPath.row;
            [self performSegueWithIdentifier:kNCPSegueIdToProcess sender:self];
        }
    }
    // 取消选择
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

// Segue跳转前传值
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kNCPSegueIdToProcess]) {
        // 如果是去向受理进度的Segue
        id dest = segue.destinationViewController;
        [dest setValue:self.historyArray[self.historyIndex] forKey:@"form"];
    }
    [super prepareForSegue:segue sender:sender];
}

#pragma mark - 表格编辑功能

// 开始编辑表格
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:YES];
}

// 返回单元格是否可以编辑
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (self.historyArray.count > 0) {
            return UITableViewCellEditingStyleDelete;
        }
    }
    return UITableViewCellEditingStyleNone;
}

// 表格被编辑事件(删除)
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // 删除相应的记录
        NCPComplainForm *form = self.historyArray[(NSUInteger) indexPath.row];
        [NCPDataPersistence deleteComplainProgressForForm:form];
        [NCPDataPersistence deleteComplainForm:form];

        // 刷新界面
        [self reloadHistoryData];
        [self.tableView reloadData];
    }
}

#pragma mark - 检查进度更新

// 检查进度更新, 并在有更新时更新本地数据库
- (void)checkProgress {
    // 统计各表单的进度数
    NSMutableDictionary *counts = [NSMutableDictionary dictionaryWithCapacity:self.historyArray.count];
    for (NCPComplainForm *form in self.historyArray) {
        NSArray *progresses = [NCPDataPersistence selectAllComplainProgressForForm:form];
        counts[[NSString stringWithFormat:@"%li", form.formId.longValue]] = @(progresses.count);
    }
    [NCPWebService checkComplainProgress:counts
                                 success:^(NSDictionary *json) {
                                     if (json[@"update"] && ((NSNumber *) json[@"update"]).integerValue != 0) {
                                         // 需要更新
                                         self.checkProgressUpdate = YES;

                                         // 保存新的Progress
                                         NSArray *progresses = json[@"progresses"];
                                         for (NSDictionary *dict in progresses) {
                                             NCPComplainProgress *progress = [NCPComplainProgress progressWithJSON:dict];
                                             [NCPDataPersistence insertComplainProgress:progress];
                                         }
                                     }
                                 }
                                 failure:^(NSString *error) {
                                     // 检查失败, 显示在Header上
                                     self.checkProgressFailed = YES;
                                     [self.tableView reloadData];
                                 }];
}

@end
