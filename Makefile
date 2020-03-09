# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: odrinkwa <odrinkwa@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/06/17 12:13:46 by odrinkwa          #+#    #+#              #
#    Updated: 2019/11/30 17:31:37 by odrinkwa         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

PROJ_NAME	?= LIBFT
TARGET_EXEC	?= libft.a

OBJ_DIR = ./objects

FILE_LAST_MODE = $(OBJ_DIR)/last_version.txt
cat := $(if $(filter $(OS),Windows_NT),type,cat)
LAST_MODE = $(shell $(cat) $(FILE_LAST_MODE) 2>/dev/null)

ifneq ($(mode),debug)
   mode = release
   BUILD_DIR = $(OBJ_DIR)/release
   PREFIX = RELEASE MODE
else
   mode = debug
   BUILD_DIR = $(OBJ_DIR)/debug
   PREFIX = DEBUG MODE
endif

ifneq ($(mode),$(LAST_MODE))
    REBUILD = clean_only_exe
endif

SRC_DIRS	?= ./sources

SRCS		:= $(shell find $(SRC_DIRS) -type f -name *.c )
OBJS		:= $(SRCS:%=$(BUILD_DIR)/%.o)
DEPS		:= $(OBJS:.o=.d)

BASE_INC_DIR	:= includes
INC_DIRS	:= $(shell find $(BASE_INC_DIR) -type d)
INC_FLAGS	:= $(addprefix -I,$(INC_DIRS))

CFLAGS		?= -Wall -Wextra -Werror $(INC_FLAGS) -MMD -MP
ifeq ($(mode),release)
   CFLAGS += -O2
else
   CFLAGS += -O0 -g3
endif

ARFLAGS		= rc

.PHONY: all clean fclean re info

all: info $(TARGET_EXEC)

clean_only_exe:
	@if [ -f "$(TARGET_EXEC)" ]; then \
		printf "$(GREEN_COLOR)%-10s$(BLUE_COLOR)%-9s$(YELLOW_COLOR)  %s$(RESET_COLOR)\n" "[$(PROJ_NAME)]" "[$(PREFIX)]" "Clean bin $(PROJ_NAME), because changed MODE COMPILATION."; \
		rm -rf $(TARGET_EXEC); \
	fi

# make libft file
$(TARGET_EXEC): $(OBJS) $(REBUILD)
	@printf "$(GREEN_COLOR)%-10s$(BLUE_COLOR)%-9s$(YELLOW_COLOR)  %s$(RESET_COLOR) %s\n" "[$(PROJ_NAME)]" "[$(PREFIX)]" "Linking:  " "$@"
	@$(AR) $(ARFLAGS) $(TARGET_EXEC) $(OBJS)
	@ranlib $(TARGET_EXEC)
	@rm -f $(FILE_LAST_MODE)
	@echo "$(mode)" >> $(FILE_LAST_MODE)

# c source
$(BUILD_DIR)/%.c.o: %.c
	@printf "$(GREEN_COLOR)%-10s$(BLUE_COLOR)%-9s$(YELLOW_COLOR)  %s$(RESET_COLOR) %s\n" "[$(PROJ_NAME)]" "[$(PREFIX)]" "Compiling:" "$<"
	@$(MKDIR_P) $(dir $@)
	@$(CC) $(CFLAGS) -c $< -o $@

info:

debug:
	@make -s -C . mode=debug

clean:
	@printf "$(GREEN_COLOR)%-10s$(BLUE_COLOR)%-9s$(YELLOW_COLOR)  %s$(RESET_COLOR)\n" "[$(PROJ_NAME)]" "[$(PREFIX)]" "Clean objects $(PROJ_NAME)"
	@$(RM) -rf $(OBJ_DIR)

fclean:
	@printf "$(GREEN_COLOR)%-10s$(BLUE_COLOR)%-9s$(YELLOW_COLOR)  %s$(RESET_COLOR)\n" "[$(PROJ_NAME)]" "[$(PREFIX)]" "Clean objects $(PROJ_NAME)"
	@$(RM) -rf $(OBJ_DIR)
	@printf "$(GREEN_COLOR)%-10s$(BLUE_COLOR)%-9s$(YELLOW_COLOR)  %s$(RESET_COLOR)\n" "[$(PROJ_NAME)]" "[$(PREFIX)]" "Clean bin $(PROJ_NAME)"
	@rm -rf $(TARGET_EXEC)

re: fclean all

-include $(DEPS)

include colors.mk

MKDIR_P ?= mkdir -p
