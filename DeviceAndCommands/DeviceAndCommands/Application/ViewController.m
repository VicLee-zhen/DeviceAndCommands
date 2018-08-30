//
//  ViewController.m
//  DeviceAndCommands
//
//  Created by lizhen on 2018/8/23.
//  Copyright © 2018年 lizhen. All rights reserved.
//

@import MetalKit;

#import "ViewController.h"
#import "LZRenderer.h"

@interface ViewController ()

@end

@implementation ViewController
{
    MTKView *_view;
    LZRenderer *_renderer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _view = (MTKView *)self.view;
    _view.device = MTLCreateSystemDefaultDevice();
    
    if (!_view.device) {
        NSLog(@"该设备不支持Metal");
        return;
    }
    
    _renderer = [[LZRenderer alloc] initWithMetalKitView:_view];
    
    if (!_renderer) {
        NSLog(@"渲染器初始化失败");
        return;
    }
    
    _view.delegate = _renderer;
    
    _view.preferredFramesPerSecond = 60;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
