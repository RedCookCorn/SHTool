//
//  SHBaseAlert.h
//  SHTool
//
//  Created by senyuhao on 19/01/2018.
//  Copyright © 2018 郑浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHBaseAlert : NSObject

+ (void)alertConfirm:(void(^)(void))block
               title:(NSString *)alertTitle
              cancel:(NSString *)cancelTitle
                sure:(NSString *)sureTitle
             content:(id)formatstring,...;

@end
