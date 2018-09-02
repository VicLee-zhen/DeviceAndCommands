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
    NSTimer *_timer;
}

- (nonnull instancetype)initWithMetalKitView:(nonnull MTKView *)mtkView {
    self = [super init];
    if (self) {
        _device = mtkView.device;
        _commandQueue = [_device newCommandQueue];
        
        // 测试当前帧率
        _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerTest) userInfo:nil repeats:YES];
        
        // 因不涉及滑动，遂直接用NSDefaultRunLoopMode
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    }
    return self;
}

- (void)timerTest {
    NSLog(@"当前帧率 = %d", b);
    b = 0;
}

#pragma mark - MTKViewDelegate methods

- (void)drawInMTKView:(MTKView *)view {
    b += 1;
    
    // 随机设置个颜色
    int R = (arc4random_uniform(256));
    int G = (arc4random_uniform(256));
    int B = (arc4random_uniform(256));
    view.clearColor = MTLClearColorMake(R /255.0, G /255.0, B /255.0, 1.0);
    
    // 为当前可渲染区域的每一个渲染通道创建命令编码器对象
    id<MTLCommandBuffer> commandBuffer = [_commandQueue commandBuffer];
    commandBuffer.label = @"commandId";
    
    // 创建渲染通道描述符，由view的可渲染区域生成
    MTLRenderPassDescriptor *renderPassDescriptor = view.currentRenderPassDescriptor;
    
    // 只有成功创建了渲染通道之后才可以在view的可渲染区域渲染图像。此处需要判空一下
    if(renderPassDescriptor != nil)
    {
        id<MTLRenderCommandEncoder> renderEncoder = [commandBuffer renderCommandEncoderWithDescriptor:renderPassDescriptor];
        renderEncoder.label = @"renderEncoderId";
        
        // 我们通常使用render命令编码器来绘制对象，但是对于本示例，我们只需要GPU clear命令，当我们创建编码器时，Metal隐式地执行这个命令。
        // 因为我们没有画任何东西，表明我们已经用完了这个编码器
        [renderEncoder endEncoding];
        
        // 添加最后一个命令，将已清除的drawable文件显示在屏幕上
        [commandBuffer presentDrawable:view.currentDrawable];
    }
    
    // 在这里完成渲染，并将命令缓冲区提交给GPU
    [commandBuffer commit];
}

- (void)mtkView:(nonnull MTKView *)view drawableSizeWillChange:(CGSize)size {
    
}


@end
