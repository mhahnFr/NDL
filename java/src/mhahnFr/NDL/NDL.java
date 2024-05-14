/*
 * NDL - Native Dark mode Listener for Java.
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

package mhahnFr.NDL;

/**
 * This class acts as main class of this project.
 *
 * @author mhahnFr
 * @since 10.05.24
 */
public abstract class NDL {
    private NDL() {}

    static {
        System.loadLibrary(Constants.LIBRARY_NAME);
        // TODO: Initialize
    }

    public static void hello() {
        System.out.println("Hello");
    }

    public static native void hello2();
}