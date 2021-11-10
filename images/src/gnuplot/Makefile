SRCS = $(wildcard *.plt)
OUTS = $(SRCS:.plt=.eps)

.PHONY: all
all: $(OUTS)

%.eps: %.plt
	gnuplot -c $<
	cp -a $@ ../../

.PHONY: clean
clean:
	rm -f $(OUTS)