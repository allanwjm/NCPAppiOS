//
//  NCPComplainForm.h
//  NoiseComplain
//
//  Created by mura on 11/28/15.
//  Copyright © 2015 sysu. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 投诉表单对象类, 保存封装一次投诉所包含的所有信息
 */
@interface NCPComplainForm : NSObject

#pragma mark - 投诉表单信息

// 表格编号(long)
@property(nullable, nonatomic) NSNumber *formId;
// 设备ID
@property(nonnull, nonatomic, readonly) NSString *devId;
// 设备类型
@property(nonnull, nonatomic, readonly) NSString *devType;

// 日期
@property(nonnull, nonatomic) NSDate *date;
// 显示用长日期
@property(nonnull, nonatomic, readonly) NSString *dateLong;
// 显示用短日期
@property(nonnull, nonatomic, readonly) NSString *dateShort;
// 存储/请求用日期
@property(nonnull, nonatomic) NSString *dateStorage;

#pragma mark - 噪声强度信息

// 噪声强度(Array)
@property(nullable, nonatomic, readonly) NSMutableArray *intensities;
// 平均噪声强度(double)
@property(nonatomic, readonly) double averageIntensity;
// 噪声强度JSON字符串
@property(nonnull, nonatomic) NSString *intensitiesJSON;
// 噪声强度是否已经存储满了
@property(nonatomic, readonly) BOOL isIntensitiesFull;

#pragma mark - 地理位置信息

// 坐标系类型
@property(nonnull, nonatomic) NSString *coord;

// 定位位置, 优先手动
@property(nullable, nonatomic, readonly) NSString *address;
// 定位纬度, 优先手动(double)
@property(nullable, nonatomic, readonly) NSNumber *latitude;
// 定位经度, 优先手动(double)
@property(nullable, nonatomic, readonly) NSNumber *longitude;

// 自动定位位置
@property(nullable, nonatomic) NSString *autoAddress;
// 自动定位纬度(double)
@property(nullable, nonatomic) NSNumber *autoLatitude;
// 自动定位经度(double)
@property(nullable, nonatomic) NSNumber *autoLongitude;
// 自动定位海拔(double)
@property(nullable, nonatomic) NSNumber *autoAltitude;
// 自动定位水平精度(double)
@property(nullable, nonatomic) NSNumber *autoHorizontalAccuracy;
// 自动定位垂直精度(double)
@property(nullable, nonatomic) NSNumber *autoVerticalAccuracy;

// 手动定位位置
@property(nullable, nonatomic) NSString *manualAddress;
// 手动定位纬度(double)
@property(nullable, nonatomic) NSNumber *manualLatitude;
// 手动定位经度(double)
@property(nullable, nonatomic) NSNumber *manualLongitude;

#pragma mark - 描述信息

// 噪声类型序号
@property(nonatomic) NSInteger noiseType;
// 噪声类型显示标题
@property(nullable, nonatomic, readonly) NSString *noiseTypeTitle;
// 噪声类型短标题
@property(nullable, nonatomic, readonly) NSString *noiseTypeShort;
// 噪声类型上传内容
@property(nullable, nonatomic, readonly) NSString *noiseTypePost;

// 声功能区序号
@property(nonatomic) NSInteger sfaType;
// 声功能区类型标题
@property(nullable, nonatomic, readonly) NSString *sfaTypeTitle;
// 声功能区短标题
@property(nullable, nonatomic, readonly) NSString *sfaTypeShort;
// 声功能区上传内容
@property(nullable, nonatomic, readonly) NSString *sfaTypePost;

// 描述信息
@property(nullable, nonatomic) NSString *comment;

#pragma mark - 噪声强度记录

// 增加一条噪声强度记录
- (void)addIntensity:(double)intensity;

@end
