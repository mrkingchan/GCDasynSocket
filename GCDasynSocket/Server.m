//
//  Server.m
//  GCDasynSocket
//
//  Created by Chan on 2017/3/22.
//  Copyright © 2017年 Chan. All rights reserved.
//

#import "Server.h"
@import CocoaAsyncSocket;

@interface Server()<GCDAsyncSocketDelegate>{
    GCDAsyncSocket *_server;
    NSMutableArray *_sockets;
}

@end
@implementation Server

- (instancetype)init {
    self = [super init];
    _sockets = [NSMutableArray new];
    if (self) {
        _server = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    return self;
}

- (void)run {
    NSError *error;
    [_server  acceptOnPort:12345 error:&error];
    if (!error) {
        NSLog(@"服务器开启成功!");
    } else {
        NSLog(@"服务器开启失败:%@",error.localizedDescription);
    }
}

- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket {
    [_sockets addObject:newSocket];
    NSLog(@"接收到新的客户端socket!");
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    NSString *messageStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"接收到来自客户端的数据:%@",messageStr);
}

- (void)socket:(GCDAsyncSocket *)sock didReadPartialDataOfLength:(NSUInteger)partialLength tag:(long)tag {
    NSLog(@"正在接收到来自客户端的数据。。。。");
}
@end
