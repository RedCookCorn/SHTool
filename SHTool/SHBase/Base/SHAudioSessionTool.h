//
//  SHAudioSessionTool.h
//  SHTool
//
//  Created by senyuhao on 26/01/2018.
//  Copyright © 2018 郑浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHAudioSessionTool : NSObject

// 暂停后台音乐播放
- (void)stopBackgroundAudioPlaying;

// 启动后台音乐播放
- (void)resumeBackgroundAudioPlay;

// 设置混音播放，app与后台app可以同时播放
- (void)mixBackgroundAudioPlay;

@end
