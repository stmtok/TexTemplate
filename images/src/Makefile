.PHONY: all gnuplot tgif fragmaster
all: gnuplot tgif fragmaster

gnuplot:
	$(MAKE) -C gnuplot

tgif:
	$(MAKE) -C tgif

fragmaster:
	$(MAKE) -C fragmaster

.PHONY: clean
clean:
	$(MAKE) -C gnuplot clean
	$(MAKE) -C tgif clean
	$(MAKE) -C fragmaster clean
