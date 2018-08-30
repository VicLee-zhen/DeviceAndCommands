//
//  LZRenderer.m
//  DeviceAndCommands
//
//  Created by lizhen on 2018/8/29.
//  Copyright © 2018年 lizhen. All rights reserved.
//

@import MetalKit;

#import "LZRenderer.h"

@implementation LZRenderer
{
    id<MTLDevice> _device;
    id<MTLCommandQueue> _commandQueue;
    int b;
}

- (nonnull instancetype)initWithMetalKitView:(nonnull MTKView *)mtkView {
    self = [super init];
    if (self) {
        _device = mtkView.device;
        _commandQueue = [_device newCommandQueue];
    }
    return self;
}

#pragma mark - MTKViewDelegate methods

- (void)drawInMTKView:(MTKView *)view {
    
    b += 1;
    NSLog(@"每秒60次 = %d", b);
}

- (void)mtkView:(nonnull MTKView *)view drawableSizeWillChange:(CGSize)size {
    
}


@end
