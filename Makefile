CC       := gcc
CPPFLAGS := -Iinclude
CFLAGS   := -g -Wall

SRC_DIR  := src
OBJ_DIR  := obj
BIN_DIR  := bin

SRC	 := main.c
SRCS     := $(wildcard $(SRC_DIR)/$(SRC))
OBJ      := $(SRCS:$(SRC_DIR)/%.c=$(OBJ_DIR)/%.o)
LDFLAGS	 := -Llib
LDLIBS	 :=

BIN   := $(BIN_DIR)/test

.PHONY: all clean re

all: $(BIN)

$(BIN): $(OBJ) | $(BIN_DIR)
	$(CC) $(LDFLAGS) $^ $(LDLIBS) -o $@

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

$(BIN_DIR) $(OBJ_DIR):
	mkdir -p $@

re: clean all

coverage: $(OBJ) | $(BIN_DIR)
	$(CC) $(LDFLAGS) $(SRCS) $(LDLIBS) -o $(BIN) --coverage
	./$(BIN)
	gcov $(SRC)

clean:
	@$(RM) -rv *.gcno *.gcda $(OBJ_DIR) $(BIN_DIR)
