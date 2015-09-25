//
//  ViewController.m
//  PressTest
//
//  Created by iPhone on 2015/09/10.
//  Copyright © 2015年 tatsuno system. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    NSMutableArray * hashArray;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    hashArray = [NSMutableArray new];
    
    self.view.multipleTouchEnabled = YES;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches) {
        [hashArray addObject:[NSNumber numberWithUnsignedLong:[touch hash]]];
    }
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches) {
        NSInteger i = [hashArray indexOfObject:[NSNumber numberWithUnsignedLong:[touch hash]]];
        UIProgressView * progressView = progressViewCollection[i];
        [progressView setProgress:0];
        for(NSInteger j = i + 1; j < 4; j++){
            UIProgressView * nextProgressView = progressViewCollection[j + 1];
            [progressViewCollection[j] setProgress: nextProgressView.progress];
        }
        [progressViewCollection[4] setProgress:0];
    }
    for (UITouch *touch in touches) {
        [hashArray removeObject:[NSNumber numberWithUnsignedLong:[touch hash]]];
    }
}
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self touchesEnded:touches withEvent:event];
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches) {
        NSInteger i = [hashArray indexOfObject:[NSNumber numberWithUnsignedLong:[touch hash]]];
        UIProgressView * progressView = progressViewCollection[i];
        [progressView setProgress:touch.force / touch.maximumPossibleForce];
        NSLog(@"%ld %f",i, touch.force);
    }
}
@end
