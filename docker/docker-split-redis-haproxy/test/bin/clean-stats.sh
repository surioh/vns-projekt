#!/bin/bash

[ -e stats/usage.csv ] && rm stats/usage.csv && echo usage.csv deleted
[ -e plots/AuslastungCpu.png ] && rm plots/AuslastungCpu.png && echo AuslastungCpu.png deleted
[ -e plots/AuslastungMem.png ] && rm plots/AuslastungMem.png && echo AuslastungMem.png deleted
