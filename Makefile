# コンパイル対象Texファイル
TARGET=main
# 出力先ディレクトリ名
OUTPUT=out
# Texコマンド
TEX=uplatex
# 通常Texオプション
TEXOPTION=--output-directory=$(OUTPUT) -synctex=1 -kanji=utf8 -interaction=nonstopmode
# BibTexコマンド
BIB=upbibtex
# 出力ファイル
OUTFILE=$(OUTPUT)/$(TARGET)
# diff リビジョン
REV=ffa3abc11cc6133d01b8d92ac17662b94addde62
# diff出力先ディレクトリ名
DIFFDIR=diff
# diff TEXオプション
DIFFTEXOPTION=--output-directory=$(DIFFDIR) -kanji=utf8 -interaction=nonstopmode
# diff出力ファイル
DIFFFILE=$(DIFFDIR)/$(TARGET)

# DVI経由PDF出力
pdf: $(OUTFILE).pdf
ps: $(OUTFILE).ps
diff: $(DIFFFILE).pdf
all: $(OUTFILE).pdf $(OUTFILE).ps $(DIFFFILE).pdf

# 出力先ディレクトリ作成
$(OUTPUT):
	mkdir -p $(OUTPUT)

# DVI出力
$(OUTFILE).dvi: $(TARGET).tex *.tex $(OUTPUT)
	$(TEX) $(TEXOPTION) $<; $(TEX) $(TEXOPTION) $<; $(TEX) $(TEXOPTION) $<;

# Bib中間ファイル出力
$(OUTFILE).bbl: $(TARGET).tex $(TARGET).bib $(OUTPUT)
	$(TEX) $(TEXOPTION) $<; $(BIB) $(OUTFILE); $(TEX) $(TEXOPTION) $<; $(TEX) $(TEXOPTION) $<

# PS出力
$(OUTFILE).ps: $(OUTFILE).dvi $(OUTFILE).bbl $(OUTPUT)
	dvips -o $@ $<

# DVIファイルからPDF出力
$(OUTFILE).pdf: $(OUTFILE).dvi $(OUTFILE).bbl $(OUTPUT)
	dvipdfmx -o $@ $<

# PS経由PDF出力
# $(OUTFILE).pdf: $(OUTFILE).ps
# 	ps2pdf $< $@

# diff pdf生成
$(DIFFFILE).pdf: $(DIFFFILE).dvi $(DIFFFILE).bbl 
	dvipdfmx -o $@ $<

# bibはコピー
$(DIFFFILE).bib: $(TARGET).bib
	cp $< $@

# bib中間ファイル生成
$(DIFFFILE).bbl: $(DIFFFILE).tex $(DIFFFILE).bib
	$(TEX) $(DIFFTEXOPTION) $<; $(BIB) $(DIFFFILE); $(TEX) $(DIFFTEXOPTION) $<; $(TEX) $(DIFFTEXOPTION) $<

# dviファイル生成
$(DIFFFILE).dvi: $(DIFFFILE).tex $(DIFFFILE).bib
	$(TEX) $(DIFFTEXOPTION) $<; $(TEX) $(DIFFTEXOPTION) $<; $(TEX) $(DIFFTEXOPTION) $<;

# diff tex生成 (git)
$(DIFFFILE).tex: $(TARGET).tex *.tex
	latexdiff-vc --git -e utf8 -r $(REV) -t CFONT --flatten --force -d $(DIFFDIR) $(TARGET).tex

# 生成物の削除
clean:
	rm -rf diff out

.PHONE: all pdf ps clean diff
