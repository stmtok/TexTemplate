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
REV=b4369276d35135f0dbdc1aeeb32d7d7ba25a7b21
# diff出力先ディレクトリ名
DIFFDIR=diff
# diff TEXオプション
DIFFTEXOPTION=--output-directory=$(DIFFDIR) -kanji=utf8 -interaction=nonstopmode
# diff出力ファイル
DIFFFILE=$(DIFFDIR)/$(TARGET)

.PHONE: all pdf
# DVI経由PDF出力
pdf: $(OUTFILE).pdf
all: images $(OUTFILE).pdf $(DIFFFILE).pdf

# 出力先ディレクトリ作成
$(OUTPUT):
	mkdir -p $(OUTPUT)

# DVI出力
$(OUTFILE).dvi: $(TARGET).tex *.tex $(OUTPUT)
	$(TEX) $(TEXOPTION) $<; $(TEX) $(TEXOPTION) $<; $(TEX) $(TEXOPTION) $<;

# Bib中間ファイル出力
$(OUTFILE).bbl: $(TARGET).tex $(TARGET).bib $(OUTPUT)
	$(TEX) $(TEXOPTION) $<; $(BIB) $(OUTFILE); $(TEX) $(TEXOPTION) $<; $(TEX) $(TEXOPTION) $<

# DVIファイルからPDF出力
$(OUTFILE).pdf: $(OUTFILE).dvi $(OUTFILE).bbl $(OUTPUT)
	dvipdfmx -o $@ $<

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
.PHONY: diff
diff: $(DIFFFILE).pdf

$(DIFFFILE).tex: $(TARGET).tex *.tex
	latexdiff-vc --git -e utf8 -r $(REV) -t CFONT --flatten --force -d $(DIFFDIR) $(TARGET).tex

.PHONY: images
images:
	$(MAKE) -C images/src

# 生成物の削除
.PHONY: clean
clean:
	$(MAKE) -C images/src clean
	rm -rf diff out
