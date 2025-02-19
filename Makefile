CC = gcc
CFLAGS = -Wall -Wextra -Ofast -pedantic -std=c11
#CFLAGS = -Wall -Wextra -g -O0 -pedantic -std=c11
DEPS = $(BIN) $(BUILD) Makefile

BIN = bin
BUILD = obj

$(BUILD)/%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

all: turing assignment max-flow check-flow menger bfs mst Eulerweg heapsort heap_test

turing: $(BUILD)/turing.o $(DEPS)
	$(CC) $(CFLAGS) $(BUILD)/turing.o -o $(BIN)/turing

assignment: $(BUILD)/assignment.o $(BUILD)/digraph.o $(BUILD)/fib_heap.o $(DEPS)
	$(CC) $(CFLAGS) $(BUILD)/assignment.o $(BUILD)/digraph.o $(BUILD)/fib_heap.o -o $(BIN)/assignment

max-flow: $(BUILD)/max-flow.o $(BUILD)/digraph.o $(BUILD)/push-relabel.o $(BUILD)/int_list.o $(DEPS)
	$(CC) $(CFLAGS) $(BUILD)/max-flow.o $(BUILD)/digraph.o $(BUILD)/push-relabel.o $(BUILD)/int_list.o -o $(BIN)/max-flow

check-flow: $(BUILD)/check-flow.o $(BUILD)/digraph.o $(DEPS)
	$(CC) $(CFLAGS) $(BUILD)/check-flow.o $(BUILD)/digraph.o -o $(BIN)/check-flow

menger: $(BUILD)/menger.o $(BUILD)/graph.o $(BUILD)/graph_alg.o $(BUILD)/fib_heap.o $(DEPS)
	$(CC) $(CFLAGS) $(BUILD)/menger.o $(BUILD)/graph.o $(BUILD)/graph_alg.o $(BUILD)/fib_heap.o -o $(BIN)/menger

bfs: $(BUILD)/bfs.o $(BUILD)/graph.o $(BUILD)/graph_alg.o $(BUILD)/fib_heap.o $(DEPS)
	$(CC) $(CFLAGS) $(BUILD)/bfs.o $(BUILD)/graph.o $(BUILD)/graph_alg.o $(BUILD)/fib_heap.o -o $(BIN)/bfs

mst: $(BUILD)/mst.o $(BUILD)/graph.o $(BUILD)/graph_alg.o $(BUILD)/fib_heap.o graph.h graph_alg.h $(DEPS)
	$(CC) $(CFLAGS) $(BUILD)/mst.o $(BUILD)/graph.o $(BUILD)/graph_alg.o $(BUILD)/fib_heap.o -o $(BIN)/mst

Eulerweg: Eulerweg.c graph.c graph.h path.c path.h euler.c euler.h $(DEPS)
	$(CC) $(CFLAGS) path.c euler.c graph.c Eulerweg.c -o $(BIN)/Eulerweg

heapsort: heapsort.c fib_heap.h fib_heap.c $(DEPS)
	$(CC) $(CFLAGS) fib_heap.c heapsort.c -o $(BIN)/heapsort

heap_test: heap_test.c fib_heap.h fib_heap.c $(DEPS)
	$(CC) $(CFLAGS) fib_heap.c heap_test.c -o $(BIN)/heap_test

$(BIN):
	mkdir $(BIN)

$(BUILD):
	mkdir $(BUILD)

.PHONY: clean bin_clean obj_clean
clean: bin_clean obj_clean
bin_clean:
	rm -rf "$(BIN)"
obj_clean:
	rm -rf "$(BUILD)"
