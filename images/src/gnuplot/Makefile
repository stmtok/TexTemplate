SRCS = $(wildcard *.plt)
OUTDIR = ./dist
OUTS = $(addprefix $(OUTDIR)/, $(SRCS:.plt=.eps))

.PHONY: all
all: $(OUTDIR) $(OUTS)

$(OUTDIR):
	mkdir -p $(OUTDIR)

$(OUTDIR)/%.eps: %.plt
	gnuplot -c $< $(OUTDIR)/$(<:.plt=.eps) 
	cp -a $@ ../../

.PHONY: clean
clean:
	rm -rf $(OUTDIR)
