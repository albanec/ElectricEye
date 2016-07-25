#
## подгрузка пакетов
library(quantmod)
library(rusquant)
library(magrittr)
library(plotly)
#
## подгрузка библиотек
source("lib/libGeneric.R")
source("lib/libCluster.R")
source("lib/libLabsAnalysis.R")
#
## исходные данные
# путь к обрабатываемому файлу
file.path <- "test_data.csv"
# столбцы с переменными 
var.list <- c(26, 27, 28)
# число месяцев торговли
m <- 12
# квантиль доходности
qLevel <- 0.6
# количество знаков после запятой (в значениях точек центров кластеров)
varDigits <- 3
# метод кластеризации (по умолчанию = FALSE (обычный kmean))
kmeanpp <- FALSE
#
## обработка .csv файла 
# (полный набор обработки - парсинг, исправление возможных ошибок 
  # и добавление нормированного к просадке и году доходу, вычисление квантиля по доходу)
data <- AllPreparation_LabsFile(file.path = file.path, 
                                var.list = var.list, profit = 3, draw = 9, 
                                m = m, 
                                q.hi = qLevel, hi = TRUE)
data$profit <- NULL
data$draw <- NULL
#
## вычисление кластеров
# вычисление параметров кластеризации 
clustPar.data <- CalcKmean_Parameters(data, iter.max = 100, plusplus = FALSE, test.range = 30)
# вычисление самох кластеров
clustFull.data <- CalcKmean(data, clustPar.data[[2]], plusplus = kmeanpp, var.digits = varDigits)
# вывод данных
clustFull.data[2]
#
## графика
# визуализация вычисления оптимального числа кластеров
PlotKmean_SS(ss.df = clustPar.data[1], n.opt = clustPar.data[[2]])
# визуализация кластеров
PlotKmean_Clusters(data.list=clustFull.data, cluster.color = FALSE, dimension = "3d", 
                   plot.title = "ClustersPlot", xaxis.name = "FastMA", yaxis.name = "SlowMA", 
                   zaxis.name = "PER", 
                   point.size = 4, point.opacity = 1, point.line.width = 0.7, point.line.opacity = 0.5,
                   center.size = 20, center.color = "black") 
#