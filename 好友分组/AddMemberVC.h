//
//  AddMemberVC.h
//  好友分组
//
//  Created by LiliEhuu on 16/11/1.
//  Copyright © 2016年 LiliEhuu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PassValueDelegate.h"
#import "FriendGroupAction.h"

@interface AddMemberVC : UIViewController

@property (strong , nonatomic) FriendGroupAction *group;        //上个页面的分组
@property (weak , nonatomic) id<PassValueDelegate> delegate;    //代理传值

@end
