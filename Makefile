#
# NDL - Native Dark mode Listener.
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
NAME_STATIC = lib$(NAME).a
NAME_SHARED = lib$(NAME).so
NAME_DYLIB  = lib$(NAME).dylib

SRCS = $(shell find src -type f -name \*.c \! -path src/platform)
OBJS = $(patsubst %.c, %.o, $(SRCS))
DEPS = $(patsubst %.c, %.d, $(SRCS))

SRCS_CPP = $(shell find src -type f -name \*.cpp \! -path src/platform)
OBJS += $(patsubst %.cpp, %.o, $(SRCS_CPP))
DEPS += $(patsubst %.cpp, %.d, $(SRCS_CPP))

SRCS_MACOS_OBJC = $(shell find src/platform/macos -type f -name \*.m)

COMMON_FLAGS = -Wall -Wextra -pedantic -I 'include'
CFLAGS = $(COMMON_FLAGS) -std=c11
CXXFLAGS = $(COMMON_FLAGS) -std=c++11
LDFLAGS =

ifeq ($(shell uname -s),Darwin)
	TARGET = $(NAME_DYLIB)
	OBJS += $(patsubst %.m, %.o, $(SRCS_MACOS_OBJC))
	DEPS += $(patsubst %.m, %.d, $(SRCS_MACOS_OBJC))
	LDFLAGS += -framework AppKit
else
	TARGET = $(NAME_SHARED)
endif

.phony: main
main: $(TARGET)

$(NAME_STATIC): $(OBJS)
	$(AR) -crs $@ $(OBJS)

$(NAME_SHARED): $(OBJS)
	$(CC) $(LDFLAGS) -shared -o $@ $(OBJS)

$(NAME_DYLIB): $(OBJS)
	$(CC) $(LDFLAGS) -dynamiclib -o $@ $(OBJS)

%.o: %.c
	$(CC) $(CFLAGS) -MMD -MP -c -o $@ $<

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -MMD -MP -c -o $@ $<

%.o: %.m
	$(CC) $(CFLAGS) -MMD -MP -c -o $@ $<

.phony: clean
clean:
	- $(RM) $(OBJS) $(DEPS) $(NAME_SHARED) $(NAME_STATIC) $(NAME_DYLIB)

.phony: re
re: clean
	$(MAKE)

-include $(DEPS)
