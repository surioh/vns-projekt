set datafile separator ","
set terminal pngcairo enhanced font 'Verdana,10'
set output "plots/AuslastungMem.png"

set title "Memory Nutzung während K6 Test"
set xlabel "Zeit in sekunden"

set ylabel "Memory Nutzung (%)" textcolor "blue"
set ytics

set xtics rotate by -45
set key outside

plot "stats/usage.csv" using 1:4 with lines title "Tomcat1 Memory (%)" lc rgb "blue" axis x1y1, \
     "stats/usage.csv" using 1:7 with lines title "Tomcat2 Memory (%)" lc rgb "blue" axis x1y1, \
     "stats/usage.csv" using 1:10 with lines title "MariaDB Memory (%)" lc rgb "dark-blue" axis x1y1, \
     "stats/usage.csv" using 1:13 with lines title "Redis Memory (%)" lc rgb "dark-blue" axis x1y1, \
     "stats/usage.csv" using 1:16 with lines title "Haproxy Memory (%)" lc rgb "dark-blue" axis x1y1

