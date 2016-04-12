//
//  NCPComplainProcess.h
//  NoiseComplain
//
//  Created by mura on 4/7/16.
//  Copyright © 2016 sysu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NCPComplainForm;

/*
 * 投诉受理进度类, 每个实例对应一次进度受理
 */
@interface NCPComplainProgress : NSObject

#pragma mark - 字段

// 处理进度ID(long)
@property(nonatomic) NSNumber *progressId;
// 所属表单ID(long)
@property(nonatomic) NSNumber *formId;

// 日期
@property(nonatomic) NSDate *date;
// 显示用长日期
@property(nonatomic, readonly) NSString *dateLong;
// 显示用短日期
@property(nonatomic, readonly) NSString *dateShort;
// 存储/请求用日期
@property(nonatomic) NSString *dateStorage;

// 处理结束标识位(BOOL)
@property(nonatomic) NSNumber *finished;

// 进度标题
@property(nonatomic) NSString *title;
// 进度描述
@property(nonatomic) NSString *comment;

// 进度详细信息(字典形式)
@property(nonatomic) NSDictionary *details;
// 进度详细信息(JSON字符串形式)
@property(nonatomic) NSString *detailsJSON;

#pragma mark - 工厂方法

// 使用JSON字典生成对应的Progress
+ (NCPComplainProgress *)progressWithJSON:(NSDictionary *)json;

@end
