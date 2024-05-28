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

#ifndef __ndl_platform_h
#define __ndl_platform_h

#ifdef __cplusplus
extern "C" {
#endif

#include <stdbool.h>

/** The callback function prototype. */
typedef void (*ndl_platform_callback)(void);

/**
 * Returns whether the current windowing system uses a dark mode theme.
 *
 * @return whether the system uses a dark mode
 */
bool ndl_platform_queryDarkMode(void);

/**
 * @brief Registers the given callback function.
 *
 * The given callback function is called when the system has or is about to
 * switch between dark and light mode.
 *
 * @param callback the callback function to be registered
 * @return whether the function was registered successfully
 */
bool ndl_platform_register(ndl_platform_callback callback);

/**
 * Deregisters the given callback function.
 *
 * @param callback the callback function to be deregistered
 * @return whether the function was deregistered successfully
 */
bool ndl_platform_deregister(ndl_platform_callback callback);

#ifdef __cplusplus
} // extern "C"
#endif

#endif /* __ndl_platform_h */
