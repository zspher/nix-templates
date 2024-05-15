CC = gcc
FLAGS = -Wall -std=c2x -lm

ifdef DEBUG
CFLAGS = -fsanitize=address -g -Wextra -pedantic-errors $(FLAGS)
else
CFLAGS = -O3 $(FLAGS)
endif

SRCDIR = src
BUILDDIR = build
PROGRAM = hello-world
SOURCES = main.c

all: $(BUILDDIR)/$(PROGRAM)

$(BUILDDIR)/%.o: $(SOURCES:%.c=$(SRCDIR)/%.c) | $(BUILDDIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILDDIR)/$(PROGRAM): $(SOURCES:%.c=$(BUILDDIR)/%.o)
	$(CC) $(CFLAGS) $^ -o $@

$(BUILDDIR):
	mkdir -p $(BUILDDIR)

.PHONY: clean

run:
	make && ./$(BUILDDIR)/$(PROGRAM)

clean:
	rm -rf $(BUILDDIR)
