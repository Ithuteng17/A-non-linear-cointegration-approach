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

#Preliminary Analysis

# Plot of the BWP/USD and ZAR/USD exchange rates
plot(BWPclean, type ="l", col ="blue", main = "BWP/USD and ZAR/USD exchange rates",
     ylab = "Exchange rate", xlab = "Date")
lines(ZARclean, col = "red")
grid()

# legend with colored lines
legend("topright", legend = c("BWP/USD","ZAR/USD"), col = c("blue","red"), lty = 1, bty ="n")



##Tests for Normality
#1.skewness and kurtosis
#BWP/USD
skewness(BWPclean)
kurtosis(BWPclean)
#ZAR/USD
skewness(ZARclean)
kurtosis(ZARclean)
#2.Jarque-Bera Test
#BWP/USD
jarque.bera.test(BWPclean)
#ZAR/USD
jarque.bera.test(ZARclean)
#3.Anderson-Darling test
#BWP/USD
ad.test(BWPclean)
#ZAR/USD
ad.test(ZARclean)

##Tests for highly correlated returns
#1. Kendall's tau
Kend_t = cor(BWPclean,ZARclean, method = "kendall")
cat("Kendall's Tau:", Kend_t,"\n")
#2. Spearman's rank correlation coefficient
Spear_rho = cor(BWPclean,ZARclean, method = "spearman")
cat("Spearman's rho:", Spear_rho,"\n")
#3. Johaneson's cointegration test
JC = ca.jo(cbind(BWPclean,ZARclean), type = c("eigen","trace"), ecdet = c("none","const","trend")
           , K =2)
summary(JC)

##Non linear and Non linear Unit root tests
#Non linear tests
#1.White's neural network
# comparing to a linear model
lm_mod = lm(BWPclean ~ ZARclean)
summary(lm_mod)
lm_res = residuals(lm_mod)
head(lm_res)
res_squared = lm_res^2
ZARc_sq = ZARclean^2
#White's neural network test for non linearity
white_test_res = lm(res_squared ~ ZARclean + I(ZARc_sq))
#summary of White's neural network test
summary(white_test_res)

#2.Lagrange multiplier test
lm_ex = lm(BWPclean ~ ZARclean + I(ZARc_sq))
lagrange_test = anova(lm_mod,lm_ex)
print(lagrange_test)

##Non linear unit root tests
#1. KSS test
KSS_result = KSS_Unit_Root(cbind(BWPclean,ZARclean), lags = 2, case = "level",
                           lsm ="ols")
print(KSS_result)
#2.Perron's non linear unit root test
#differencing
BWPdiff= diff(BWPclean)[-1]
ZARdiff = diff(ZARclean)[-1]
#Perron test
BWPPerron_test = pp.test(BWPdiff)
ZARPerron_test =pp.test(ZARdiff)

#3 MS-ADF test
BWPZAR = cbind(BWPclean,ZARclean)
BWPZAR_ts = ts(BWPZAR)
#lagselect
lagselect = VARselect(BWPZAR, lag.max = 3, type =c("const", "trend", "both", "none") )
lagselect$selection
lagselect$criteria


##MS-VECM
#building VECM model
vecmod = VECM(BWPZAR, 2, r = 1, estim = c("ML"))
res_vecm = residuals(vecmod)
ts_res = ts(res_vecm)

ts_res <- xts(res_vecm, order.by = index(BWPZAR))  
