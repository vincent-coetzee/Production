//
//  main.m
//  Production
//
//  Created by Vincent Coetzee on 2014/09/17.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

#import <Cocoa/Cocoa.h>

int main(int argc, const char * argv[]) 
	{
	@try
		{
		return NSApplicationMain(argc, argv);
		}
	@catch(NSException* exception)
            {
            NSLog(@"**************************************************************");
            NSLog(@"*");
            NSLog(@"* LAST DITCH EXCEPTION HANDLER !");
            NSLog(@"* YOUR THREAD OF EXECUTION SHOULD NEVER END UP HERE !");
            NSLog(@"*");
            NSLog(@"* %@",exception);
            NSLog(@"*");
            for (NSString* symbol in [exception callStackSymbols])
                {
                NSLog(@"* %@",symbol);
                }
            NSLog(@"*");
            NSLog(@"**************************************************************");
            }
	}
