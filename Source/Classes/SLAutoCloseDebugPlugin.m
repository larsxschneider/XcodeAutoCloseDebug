/*
 *  Copyright (c) 2011, Lars Schneider
 *  All rights reserved.
 *
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are met:
 *
 *  Redistributions of source code must retain the above copyright notice, this
 *  list of conditions and the following disclaimer.
 *  Redistributions in binary form must reproduce the above copyright notice,
 *  this list of conditions and the following disclaimer in the documentation
 *  and/or other materials provided with the distribution.
 *
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 *  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 *  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 *  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
 *  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 *  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 *  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 *  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 *  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 *  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 *  POSSIBILITY OF SUCH DAMAGE.
 *
 */

#import "SLAutoCloseDebugPlugin.h"


id objc_getClass(const char* name);


static Class IDEWorkspaceWindowControllerClass;


@implementation SLAutoCloseDebugPlugin


+ (void)pluginDidLoad:(NSBundle *)bundle
{
    IDEWorkspaceWindowControllerClass = objc_getClass("IDEWorkspaceWindowController");
    
    static dispatch_once_t pred;
    static SLAutoCloseDebugPlugin *plugin = nil;
    
    dispatch_once(&pred, ^{
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
        plugin = [[SLAutoCloseDebugPlugin alloc] init];
        [pool release];
    });
}


- (id)init
{
    if ((self = [super init]))
    {
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        
        [nc addObserver:self
               selector:@selector(debugSessionsChanged:)
                   name:@"IDECurrentLaunchSessionStateChanged"
                 object:nil];
    }
    
    return self;
}


- (void)debugSessionsChanged:(NSNotification *)notification
{
    // Read all debug session
    NSArray *debugSessions = (NSArray *)[notification.object navigableDebugSessions];
    
    // If there are no debug session, we want to find the debug window and close it
    if (debugSessions.count == 0)
    {
        // Iterate through all windows
        for (NSWindowController *workspaceWindowController in [IDEWorkspaceWindowControllerClass workspaceWindowControllers])
        {
            NSArray *tabViews = [workspaceWindowController orderedTabViewItems];
            NSTabViewItem *tabView = [workspaceWindowController selectedTab];
         
            // Check if the window has exactly one tab with the name `XcodeAutoCloseDebug`
            if ([tabView.label isEqualToString:@"XcodeAutoCloseDebug"] && tabViews.count == 1)
            {
                // Close the window
                [workspaceWindowController close];
                break;
            }
        }
    }
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}


@end
