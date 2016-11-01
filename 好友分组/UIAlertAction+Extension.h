//
//  UIAlertAction+Extension.h
//  好友分组
//
//  Created by LiliEhuu on 16/11/1.
//  Copyright © 2016年 LiliEhuu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertAction (Extension)

@property (assign , nonatomic) NSUInteger index;    //tag

/**
 *  @author Lili, 16-11-01 21:11:52
 *
 *  UIAlertAction 扩展index
 *
 *  @param title   标题
 *  @param style   风格
 *  @param index   下标
 *  @param handler 回调
 *
 *  @return 返回实例
 */
+ (instancetype)actionWithTitle:(NSString *)title style:(UIAlertActionStyle)style index:(NSUInteger)index handler:(void (^)(UIAlertAction * _Nonnull))handler;

@end
