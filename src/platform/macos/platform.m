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

#import <AppKit/AppKit.h>

#import "../platform.h"

bool ndl_platform_queryDarkMode(void) {
    const NSAppearanceName appearanceName = [[[NSApplication sharedApplication] effectiveAppearance] name];

    return appearanceName == NSAppearanceNameDarkAqua
        || appearanceName == NSAppearanceNameVibrantDark;
}

bool ndl_platform_register(ndl_platform_callback callback) {
    // TODO: Implement
    return false;
}

bool ndl_platform_deregister(ndl_platform_callback callback) {
    // TODO: Implement
    return false;
}
