//
//  NCPNoiseRecorder.h
//  NoiseComplain
//
//  Created by cheikh on 25/12/2015.
//  Copyright © 2015 sysu. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 噪声检测仪类, 封装系统接口用于获取环境声音强度
 */
@interface NCPNoiseRecorder : NSObject

@property(nonatomic, readonly) BOOL isRecording;

// 开始检测
- (void)start;

// 结束检测
- (void)stop;

// 开始检测, 一段时间后, 结束并调用timeupHandler块
- (void)startWithDuration:(NSTimeInterval)duration
            timeupHandler:(void (^)(double current, double peak))handler;

// 开始检测, 并定期调用tickHandler块
- (void)startWithTick:(NSTimeInterval)tick
          tickHandler:(void (^)(double current, double peak))handler;

// 开始检测, 定期调用tickHandler块, 一段时间后, 结束并调用timeupHandler块
- (void)startWithDuration:(NSTimeInterval)duration
            timeupHandler:(void (^)(double current, double peak))timeupHandler
                     tick:(NSTimeInterval)tick
              tickHandler:(void (^)(double current, double peak))tickHandler;

@end
