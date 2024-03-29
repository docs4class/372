# Lab 4: `coronavirus` visualization, data wrangling, and dates

The package is available on GitHub [here](https://github.com/RamiKrispin/coronavirus) and is updated daily.

> I use the `coronavirus` package and use the `coronavirus::update_data()` function to keep the data current.  This also has the dates preformatted which can be nice.


## Let's look like Applied Analytics Superstars and make some neat visuals.



```r
library(coronavirus)
library(dplyr)
library(ggplot2)
```

I'd recommend you always start by trying to understand a bit about the data.


```r
head(coronavirus)
#>         date province country     lat      long      type
#> 1 2020-01-22  Alberta  Canada 53.9333 -116.5765 confirmed
#> 2 2020-01-23  Alberta  Canada 53.9333 -116.5765 confirmed
#> 3 2020-01-24  Alberta  Canada 53.9333 -116.5765 confirmed
#> 4 2020-01-25  Alberta  Canada 53.9333 -116.5765 confirmed
#> 5 2020-01-26  Alberta  Canada 53.9333 -116.5765 confirmed
#> 6 2020-01-27  Alberta  Canada 53.9333 -116.5765 confirmed
#>   cases   uid iso2 iso3 code3    combined_key population
#> 1     0 12401   CA  CAN   124 Alberta, Canada    4413146
#> 2     0 12401   CA  CAN   124 Alberta, Canada    4413146
#> 3     0 12401   CA  CAN   124 Alberta, Canada    4413146
#> 4     0 12401   CA  CAN   124 Alberta, Canada    4413146
#> 5     0 12401   CA  CAN   124 Alberta, Canada    4413146
#> 6     0 12401   CA  CAN   124 Alberta, Canada    4413146
#>   continent_name continent_code
#> 1  North America             NA
#> 2  North America             NA
#> 3  North America             NA
#> 4  North America             NA
#> 5  North America             NA
#> 6  North America             NA
```

For example, what does this summary let us know?


```r
summary(coronavirus$cases)
#>      Min.   1st Qu.    Median      Mean   3rd Qu.      Max. 
#> -30974748         0         0       739        22   1383897
```

1. Can you create a visual showing the cases over time for Russia, Spain, US, and Venezuela?
Also, why might `filter(cases >= 0)` be worth using? 

![](105-coronavirus_lab_files/figure-latex/unnamed-chunk-3-1.pdf)<!-- --> 

2. Can you show deaths over time for Russia, Spain, US, and Venezuela?  And can you play with your geoms and make something neat?

![](105-coronavirus_lab_files/figure-latex/unnamed-chunk-4-1.pdf)<!-- --> 

3. Now let's do a plot of COVID rate (# confirmed cases / population).  Something like this. 

![](105-coronavirus_lab_files/figure-latex/unnamed-chunk-5-1.pdf)<!-- --> 

4. What is and **is not** useful about the previous illustration?  

5. Make a chart with cumulative cases.  Something like this:

![](105-coronavirus_lab_files/figure-latex/unnamed-chunk-6-1.pdf)<!-- --> 

6.  With a little more time and a few extra packages, we **could** make a graph prettier.  Try.


```r
library(scales)
library(ggrepel)
library(glue)
library(lubridate)
```


![](105-coronavirus_lab_files/figure-latex/unnamed-chunk-8-1.pdf)<!-- --> 


7. Now let's **really** have some fun.  Let's illustrate death rates relative to confirmed cases.  Why is this more challenging than anything we've done so far in this lab?  We're going to have to make this data **tidy**.  

One way to play this game.



Let's make a little table of just date, country, and deaths (with a meaningful variable name), and then count observations by coutry just to make sure eveything looks nice.


```
#>         date country deaths
#> 1 2020-01-22  Russia      0
#> 2 2020-01-23  Russia      0
#> 3 2020-01-24  Russia      0
#> 4 2020-01-25  Russia      0
#> 5 2020-01-26  Russia      0
#> 6 2020-01-27  Russia      0
#>     country   n
#> 1    Russia 884
#> 2     Spain 880
#> 3        US 883
#> 4 Venezuela 883
```

Let's make a little table of just confirmed cases.


```
#>         date country confirmed
#> 1 2020-01-22  Russia         0
#> 2 2020-01-23  Russia         0
#> 3 2020-01-24  Russia         0
#> 4 2020-01-25  Russia         0
#> 5 2020-01-26  Russia         0
#> 6 2020-01-27  Russia         0
#>     country   n
#> 1    Russia 884
#> 2     Spain 884
#> 3        US 884
#> 4 Venezuela 884
```

Let's join these together. I use `left_join`.  



```
#>         date country deaths confirmed
#> 1 2020-01-22  Russia      0         0
#> 2 2020-01-23  Russia      0         0
#> 3 2020-01-24  Russia      0         0
#> 4 2020-01-25  Russia      0         0
#> 5 2020-01-26  Russia      0         0
#> 6 2020-01-27  Russia      0         0
#>     country   n
#> 1    Russia 884
#> 2     Spain 884
#> 3        US 884
#> 4 Venezuela 884
```

Let's add some cumulative statistics as well.


```
#>         date country deaths confirmed cumulative_cases
#> 1 2020-01-22  Russia      0         0                0
#> 2 2020-01-23  Russia      0         0                0
#> 3 2020-01-24  Russia      0         0                0
#> 4 2020-01-25  Russia      0         0                0
#> 5 2020-01-26  Russia      0         0                0
#> 6 2020-01-27  Russia      0         0                0
#>   cumulative_deaths rate
#> 1                 0    0
#> 2                 0    0
#> 3                 0    0
#> 4                 0    0
#> 5                 0    0
#> 6                 0    0
```

Now we can plot some more fun stuff.


![](105-coronavirus_lab_files/figure-latex/unnamed-chunk-14-1.pdf)<!-- --> 

```
#>       date              country              deaths      
#>  Min.   :2020-01-22   Length:3536        Min.   :   0.0  
#>  1st Qu.:2020-08-29   Class :character   1st Qu.:   4.0  
#>  Median :2021-04-07   Mode  :character   Median : 115.0  
#>  Mean   :2021-04-07                      Mean   : 426.0  
#>  3rd Qu.:2021-11-14                      3rd Qu.: 575.5  
#>  Max.   :2022-06-23                      Max.   :4415.0  
#>                                          NA's   :6       
#>    confirmed         cumulative_cases    cumulative_deaths
#>  Min.   : -74347.0   Min.   :        0   Min.   :     0   
#>  1st Qu.:    388.8   1st Qu.: 18140893   1st Qu.: 20587   
#>  Median :   7469.0   Median : 30754528   Median :122606   
#>  Mean   :  33381.6   Mean   : 52262197   Mean   :168373   
#>  3rd Qu.:  29701.2   3rd Qu.:117512148   3rd Qu.:334969   
#>  Max.   :1383897.0   Max.   :118037488   Max.   :401762   
#>                                          NA's   :2528     
#>       rate          
#>  Min.   :-0.036576  
#>  1st Qu.: 0.003513  
#>  Median : 0.012243  
#>  Mean   : 0.020419  
#>  3rd Qu.: 0.021811  
#>  Max.   : 3.840391  
#>  NA's   :6
```

![](105-coronavirus_lab_files/figure-latex/unnamed-chunk-14-2.pdf)<!-- --> 

