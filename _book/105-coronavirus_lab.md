# Lab 3: `coronavirus` visualization, data wrangling, and dates

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
#> -30974748         0         0       471        35   1123456
```

1. Can you create a visual showing the cases over time for Russia, Spain, US, and Venezuela?
Also, why might `filter(cases >= 0)` be worth using? 

![](105-coronavirus_lab_files/figure-epub3/unnamed-chunk-3-1.png)<!-- -->

2. Can you show deaths over time for Russia, Spain, US, and Venezuela?  And can you play with your geoms and make something neat?

![](105-coronavirus_lab_files/figure-epub3/unnamed-chunk-4-1.png)<!-- -->

3. Now let's do a plot of COVID rate (# confirmed cases / population).  Something like this. 

![](105-coronavirus_lab_files/figure-epub3/unnamed-chunk-5-1.png)<!-- -->

4. What is and **is not** useful about the previous illustration?  

5. Make a chart with cumulative cases.  Something like this:

![](105-coronavirus_lab_files/figure-epub3/unnamed-chunk-6-1.png)<!-- -->

6.  With a little more time and a few extra packages, we **could** make a graph prettier.  Try.


```r
library(scales)
library(ggrepel)
library(glue)
library(lubridate)
```


![](105-coronavirus_lab_files/figure-epub3/unnamed-chunk-8-1.png)<!-- -->


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
#> 1    Russia 631
#> 2     Spain 629
#> 3        US 631
#> 4 Venezuela 630
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
#> 1    Russia 631
#> 2     Spain 631
#> 3        US 631
#> 4 Venezuela 631
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
#> 1    Russia 631
#> 2     Spain 631
#> 3        US 631
#> 4 Venezuela 631
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


![](105-coronavirus_lab_files/figure-epub3/unnamed-chunk-14-1.png)<!-- -->

```
#>       date              country              deaths      
#>  Min.   :2020-01-22   Length:2524        Min.   :   0.0  
#>  1st Qu.:2020-06-27   Class :character   1st Qu.:   4.0  
#>  Median :2020-12-02   Mode  :character   Median : 115.0  
#>  Mean   :2020-12-02                      Mean   : 407.9  
#>  3rd Qu.:2021-05-09                      3rd Qu.: 526.0  
#>  Max.   :2021-10-13                      Max.   :4460.0  
#>                                          NA's   :3       
#>    confirmed        cumulative_cases   cumulative_deaths
#>  Min.   :-74347.0   Min.   :       0   Min.   :     0   
#>  1st Qu.:   418.8   1st Qu.: 7742899   1st Qu.: 13566   
#>  Median :  6501.0   Median :12723106   Median : 72982   
#>  Mean   : 22897.5   Mean   :25127794   Mean   : 90759   
#>  3rd Qu.: 23351.0   3rd Qu.:57407255   3rd Qu.:163245   
#>  Max.   :303008.0   Max.   :57793207   Max.   :244190   
#>                                        NA's   :1769     
#>       rate          
#>  Min.   :-0.036576  
#>  1st Qu.: 0.006006  
#>  Median : 0.013469  
#>  Mean   : 0.023459  
#>  3rd Qu.: 0.024058  
#>  Max.   : 3.840391  
#>  NA's   :3
```

![](105-coronavirus_lab_files/figure-epub3/unnamed-chunk-14-2.png)<!-- -->

