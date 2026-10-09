library(urca)
library(tsDyn)
library(tidyverse)
library(quantmod)
library(MSwM)



getSymbols(c("BWPUSD=X", "ZARUSD=X"), src ="yahoo", from = "2015-01-01",
           to = "2024-11-08")
bwpusd = Cl(`BWPUSD=X`)
zarusd = Cl(`ZARUSD=X`)

data = data.frame(bwpusd, zarusd)

data = na.omit(data)
head(data)

johansen_test = ca.jo(data, type = c("eigen","trace"), ecdet = c("none","const","trend"),
                      K= 2)
summary(johansen_test)

vecm_model = VECM(data,lag = 2, r=1)
summary(vecm_model)

resid_ts = ts(vecm_model$residuals)
print(head(resid_ts))
 resid(vecm_model)
 
 alpha <- coef(vecm_model)[, "ECT"]
 print("Adjustment Coefficients (Alpha):")
 print(alpha) 
 
 beta <- vecm_model$model.specific$beta
 print("Cointegration Vectors (Beta):")
 print(beta)
 
 gamma <- coef(vecm_model)[, grep("Close -1|Close -2", colnames(coef(vecm_model)))]
 print("Short-Term Dynamics (Gamma):")
 print(gamma)
 
 sigma <- vecm_model$residCov
 print("Residual Covariance Matrix (Sigma):")
 print(sigma)
 
 residuals <- residuals(vecm_model)
 sigma <- cov(residuals)
 print("Residual Covariance Matrix (Sigma):")
 print(sigma) 
 
 # Convert data to long format for ggplot2
 exchange_rates_long <- data %>%
   gather(key = "Currency", value = "ExchangeRate", BWPUSD.X.Close, ZARUSD.X.Close)
 
 exchange_rates_long$Date <- data$Date
 exchange_rates_long$Date <- as.Date(exchange_rates_long$Date)
 
 # Create the plot
 ggplot(exchange_rates_long$Da, aes(x = Date, y = ExchangeRate, color = Currency)) +
   geom_line() +  # Line plot for both currencies
   labs(
        x = "Date",
        y = "Exchange Rate",
        color = "Currency") +  # Legend title
   theme_minimal() +  # Minimalist theme
   theme(legend.position = "top",
         panel.grid.minor = element_blank())  # Place legend at the top
 
 mat_res = as.matrix(resid_ts)

msm_model = msmFit(mat_res,k=5)
summary (msm_model)