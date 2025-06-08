set datafile separator ","
set terminal pngcairo enhanced font 'Verdana,10'
set output "plots/AuslastungCpu.png"

set title "CPU Nutzung während K6 Test"
set xlabel "Zeit in sekunden"

set ylabel "CPU Nutzung (%)" textcolor "red"
set ytics nomirror

set xtics rotate by -45
set key outside

plot "stats/usage.csv" using 1:3 with lines title "Tomcat1 CPU (%)" lc rgb "red" axis x1y1, \
     "stats/usage.csv" using 1:6 with lines title "Tomcat2 CPU (%)" lc rgb "red" axis x1y1, \
     "stats/usage.csv" using 1:9 with lines title "MariaDB CPU (%)" lc rgb "dark-red" axis x1y1,\
     "stats/usage.csv" using 1:12 with lines title "Redis CPU (%)" lc rgb "dark-red" axis x1y1,\
     "stats/usage.csv" using 1:15 with lines title "Haproxy CPU (%)" lc rgb "dark-red" axis x1y1,\

