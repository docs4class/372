


# Linear Regression

Your resource for this is ISLR chapter 3: linear regression.

## Exercises

1. Make sure you can define the terms below outbound, in your own words, so that they make sense both to you and to someone else (me?). Actually practice saying and defining these terms outloud until your answers make sense:

- least squares approach
- confidence interval
- p-value
- R^2^
- Adjusted R^2^
- qualitative predictor
- collinearity
- KNN
- Residual standard error
- F-statistic
- Explain the point o Fihure 3.1

2. In `m1`, below, which variables are significant predictors of Balance?  How do you know?


```r
library("ISLR")
data(Credit)
attach(Credit)
head(Credit)
#>   ID  Income Limit Rating Cards Age Education Gender
#> 1  1  14.891  3606    283     2  34        11   Male
#> 2  2 106.025  6645    483     3  82        15 Female
#> 3  3 104.593  7075    514     4  71        11   Male
#> 4  4 148.924  9504    681     3  36        11 Female
#> 5  5  55.882  4897    357     2  68        16   Male
#> 6  6  80.180  8047    569     4  77        10   Male
#>   Student Married Ethnicity Balance
#> 1      No     Yes Caucasian     333
#> 2     Yes     Yes     Asian     903
#> 3      No      No     Asian     580
#> 4      No      No     Asian     964
#> 5      No     Yes Caucasian     331
#> 6      No      No Caucasian    1151
m1 <- lm(Balance ~ Age + Income + Education, data = Credit)
summary(m1)
#> 
#> Call:
#> lm(formula = Balance ~ Age + Income + Education, data = Credit)
#> 
#> Residuals:
#>     Min      1Q  Median      3Q     Max 
#> -867.14 -343.14  -49.44  316.55 1080.56 
#> 
#> Coefficients:
#>             Estimate Std. Error t value Pr(>|t|)    
#> (Intercept) 348.8115   112.6895   3.095  0.00211 ** 
#> Age          -2.1863     1.2004  -1.821  0.06930 .  
#> Income        6.2380     0.5877  10.614  < 2e-16 ***
#> Education     0.8058     6.5254   0.123  0.90179    
#> ---
#> Signif. codes:  
#> 0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> Residual standard error: 407.2 on 396 degrees of freedom
#> Multiple R-squared:  0.2215,	Adjusted R-squared:  0.2156 
#> F-statistic: 37.56 on 3 and 396 DF,  p-value: < 2.2e-16
```

3. How "good" is the model created in `m1`?  How do you know?
4. Add more `Credit` variables to model `m1`.  Can you find two other variables that have extremely high collinearity?  What are they?  How do you know that they have high collinearity?  Why does this make sense given what each of the variables mean?
5. Based on the model below, what would you predict the balance to be for an individual who is 40, has an income of $100,000, 16 years of education, is Asian and not a student? 


```r
m2 <- lm(Balance ~ Age + Income + Education + Ethnicity + Student, data = Credit)
summary(m2)
#> 
#> Call:
#> lm(formula = Balance ~ Age + Income + Education + Ethnicity + 
#>     Student, data = Credit)
#> 
#> Residuals:
#>     Min      1Q  Median      3Q     Max 
#> -818.77 -322.14  -54.52  315.67  781.45 
#> 
#> Coefficients:
#>                    Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)        336.6241   115.6311   2.911  0.00381 ** 
#> Age                 -1.9756     1.1595  -1.704  0.08922 .  
#> Income               6.1491     0.5666  10.853  < 2e-16 ***
#> Education           -1.7606     6.3060  -0.279  0.78024    
#> EthnicityAsian     -14.2547    55.5240  -0.257  0.79752    
#> EthnicityCaucasian   8.8839    48.3276   0.184  0.85424    
#> StudentYes         382.0498    65.6854   5.816 1.25e-08 ***
#> ---
#> Signif. codes:  
#> 0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> Residual standard error: 392.2 on 393 degrees of freedom
#> Multiple R-squared:  0.2833,	Adjusted R-squared:  0.2723 
#> F-statistic: 25.89 on 6 and 393 DF,  p-value: < 2.2e-16
```

6. Interpret this model and its output, especially the coefficients `Income:Education   0.3149`:


```r
m3 <- lm(Balance ~ Income*Education, data = Credit)
summary(m3)
#> 
#> Call:
#> lm(formula = Balance ~ Income * Education, data = Credit)
#> 
#> Residuals:
#>     Min      1Q  Median      3Q     Max 
#> -858.07 -349.99  -56.12  304.51 1083.93 
#> 
#> Coefficients:
#>                  Estimate Std. Error t value Pr(>|t|)   
#> (Intercept)      435.4599   147.1000   2.960  0.00326 **
#> Income             1.8168     2.4727   0.735  0.46294   
#> Education        -13.9887    10.5931  -1.321  0.18741   
#> Income:Education   0.3149     0.1788   1.761  0.07902 . 
#> ---
#> Signif. codes:  
#> 0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> Residual standard error: 407.3 on 396 degrees of freedom
#> Multiple R-squared:  0.2211,	Adjusted R-squared:  0.2152 
#> F-statistic: 37.47 on 3 and 396 DF,  p-value: < 2.2e-16
```


