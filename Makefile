TARGET = myProgram

MPIC = mpic++
MPIC_FLAGS = -Wall -pedantic -std=c++20 -fopenmp

MKDIR = mkdir -p
BUILD_DIR = build

.PHONY: all
all: compile

.PHONY: compile
compile: $(TARGET)

.PHONY: run
run: $(TARGET)
	mpirun -np 4 --allow-run-as-root ./$(TARGET)

$(TARGET): $(BUILD_DIR)/main.o
	$(MPIC) $(MPIC_FLAGS) $^ -o $@

$(BUILD_DIR)/%.o: src/%.cpp
	$(MKDIR) $(BUILD_DIR)
	$(MPIC) $(MPIC_FLAGS) $< -c -o $@ -g

.PHONY: clean
clean:
	rm -rf $(TARGET) $(BUILD_DIR)/ 2>/dev/null

#depencencies (generated by "g++ -MM src/*.cpp")
$(BUILD_DIR)main.o: src/main.cpp
