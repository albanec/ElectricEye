# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# Linker для подключения библиотек
# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#
## Загрузка пакетов
library(quantmod)
library(rusquant)
library(magrittr)
library(foreach)
library(data.table)
library(dplyr)
#
## Загрузка библиотек
### GEN
source('lib/generic_mining.R')
source('lib/generic_data.R')
source('lib/generic.R')

### CLU
source('lib/cluster.R')

### LABS
source('lib/labs_analysis.R')

### OPT
source('lib/optimization.R')