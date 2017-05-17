# Загрузка библиотек
source('linker.R')
Sys.setenv(TZ = 'MSK')
#
### исходные данные
# путь к обрабатываемому файлу 
file.path <- 'temp/2010-2013.csv'
# номера столбцов с переменными и профитом/просадкой
# var.list <- c(26, 27, 28)
# profit <- 3
# draw <- 9
# автоматический парсинг номеров нужных номеров столбцов
autoParse <- TRUE 
# параметры кластеризации
cluster_args <- list(method = 'clara',
    k.max = 30,
    only_profitable = TRUE,
    #iter.max = 1000,
    #nstart = 100,  
    #round_type = 'round',
    samples = 50,
    win_size = 4)
#### обработка .csv файла 
# (полный набор обработки - парсинг, исправление возможных ошибок 
  # и добавление нормированного к просадке и году доходу, вычисление квантиля по доходу) 
ifelse.fast(autoParse == TRUE,
    bf_data <- Parse_LabsCSV(file.path, autoParse = TRUE, sort = FALSE, var.names = TRUE, sep),
    bf_data <- Parse_LabsCSV(file.path, autoParse = TRUE, sort = FALSE, var.names = TRUE, sep, var.list, profit, draw))
#

cluster <- BruteForceOptimizer.cluster_analysis(bf_data, cluster_args)
# вывод данных
print(cluster$cluster.centers)
#
### графика
# визуализация вычисления оптимального числа кластеров
# PlotKmean_SS(ss.df = clustPar.data[1], n.opt = clustPar.data[[2]])
# # визуализация кластеров
#   # если cluster.color = FALSE  - точки красятся по профиту
#   # если cluster.color = TRUE - точки красятся по кластеру
# dim <- ifelse(n.vars == 3,
#               "3d",
#               ifelse(length(var.list) == 2,
#                      "2d",
#                      NA))
# if (is.na(dim)) {
#   stop(paste("PlotKmean_Clusters:  Dimension error!!!", sep = ""))
# } else {
#   PlotKmean_Clusters(data.list = clustFull.data, cluster.color = FALSE, dimension = dim, 
#                      plot.title = "ClustersPlot", xaxis.name = "FastMA", yaxis.name = "SlowMA", 
#                      zaxis.name = "PER", 
#                      point.size = 4, point.opacity = 1, point.line.width = 0.7, point.line.opacity = 0.5,
#                      center.size = 20, center.color = "black")
# }
#