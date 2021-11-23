# 出力ファイル名
OUTPUT_FILE = ARG0.".eps"
if (exists("ARG1")) OUTPUT_FILE = ARG1

WIDTH="8cm"
HEIGHT="3cm"
SAMPLES=5000

# epsで出力
set terminal postscript eps size WIDTH, HEIGHT color
set output "/dev/null"
set samples SAMPLES
set grid

# 関数定義
max(a, b) = a >= b ? a : b

# 描画範囲
set xrange[-pi:pi]
set xtics ( "-p" -pi, \
            "-p/2" -pi/2, \
            "0" 0.0, \
            "p/2" pi/2, \
            "p" pi \
        )
set yrange[-0.1: 1.1]

set xlabel "theta"
set ylabel "y"

plot max(sin(x), 0) title "sin(x) > 0"

# ファイル出力
set output OUTPUT_FILE
replot