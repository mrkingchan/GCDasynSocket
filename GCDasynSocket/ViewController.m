//
//  ViewController.m
//  GCDasynSocket
//
//  Created by Chan on 2017/3/21.
//  Copyright © 2017年 Chan. All rights reserved.
//

#import "ViewController.h"
@import CocoaAsyncSocket;

#define kHostAddress @"127.0.0.1"
#define kPortNumber 10001

@interface ViewController ()<GCDAsyncSocketDelegate> {
    GCDAsyncSocket *_clientSocekt;
    GCDAsyncSocket *_serverSocket;
    u_int16_t _portNumber;
    BOOL _sucess;
}
@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NSRunLoop mainRunLoop] run];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //客户端
    _clientSocekt = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    NSError *error;
    _sucess = [_clientSocekt  connectToHost:kHostAddress
                                     onPort:kPortNumber
                                      error:&error];
    if (_sucess) {
        NSLog(@"连接成功!");
    } else {
        NSLog(@"%@",error);
    }
    /*
    NSError *error;
    //服务端
    _serverSocket = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    //监听
    [_serverSocket  acceptOnPort:kPortNumber error:&error];*/
}

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    NSLog(@"成功连接到服务器!!客户端:%@\n主机:%@",sock,host);
    [_clientSocekt readDataWithTimeout:-1 tag:100];
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    NSString *messageStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"服务端：%@\n接收到的数据:%@\n",sock,messageStr);
    [_clientSocekt readDataWithTimeout:-1 tag:100];
}

- (IBAction)sendMessage:(id)sender {
        [_clientSocekt writeData:[_Input.text dataUsingEncoding:NSUTF8StringEncoding]
                     withTimeout:-1 tag:101];
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
    NSLog(@"断开连接%@",err);
}

- (void)dealloc {
    [_clientSocekt disconnect];
    [_serverSocket  disconnect];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_clientSocekt disconnect];
    [_serverSocket disconnect];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
@end
