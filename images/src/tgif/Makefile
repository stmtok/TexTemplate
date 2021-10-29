SRCS = $(wildcard *.obj)
OUTS = $(SRCS:.obj=.eps)

.PHONY: all
all: eps copy

.PHONY: eps
eps: $(OUTS)

$(OUTS): $(SRCS)
	tgif -print -color -eps $(@:eps=obj)

.PHONY: copy
copy: $(OUTS)
	cp $? ../../

.PHONY: clean
clean:
	rm -f $(OUTS)