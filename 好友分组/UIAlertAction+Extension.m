//
//  UIAlertAction+Extension.m
//  好友分组
//
//  Created by LiliEhuu on 16/11/1.
//  Copyright © 2016年 LiliEhuu. All rights reserved.
//

#import "UIAlertAction+Extension.h"
#import <objc/runtime.h>

@implementation UIAlertAction (Extension)

static char *indexKey = "indexKey";

- (void)setIndex:(NSUInteger)index
{
    objc_setAssociatedObject(self, indexKey, @(index), OBJC_ASSOCIATION_ASSIGN);
}

- (NSUInteger)index
{
    return [objc_getAssociatedObject(self, indexKey) integerValue];
}

+ (instancetype)actionWithTitle:(NSString *)title style:(UIAlertActionStyle)style index:(NSUInteger)index handler:(void (^)(UIAlertAction * _Nonnull))handler
{
    UIAlertAction *action = [[self class] actionWithTitle:title style:style handler:handler];
    action.index = index;
    
    return action;
}




@end





