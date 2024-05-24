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

@interface NDLListener ()

@property(nonnull) NSMutableArray<NSValue*>* callbacks;

@end

@implementation NDLListener

- (instancetype) init {
    self = [super init];

    if (self != nil) {
        [self setCallbacks: [NSMutableArray new]];
        // TODO: Register
    }
    return self;
}

- (void) dealloc {
    // TODO: Deregister
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

- (void) registerListener {
    // TODO: Implement
}

@end