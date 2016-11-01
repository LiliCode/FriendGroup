//
//  PassValueDelegate.h
//  好友分组
//
//  Created by LiliEhuu on 16/11/1.
//  Copyright © 2016年 LiliEhuu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PassValueDelegate <NSObject>

@optional
/**
 *  @author Lili, 16-11-01 21:11:09
 *
 *  方向传值
 *
 *  @param sender     传值
 *  @param idendifier 来自哪个类的标示
 */
- (void)passValue:(id)sender idendifier:(NSString *)idendifier;


@end
