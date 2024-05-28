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

#ifndef __ndl_h
#define __ndl_h

#ifdef __cplusplus
extern "C" {
#endif

#include <stdbool.h>

/** The required prototype of a listener function. */
typedef void (*ndl_darkModeCallback)(void);

/**
 * @brief Queries whether the current windowing system uses a dark theme.
 *
 * If an error happens `false` is returned.
 *
 * @return whether the current windowing system uses a dark theme
 */
bool ndl_queryDarkMode(void);

/**
 * @brief Registers the given function as dark mode listener.
 *
 * This function is called when the system has or is about to switch its theme
 * between light and dark mode.
 *
 * @param callback the callback function to be registered
 * @return whether the listener was registered successfully
 */
bool ndl_registerCallback(ndl_darkModeCallback callback);

/**
 * Deregisters the given listener function.
 *
 * @param callback the listener function to be deregistered
 * @return whether the function was deregistered successfully
 */
bool ndl_deregisterCallback(ndl_darkModeCallback callback);

#ifdef __cplusplus
} // extern "C"
#endif

#endif /* __ndl_h */
