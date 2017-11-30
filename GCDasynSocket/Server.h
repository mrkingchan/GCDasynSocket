//
//  Server.h
//  GCDasynSocket
//
//  Created by Chan on 2017/3/22.
//  Copyright © 2017年 Chan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Server : NSObject

//服务端在main函数里面run一波 【NSRunLoop run】一波就可以实现服务端的监听
- (void)run;
@end
