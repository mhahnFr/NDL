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
#define NDL_THEME_KEY_PATH @"AppleInterfaceStyle"

@interface NDLListener ()

/** Mutable array holding the registered callback functions. */
@property(nonnull) NSMutableArray<NSValue*>* callbacks;

- (void) observeValueForKeyPath: (NSString*) keyPath
                       ofObject: (id) object
                         change: (NSDictionary<NSKeyValueChangeKey, id>*) change
                        context: (void*) context;

@end

@implementation NDLListener

- (instancetype) init {
    self = [super init];

    if (self != nil) {
        [self setCallbacks: [NSMutableArray new]];
        [[NSUserDefaults standardUserDefaults] addObserver: self
                                                forKeyPath: NDL_THEME_KEY_PATH
                                                   options: NSKeyValueObservingOptionNew
                                                   context: nil];
    }
    return self;
}

- (void) dealloc {
    [[NSUserDefaults standardUserDefaults] removeObserver: self
                                               forKeyPath: NDL_THEME_KEY_PATH
                                                  context: nil];
}

- (BOOL) addCallback: (ndl_platform_callback) callback {
    @try {
        [[self callbacks] addObject: [NSValue valueWithPointer: (void*) callback]];
    } @catch (...) {
        return NO;
    }
    return YES;
}

- (BOOL) removeCallback: (ndl_platform_callback) callback {
    @try {
        [[self callbacks] removeObject: [NSValue valueWithPointer: (void*) callback]];
    } @catch (...) {
        return NO;
    }
    return YES;
}

- (BOOL) empty {
    return [[self callbacks] count] == 0;
}

- (void) observeValueForKeyPath: (NSString*) keyPath
                       ofObject: (id) object
                         change: (NSDictionary<NSKeyValueChangeKey,id>*) change
                        context: (void*) context {
    for (NSValue* element in [self callbacks]) {
        ((ndl_platform_callback) [element pointerValue])();
    }
}

@end
