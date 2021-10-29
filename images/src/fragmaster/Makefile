SRCS = $(wildcard *_fm)
SRCEPS = $(SRCS:_fm=_fm.eps)
OUTS = $(SRCS:_fm=.pdf)

.PHONY: all
all: fm copy

.PHONY: fm
fm: $(SRCS) $(SRCEPS)
	fragmaster

$(SRCEPS):
	cp ../../$(@:_fm.eps=.eps) $@

.PHONY: copy
copy: $(OUTS)
	cp $? ../../

.PHONY: clean
clean:
	fragmaster --clean
	rm -rf $(SRCEPS) fragmaster.*
