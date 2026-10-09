#retrieving packages
packages = c("readxl","rugarch","forecast","tseries", "dynlm",
             "vars", "nlWaldTest","lmtest","broom","car",
             "QRM", "FinTS","nonlinearTseries","systemfit","AER",
             "xtable","dplyr","lattice","moments","strucchange","ggplot2",
             "PerformanceAnalytics","nortsTest", "bayesGARCH",
             "dLagM","xts","quantmod","kableExtra","DescTools","zoo",
             "gridExtra","grid","latex2exp","fGarch","BETS","ggpubr")
#downloading and installing packages
libraries = function(packages){
  for (package in packages){
    if(!require(package,character.only = TRUE)){
      install.packages(package,dependencies = TRUE)
      library(package,character.only = TRUE)
    }
  }
}
libraries(packages)

#BWPUSD=X yahoo finance
getSymbols("BWPUSD=X", src = "yahoo", from ="2015-01-01", to = "2024-11-14")
head(`BWPUSD=X`)
BWPclose = Cl(`BWPUSD=X`)
BWPclean = na.approx(BWPclose)
#ZARUSD=X yahoo finance
getSymbols("ZARUSD=X", src = "yahoo", from ="2015-01-01", to = "2024-11-14")
head(`ZARUSD=X`) 
ZARClose = Cl(`ZARUSD=X`)
ZARclean = na.approx(ZARClose)

BWP=as.numeric(BWPclean)
ZAR = as.numeric(ZARclean)


wht1 = white.test(x = BWP,y= ZAR, type = "F")
wht2 = white.test(x = ZAR,y=BWP, type ="F")





