SRCS = $(wildcard *_fm)
SRCEPS = $(SRCS:_fm=_fm.eps)

.PHONY: all
all: $(SRCS) $(SRCEPS)
	fragmaster

%_fm.eps: ../../%.eps
	cp -a $< $@

.PHONY: clean
clean:
	fragmaster --clean
	rm -rf $(SRCEPS) fragmaster.*
