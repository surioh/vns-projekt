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

plot "stats/usage.csv" using 1:3 with lines title "Tomcat1 CPU (%)" lc rgb "red" axis x1y1, \
     "stats/usage.csv" using 1:4 with lines title "Tomcat1 Memory (%)" lc rgb "blue" axis x1y2, \
     "stats/usage.csv" using 1:6 with lines title "Tomcat2 CPU (%)" lc rgb "red" axis x1y1, \
     "stats/usage.csv" using 1:7 with lines title "Tomcat2 Memory (%)" lc rgb "blue" axis x1y2, \
     "stats/usage.csv" using 1:9 with lines title "Tomcat3 CPU (%)" lc rgb "red" axis x1y1, \
     "stats/usage.csv" using 1:10 with lines title "Tomcat3 Memory (%)" lc rgb "blue" axis x1y2, \
     "stats/usage.csv" using 1:12 with lines title "Tomcat4 CPU (%)" lc rgb "red" axis x1y1, \
     "stats/usage.csv" using 1:13 with lines title "Tomcat4 Memory (%)" lc rgb "blue" axis x1y2, \
     "stats/usage.csv" using 1:15 with lines title "MariaDB1 CPU (%)" lc rgb "dark-red" axis x1y1,\
     "stats/usage.csv" using 1:16 with lines title "MariaDB1 Memory (%)" lc rgb "dark-blue" axis x1y2, \
     "stats/usage.csv" using 1:18 with lines title "MariaDB2 CPU (%)" lc rgb "dark-red" axis x1y1,\
     "stats/usage.csv" using 1:19 with lines title "MariaDB2 Memory (%)" lc rgb "dark-blue" axis x1y2, \
     "stats/usage.csv" using 1:21 with lines title "MariaDB3 CPU (%)" lc rgb "dark-red" axis x1y1,\
     "stats/usage.csv" using 1:22 with lines title "MariaDB3 Memory (%)" lc rgb "dark-blue" axis x1y2, \
     "stats/usage.csv" using 1:24 with lines title "Redis CPU (%)" lc rgb "dark-red" axis x1y1,\
     "stats/usage.csv" using 1:25 with lines title "Redis Memory (%)" lc rgb "dark-blue" axis x1y2, \
     "stats/usage.csv" using 1:27 with lines title "Haproxy CPU (%)" lc rgb "dark-red" axis x1y1,\
     "stats/usage.csv" using 1:28 with lines title "Haproxy Memory (%)" lc rgb "dark-blue" axis x1y2

