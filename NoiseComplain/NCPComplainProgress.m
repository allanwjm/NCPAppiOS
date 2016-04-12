//
//  NCPComplainProcess.m
//  NoiseComplain
//
//  Created by mura on 4/7/16.
//  Copyright © 2016 sysu. All rights reserved.
//

#import "NCPComplainProgress.h"
#import "NCPComplainForm.h"

@implementation NCPComplainProgress

// 初始化
- (instancetype)init {
    self = [super init];
    if (self) {
        _details = [NSDictionary dictionary];
    }
    return self;
}

#pragma mark - 工厂方法

// 使用JSON字典生成对应的Progress
+ (NCPComplainProgress *)progressWithJSON:(NSDictionary *)json {
    NCPComplainProgress *progress = [[NCPComplainProgress alloc] init];
    // 赋值
    progress.progressId = json[@"progressId"];
    progress.formId = json[@"formId"];
    progress.dateStorage = json[@"date"];
    progress.finished = @(((NSNumber *) json[@"finished"]).integerValue != 0);
    progress.title = json[@"title"];
    progress.comment = json[@"comment"];
    progress.details = json[@"details"];
    return progress;
}

#pragma mark - 日期格式转换

// 显示用长日期
- (NSString *)dateLong {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:NCPConfigString(@"DateFormatDisplayLong")];
    return [df stringFromDate:self.date];
}

// 显示用短日期
- (NSString *)dateShort {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:NCPConfigString(@"DateFormatDisplayShort")];
    return [df stringFromDate:self.date];
}

// 存储/请求用日期
- (NSString *)dateStorage {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:NCPConfigString(@"DateFormatStorage")];
    return [df stringFromDate:self.date];
}

// 使用存储/请求用日期设置日期值
- (void)setDateStorage:(NSString *)dateStorage {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:NCPConfigString(@"DateFormatStorage")];
    self.date = [df dateFromString:dateStorage];
}

#pragma mark - 详细信息JSON格式转换

- (NSString *)detailsJSON {
    return [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:self.details
                                                                          options:0
                                                                            error:nil]
                                 encoding:NSUTF8StringEncoding];
}

- (void)setDetailsJSON:(NSString *)detailsJSON {
    self.details = [NSJSONSerialization JSONObjectWithData:[detailsJSON dataUsingEncoding:NSUTF8StringEncoding]
                                                   options:0
                                                     error:nil];
}

@end
