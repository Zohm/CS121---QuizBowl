//
//  config.h
//  Quiz-Bowl
//
//  Created by Zohm on 03/03/14.
//  Copyright (c) 2014 Zohm. All rights reserved.
//

#ifndef Quiz_Bowl_config_h
#define Quiz_Bowl_config_h

// Screen dimensions
#define screenWidth [UIScreen mainScreen].bounds.size.height
#define screenHeight [UIScreen mainScreen].bounds.size.width

// Font
#define fontHUD [UIFont fontWithName:@"comic andy" size:45.0]
#define fontHUDBig [UIFont fontWithName:@"comic andy" size:90.0]

// Delay time between question
#define delayQ 0.5f

// Display speed (time per character)
#define timePerChar 0.05f

// Time to buzz in after question is displayed
#define timeToBuzz 10

#endif
