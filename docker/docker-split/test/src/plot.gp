set datafile separator ","
set terminal pngcairo enhanced font 'Verdana,10'
set output "plots/Auslastung.png"

set title "CPU & Memory Nutzung während K6 Test"
set xlabel "Zeit in sekunden"

set ylabel "CPU Nutzung (%)" textcolor "red"
set ytics nomirror

set y2label "Memory Nutzung (%)" textcolor "blue"
set y2tics

set xtics rotate by -45
set key outside

plot "stats/usage.csv" using 1:3 with lines title "Tomcat CPU (%)" lc rgb "red" axis x1y1, \
     "stats/usage.csv" using 1:4 with lines title "Tomcat Memory (%)" lc rgb "blue" axis x1y2, \
     "stats/usage.csv" using 1:6 with lines title "MariaDB CPU (%)" lc rgb "dark-red" axis x1y1,\
     "stats/usage.csv" using 1:7 with lines title "MariaDB Memory (%)" lc rgb "dark-blue" axis x1y2

