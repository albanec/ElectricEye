#
### подгрузка пакетов
library(quantmod)
library(rusquant)
library(magrittr)
library(plotly)
#
### подгрузка библиотек
source("lib/Generic/libGeneric.R")
source("lib/Cluster/libCluster.R")
source("lib/LabsAnalysis/libLabsAnalysis.R")
#
### исходные данные
# путь к обрабатываемому файлу 
file.path <- "temp/test_data.csv"
# номера столбцов с переменными и профитом/просадкой
var.list <- c(26, 27, 28)
profit <- 3
draw <- 9
# автоматический парсинг номеров нужных номеров столбцов
autoParse <- TRUE 
# число месяцев торговли (зависит от оптимизации в tslab)
m <- 24
# квантиль доходности (по умолчанию выставлено наиболее оптимальное значение)
qLevel <- 0.5
# количество знаков после запятой (в значениях точек центров кластеров)
varDigits <- 0
# метод кластеризации (по умолчанию = FALSE (обычный kmean - показывает лучшие результаты в торговле, 
  # хоть и менее точен))
kmeanpp <- FALSE
#
#### обработка .csv файла 
# (полный набор обработки - парсинг, исправление возможных ошибок 
  # и добавление нормированного к просадке и году доходу, вычисление квантиля по доходу)
data <- AllPreparation_LabsFile(file.path = file.path, sep = ";", 
                                autoParse, 
                                m = m, 
                                q.hi = qLevel, hi = TRUE,
                                one.scale = TRUE)
data$profit <- NULL
data$draw <- NULL
#
### вычисление кластеров
# вычисление параметров кластеризации 
clustPar.data <- CalcKmean_Parameters(data, iter.max = 100, plusplus = kmeanpp, test.range = 30)
# вычисление самох кластеров
clustFull.data <- CalcKmean(data, clustPar.data[[2]], plusplus = kmeanpp, var.digits = varDigits)
# вывод данных
print(clustFull.data[2])
#
### графика
# визуализация вычисления оптимального числа кластеров
PlotKmean_SS(ss.df = clustPar.data[1], n.opt = clustPar.data[[2]])
# визуализация кластеров
  # если cluster.color = FALSE  - точки красятся по профиту
  # если cluster.color = TRUE - точки красятся по кластеру
dim <- ifelse(n.vars == 3,
              "3d",
              ifelse(length(var.list) == 2,
                     "2d",
                     NA))
if (is.na(dim)) {
  stop(paste("PlotKmean_Clusters:  Dimension error!!!", sep = ""))
} else {
  PlotKmean_Clusters(data.list = clustFull.data, cluster.color = FALSE, dimension = dim, 
                     plot.title = "ClustersPlot", xaxis.name = "FastMA", yaxis.name = "SlowMA", 
                     zaxis.name = "PER", 
                     point.size = 4, point.opacity = 1, point.line.width = 0.7, point.line.opacity = 0.5,
                     center.size = 20, center.color = "black")
}
 
#