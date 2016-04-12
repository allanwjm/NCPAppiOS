//
//  NCPWebService.m
//  NoiseComplain
//
//  Created by mura on 3/26/16.
//  Copyright © 2016 sysu. All rights reserved.
//

#import "NCPWebService.h"
#import "NCPComplainForm.h"
#import "AFNetworking.h"

@implementation NCPWebService

+ (void)request:(NSString *)page
          paras:(NSDictionary *)paras
        success:(void (^)(NSDictionary *))success
        failure:(void (^)(NSString *))failure; {
    // 发送请求
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:[NCPConfigString(@"ServerHost") stringByAppendingString:page]
       parameters:paras
         progress:nil
          success:^(NSURLSessionDataTask *task, id resp) {
              NSError *error;
              NSDictionary *json = [NSJSONSerialization JSONObjectWithData:(NSData *) resp options:0 error:&error];
              if (error) {
                  failure(error.localizedDescription);
              } else {
                  // 解析成功, 请求成功
                  success(json);
              }
          }
          failure:^(NSURLSessionDataTask *task, NSError *error) {
              // 请求失败, 返回错误消息
              NSData *data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
              if (data) {
                  NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                  NSError *jError;
                  NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jError];
                  if (jError) {
                      failure(jError.localizedDescription);
                  } else {
                      failure(json[NCPConfigString(@"ServerErrorMessageKey")]);
                  }
              } else {
                  failure(error.localizedDescription);
              }
          }];
}

// 向服务器发送投诉表单
+ (void)sendComplainForm:(NCPComplainForm *)form
                 success:(void (^)(NSDictionary *))success
                 failure:(void (^)(NSString *))failure; {

    // 组织参数
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[@"platform"] = @"iOS";
    paras[@"devId"] = form.devId;
    paras[@"devType"] = form.devType;
    paras[@"date"] = form.dateStorage;

    paras[@"averageIntensity"] = @(form.averageIntensity);
    paras[@"intensities"] = form.intensitiesJSON;

    paras[@"coord"] = form.coord;
    paras[@"autoAddress"] = form.autoAddress;
    paras[@"autoLatitude"] = form.autoLatitude;
    paras[@"autoLongitude"] = form.autoLongitude;
    paras[@"autoAltitude"] = form.autoAltitude;
    paras[@"autoHorizontalAccuracy"] = form.autoHorizontalAccuracy;
    paras[@"autoVerticalAccuracy"] = form.autoVerticalAccuracy;

    paras[@"manualAddress"] = form.manualAddress;
    paras[@"manualLatitude"] = form.manualLatitude;
    paras[@"manualLongitude"] = form.manualLongitude;

    paras[@"sfaType"] = form.sfaTypePost;
    paras[@"noiseType"] = form.noiseTypePost;
    paras[@"comment"] = form.comment;

    // 发送请求
    [NCPWebService request:NCPConfigString(@"ServerComplainPage")
                     paras:paras success:success failure:failure];
}

// 向服务器检查投诉进度
+ (void)checkComplainProgress:(NSDictionary *)counts
                      success:(void (^)(NSDictionary *))success
                      failure:(void (^)(NSString *))failure {
    // 组织参数
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];

    NSString *indexesJSON = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:counts
                                                                                           options:0
                                                                                             error:nil]
                                                  encoding:NSUTF8StringEncoding];
    paras[@"counts"] = indexesJSON;

    // 发送请求
    [NCPWebService request:NCPConfigString(@"ServerCheckProgressPage")
                     paras:paras success:success failure:failure];
}

@end
