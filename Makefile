# コンパイル対象Texファイル
TARGET=main
# 出力先ディレクトリ名
OUTPUT=out
# Texコマンド
TEX=uplatex --output-directory=$(OUTPUT) -synctex=1 -kanji=utf8 -interaction=nonstopmode
# BibTexコマンド
BIB=upbibtex
OUTFILE=$(OUTPUT)/$(TARGET)
# DVI経由PDF出力
pdf: $(OUTFILE).pdf
ps: $(OUTFILE).ps
all: $(OUTFILE).pdf $(OUTFILE).ps

# 出力先ディレクトリ作成
$(OUTPUT):
	mkdir -p $(OUTPUT)

# DVI出力
$(OUTFILE).dvi: $(TARGET).tex *.tex $(OUTPUT)
	$(TEX) $<; $(TEX) $<; $(TEX) $<;

# Bib中間ファイル出力
$(OUTFILE).bbl: $(TARGET).tex $(TARGET).bib $(OUTPUT)
	$(TEX) $<; $(BIB) $(OUTFILE); $(TEX) $<; $(TEX) $<

# PS出力
$(OUTFILE).ps: $(OUTFILE).dvi $(OUTFILE).bbl $(OUTPUT)
	dvips -o $@ $<

# DVIファイルからPDF出力
$(OUTFILE).pdf: $(OUTFILE).dvi $(OUTFILE).bbl $(OUTPUT)
	dvipdfmx -o $@ $<

# PS経由PDF出力
# $(OUTFILE).pdf: $(OUTFILE).ps
# 	ps2pdf $< $@


# 生成物の削除
clean:
	rm -rf $(OUTFILE).pdf $(OUTFILE).ps $(OUTFILE).aux $(OUTFILE).bbl $(OUTFILE).blg $(OUTFILE).dvi $(OUTFILE).log $(OUTFILE).synctex*

.PHONE: all pdf ps clean
