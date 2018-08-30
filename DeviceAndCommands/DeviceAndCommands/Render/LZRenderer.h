//
//  LZRenderer.h
//  DeviceAndCommands
//
//  Created by lizhen on 2018/8/29.
//  Copyright © 2018年 lizhen. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MetalKit;

@interface LZRenderer : NSObject<MTKViewDelegate>

/**
 初始化renderer
 
 @param mtkView 承载drawable的view
 @return renderer
 */
- (nonnull instancetype)initWithMetalKitView:(nonnull MTKView *)mtkView;

@end
