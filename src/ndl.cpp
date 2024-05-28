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

#include <vector>

#include <ndl.h>

#include "platform/platform.h"

/**
 * The main namespace of the NDL library.
 */
namespace ndl {
/** Container holding the registered listener functions.                    */
std::vector<ndl_darkModeCallback> listeners;
/** Indicates whether the library has registered itself in the native part. */
bool registered = false;

/**
 * The callback function to be registered in the native part.
 *
 * Calls all currently registered listener functions.
 */
static inline void callback() {
    for (const auto& cb : listeners) {
        cb();
    }
}
}

auto ndl_queryDarkMode() -> bool {
    return ndl_platform_queryDarkMode();
}

auto ndl_registerCallback(ndl_darkModeCallback callback) -> bool {
    if (ndl::listeners.empty() && !ndl::registered) {
        if (!(ndl::registered = ndl_platform_register(ndl::callback))) {
            return false;
        }
    }
    try {
        ndl::listeners.push_back(callback);
    } catch (...) {
        return false;
    }
    return true;
}

auto ndl_deregisterCallback(ndl_darkModeCallback callback) -> bool {
    const auto& it = std::find(ndl::listeners.cbegin(), ndl::listeners.cend(), callback);
    if (it == ndl::listeners.cend()) {
        return false;
    }
    try {
        ndl::listeners.erase(it);
    } catch (...) {
        return false;
    }
    if (ndl::listeners.empty() && ndl::registered) {
        ndl::registered = ndl_platform_deregister(ndl::callback);
    }
    return true;
}
