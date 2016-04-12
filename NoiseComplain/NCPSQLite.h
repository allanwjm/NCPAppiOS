//
//  NCPSQLiteDAO.h
//  NoiseComplain
//
//  Created by mura on 3/26/16.
//  Copyright © 2016 sysu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NCPComplainForm;
@class NCPComplainProgress;

@interface NCPSQLite : NSObject

#pragma mark - ComplainForm操作

// 插入投诉表单
+ (BOOL)insertComplainForm:(NCPComplainForm *)form;

// 查询全部投诉表单
+ (NSArray *)selectAllComplainForm;

// 删除一条投诉表单
+ (BOOL)deleteComplainForm:(NCPComplainForm *)form;

#pragma mark - ComplainProgress操作

// 插入处理记录
+ (BOOL)insertComplainProgress:(NCPComplainProgress *)progress;

// 查询某个表单的所有处理记录
+ (NSArray *)selectAllComplainProgressForForm:(NCPComplainForm *)form;

// 查询某个表单的最新处理记录
+ (NCPComplainProgress *)selectLatestComplainProgressForForm:(NCPComplainForm *)form;

// 删除某个表单的所有处理记录
+ (BOOL)deleteComplainProgressForForm:(NCPComplainForm *)form;

@end
