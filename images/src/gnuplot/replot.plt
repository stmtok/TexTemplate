# 出力ファイル名
OUTPUT_FILENAME = "replot.eps"
WIDTH="8cm"
HEIGHT="4cm"
SAMPLES=5000

# epsで出力
set terminal postscript eps size WIDTH, HEIGHT color
set output "/dev/null"
set samples SAMPLES
set grid

# 関数定義
max(a, b) = a >= b ? a : b
min(a, b) = a <= b ? a : b

# 描画範囲
set xrange[-2 * pi:2 * pi]
set xtics ( "-2p" -2*pi, \
            "-p3/2" -pi*3/2, \
            "-p" -pi, \
            "-p/2" -pi/2, \
            "0" 0.0, \
            "p/2" pi/2, \
            "p" pi, \
            "p3/2" pi*3/2, \
            "2p" 2*pi \
        )
set yrange[-1.1: 1.1]

set xlabel "theta"
set ylabel "y"

plot sin(x) title "sin(x)"
replot cos(x) title "cos(x)"
replot tan(x) title "tan(x)"

# ファイル出力
set output OUTPUT_FILENAME
replot