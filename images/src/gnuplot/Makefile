SRCS = $(wildcard *.plt)
OUTS = $(SRCS:.plt=.eps)

.PHONY: all
all: eps copy

.PHONY: eps
eps: $(OUTS)

$(OUTS): $(SRCS)
	gnuplot -c $(@:eps=plt)

.PHONY: copy
copy: $(OUTS)
	cp $? ../../

.PHONY: clean
clean:
	rm -f $(OUTS)