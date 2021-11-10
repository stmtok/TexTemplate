SRCS = $(wildcard *.obj)
OUTS = $(SRCS:.obj=.eps)

.PHONY: all
all: $(OUTS)

%.eps: %.obj
	tgif -print -color -eps $<
	cp -a $@ ../../

.PHONY: clean
clean:
	rm -f $(OUTS)