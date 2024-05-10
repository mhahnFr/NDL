#
# NDL - Native Dark mode Listener for Java.
#
# Copyright (C) 2024  mhahnFr
#
# This file is part of NDL.
#
# NDL is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# NDL is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with NDL.  If not, see <https://www.gnu.org/licenses/>.
#

NAME = ndl
NAME_STATIC = $(NAME).a
NAME_SHARED = $(NAME).so
NAME_DYLIB  = $(NAME).dylib

SRCS = $(wildcard *.c)
OBJS = $(patsubst %.c, %.o, $(SRCS))
DEPS = $(patsubst %.c, %.d, $(SRCS))

SRCS_MACOS_OBJC = $(wildcard *.m)

ifeq ($(JAVA_HOME),)
$(error JAVA_HOME not set. NDL requires JDK in version ??? or higher)
endif

CFLAGS = -I $(JAVA_HOME)/include
LDFLAGS =

ifdef ($(shell uname -s),Darwin)
	TARGET = $(NAME_DYLIB)
	CFLAGS += -I $(JAVA_HOME)/include/darwin
	OBJS += $(patsubst %.m, %.o, $(SRCS_MACOS_OBJC))
	DEPS += $(patsubst %.m, %.d, $(SRCS_MACOS_OBJC))
else
	TARGET = $(NAME_SHARED)
endif

$(TARGET): $(OBJS)

.phony: clean
clean:
	- $(RM) $(OBJS) $(NAME_SHARED) $(NAME_STATIC) $(NAME_DYLIB)

.phony: re
re: clean
	$(MAKE)

-include $(DEPS)