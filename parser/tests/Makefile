CXX      := -clang++
CXXFLAGS := -pedantic-errors -Wall -Wextra -Werror
LDFLAGS  := -L/usr/lib -lstdc++ -lm
BUILD    := ../build/tests
OBJ_DIR  := $(BUILD)/objects
TEST_DIR := $(BUILD)
TARGET   := mmbk_test
INCLUDE  := -Iinclude/ -I../src
APP_SRC  := $(wildcard ../src/*.cpp)
SRC      := $(wildcard *.cpp)  $(filter-out ../src/main.cpp, $(APP_SRC))

OBJECTS      := $(SRC:%.cpp=$(OBJ_DIR)/%.o)
DEPENDENCIES := $(OBJECTS:.o=.d)

all: info build $(TEST_DIR)/$(TARGET) assets
	-@$(BUILD)/$(TARGET) --log_level=success

$(OBJ_DIR)/%.o: %.cpp
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) $(INCLUDE) -c $< -MMD -o $@

$(TEST_DIR)/$(TARGET): $(OBJECTS)
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -o $(TEST_DIR)/$(TARGET) $^ $(LDFLAGS)

-include $(DEPENDENCIES)

.PHONY: all build clean debug release info

assets:
ifneq ($(wildcard ../assets/test),)
		@mkdir -p $(TEST_DIR)/assets
		@cp ../assets/tests/* $(TEST_DIR)/assets
endif

build:
	@mkdir -p $(TEST_DIR)
	@mkdir -p $(OBJ_DIR)

debug: CXXFLAGS += -DDEBUG -g
debug: all

release: CXXFLAGS += -O2
release: all

info:
	@echo "[*] Test dir:        ${TEST_DIR}     "
	@echo "[*] Object dir:      ${OBJ_DIR}     "
	@echo "[*] Sources:         ${SRC}         "
	@echo "[*] Objects:         ${OBJECTS}     "
	@echo "[*] Dependencies:    ${DEPENDENCIES}"
