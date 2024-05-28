/*
 * NDL - Native Dark mode Listener.
 *
 * Copyright (C) 2024  mhahnFr
 *
 * This file is part of NDL.
 *
 * NDL is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * NDL is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with NDL.  If not, see <https://www.gnu.org/licenses/>.
 */

#import "NDLListener.h"

/** The internal name of the theme change notification. */
#define NDL_THEME_CHANGED_NOTIFICATION @"AppleInterfaceThemeChangedNotification"

@interface NDLListener ()

/** Mutable array holding the registered callback functions. */
@property(nonnull) NSMutableArray<NSValue*>* callbacks;

/**
 * Callback function for the theme changed notification.
 *
 * @param notification the broadcasted notification
 */
- (void) themeChangedWithNotification: (NSNotification*) notification;

@end

@implementation NDLListener

- (instancetype) init {
    self = [super init];

    if (self != nil) {
        [self setCallbacks: [NSMutableArray new]];
        [[NSDistributedNotificationCenter defaultCenter] addObserver: self
                                                            selector: @selector(themeChangedWithNotification:)
                                                                name: NDL_THEME_CHANGED_NOTIFICATION
                                                              object: nil
                                                  suspensionBehavior: NSNotificationSuspensionBehaviorCoalesce];
    }
    return self;
}

- (void) dealloc {
    [[NSDistributedNotificationCenter defaultCenter] removeObserver: self];
}

- (BOOL) addCallback: (ndl_platform_callback) callback {
    @try {
        [[self callbacks] addObject: [NSValue valueWithPointer: callback]];
    } @catch (...) {
        return NO;
    }
    return YES;
}

- (BOOL) removeCallback: (ndl_platform_callback) callback {
    @try {
        [[self callbacks] removeObject: [NSValue valueWithPointer: callback]];
    } @catch (...) {
        return NO;
    }
    return YES;
}

- (BOOL) empty {
    return [[self callbacks] count] == 0;
}

- (void) themeChangedWithNotification: (NSNotification*) notification {
    for (NSValue* element in [self callbacks]) {
        ((ndl_platform_callback) [element pointerValue])();
    }
}

@end
