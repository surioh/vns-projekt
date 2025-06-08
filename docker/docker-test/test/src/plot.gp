set datafile separator ","
set terminal pngcairo enhanced font 'Verdana,10'
set output "plots/usage.png"

set title "CPU & Memory Nutzung während K6 Test"
set xlabel "Zeit in sekunden"

set ylabel "CPU Nutzung (%)" textcolor "red"
set ytics nomirror

set y2label "Memory Nutzung (%)" textcolor "blue"
set y2tics

set xtics rotate by -45
set key outside

plot "stats/usage_log_tomcat.csv" using 1:3 with lines t "CPU (%)" lc rgb "red" axis x1y1, \
     "stats/usage_log_tomcat.csv" using 1:4 with lines t "Memory (MiB)" lc rgb "blue" axis x1y2
