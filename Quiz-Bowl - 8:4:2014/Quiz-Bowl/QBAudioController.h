//
//  QBAudioController.h
//  Quiz-Bowl
//
//  Created by jarthurcs on 4/27/14.
//  Copyright (c) 2014 Zohm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QBAudioController : NSObject

-(void)playEffect:(NSString*)name;

-(void)preloadAudioEffects:(NSArray*)effectFileNames;

@end
