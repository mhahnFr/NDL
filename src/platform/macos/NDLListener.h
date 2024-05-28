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

#import <Foundation/Foundation.h>

#import "../platform.h"

/**
 * Objects of this class represent dark mode listener objects for macOS.
 */
@interface NDLListener : NSObject

/**
 * Adds the given callback.
 *
 * @param callback the callback function to be registered
 * @return whether the function was registered successfully
 */
- (BOOL) addCallback: (ndl_platform_callback) callback;

/**
 * Removes the given callback function.
 *
 * @param callback the callback function to be removed
 * @return whether the function was removed successfully
 */
- (BOOL) removeCallback: (ndl_platform_callback) callback;

/**
 * Returns whether no callback functions are currently registered.
 *
 * @return whether the callback function array is empty
 */
- (BOOL) empty;

@end
