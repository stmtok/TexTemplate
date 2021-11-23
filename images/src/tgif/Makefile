SRCS = $(wildcard *.obj)
OUTDIR = ./dist
EPSS = $(addprefix $(OUTDIR)/, $(SRCS:.obj=.eps))

.PHONY: all
all: $(OUTDIR) $(EPSS)

$(OUTDIR):
	mkdir -p $(OUTDIR)

$(OUTDIR)/%.eps: %.obj
	tgif -print -color -eps -o$(OUTDIR) $<
	cp -a $@ ../../

.PHONY: clean
clean:
	rm -rf $(OUTDIR)