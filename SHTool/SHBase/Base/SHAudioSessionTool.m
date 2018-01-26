//
//  SHAudioSessionTool.m
//  SHTool
//
//  Created by senyuhao on 26/01/2018.
//  Copyright © 2018 郑浩. All rights reserved.
//

#import "SHAudioSessionTool.h"
#import <AVFoundation/AVFoundation.h>

@implementation SHAudioSessionTool

// 暂停后台音乐播放
- (void)stopBackgroundAudioPlaying {
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
}

// 启动后台音乐播放
- (void)resumeBackgroundAudioPlay {
    [[AVAudioSession sharedInstance] setActive:NO withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil];
}

// 设置混音播放，app与后台app可以同时播放
- (void)mixBackgroundAudioPlay {
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient
                                     withOptions:AVAudioSessionCategoryOptionDefaultToSpeaker | AVAudioSessionCategoryOptionMixWithOthers
                                           error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
}

@end
