# Functions

## Writing Functions

###  Fahrenheit to Kelvin

$k = ((f - 32) * (5 / 9)) + 273.15$


```r
((32 - 32) * (5 / 9)) + 273.15
#> [1] 273.15
((212 - 32) * (5 / 9)) + 273.15
#> [1] 373.15
((-42 - 32) * (5 / 9)) + 273.15
#> [1] 232.0389
```


```r
f_k <- function(f_temp) {
    ((f_temp - 32) * (5 / 9)) + 273.15
}
```


```r
f_k(32)
#> [1] 273.15
f_k(212)
#> [1] 373.15
f_k(-42)
#> [1] 232.0389
```

### Kelvin to Celsius


```r
k_c <- function(temp_k) {
    temp_c <- temp_k - 273.15
    return(temp_c)
}
```


```r
k_c(0)
#> [1] -273.15
```

### Fahrenheit to Celsius


```r
f_c <- function(temp_f) {
    temp_k <- f_k(temp_f)
    temp_c <- k_c(temp_k)
    return(temp_c)
}
```


```r
f_c(32)
#> [1] 0
f_c(212)
#> [1] 100
```

## Testing Functions


```r
library(testthat)
testthat::expect_equal(f_c(32), 0)
testthat::expect_equal(f_c(212), 100)
```

## Exercise

1. What happens if you use `NA`, `Inf`, `-Inf` in your function?
2. What are some better names to give the functions we wrote?
  - How would you name these functions in a package?


## Checking values

Calculating weighted means


```r
mean_wt <- function(x, w) {
  sum(x * w) / sum(w)
}
```


```r
mean_wt(1:6, 1:6)
#> [1] 4.333333
```

If you expect the lengths to be the same,
then you should test for it in the function


```r
mean_wt(1:6, 1:3)
#> [1] 7.666667
```


```r
mean_wt <- function(x, w) {
  if (length(x) != length(w)) {
    stop("`x` and `w` should be the same length")
  }
  sum(x * w) / sum(w)
}
```


```r
mean_wt(1:6, 1:3)
#> Error in mean_wt(1:6, 1:3): `x` and `w` should be the same length
```

## dot-dot-dot ...

Use it to pass on arguments to another function inside.

But you can also use it to force named arguments in your function.


```r
sum_3 <- function(x, y, z) {
  return(x + y + z)
}
```


```r
sum_3(1, 2, 3)
#> [1] 6
```


```r
sum_3 <- function(x, y, ..., z) {
  return(x + y + z)
}
```


```r
sum_3(1, 2, z = 3)
#> [1] 6
```


```r
sum_3(1, 2, z = 3)
#> [1] 6
```

# Conditionals

## if statements


```r
# make a modification to this function
k_c <- function(temp_k) {
    if (temp_k < 0) {
        warning('you passed in a negative Kelvin number')
        # stop()
        return(NA)
    }
    temp_c <- temp_k - 273.15
    return(temp_c)
}
```


```r
k_c(-9)
#> Warning in k_c(-9): you passed in a negative Kelvin number
#> [1] NA
```

Our current function does not deal with missing numbers

```r
k_c(NA)
```

```
Error in if (temp_k < 0) { : missing value where TRUE/FALSE needed
```


```r
k_c(0)
#> [1] -273.15
```


## If else statements


```r
k_c <- function(temp_k) {
    if (temp_k < 0) {
        warning('you passed in a negative Kelvin number')
        # stop()
        return(NA)
    } else {
        temp_c <- temp_k - 273.15
        return(temp_c)
    }
}
```


```r
k_c(-9)
#> Warning in k_c(-9): you passed in a negative Kelvin number
#> [1] NA
```

Our current function does not deal with missing numbers

```r
k_c(NA)
```


```r
k_c(0)
#> [1] -273.15
```

## Dealing with NA

Re-write our function to work with missing values.

Note you need to make the `NA` check first.


```r
k_c <- function(temp_k) {
    if (is.na(temp_k)) {
        return(NA)
    } else if (temp_k < 0) {
        warning('you passed in a negative Kelvin number')
        # stop()
        return(NA)
    } else {
        temp_c <- temp_k - 273.15
        return(temp_c)
    }
}
```


```r
k_c(-9)
#> Warning in k_c(-9): you passed in a negative Kelvin number
#> [1] NA
```


```r
k_c(NA)
#> [1] NA
```


```r
k_c(0)
#> [1] -273.15
```

use `&&` and `||` to short-circuit the boolean comparisons.
This will also guarantee a value of length `1L`.
`==` is also vectorized, should use `identical()` or `all.equal()`.

`identical` is very strict. Doesn't corece types.


```r
identical(0L, 0)
#> [1] FALSE
```

`all.equal` has ability to set tolerances.

`all.equal`: compare R objects x and y testing ‘near equality’. If they are different, comparison is still made to some extent, and a report of the differences is returned. Do not use all.equal directly in if expressions—either use isTRUE(all.equal(....)) or identical if appropriate.


```r
all.equal(0L, 0)
#> [1] TRUE
```


```r
if (isTRUE(all.equal(0L, 0))) {print("Hello")}
#> [1] "Hello"
```

## Fizzbuzz


```r
fizzbuzz <- function(x) {
  # these two lines check that x is a valid input
  stopifnot(length(x) == 1)
  stopifnot(is.numeric(x))
  if (!(x %% 3) && !(x %% 5)) {
    "fizzbuzz"
  } else if (!(x %% 3)) {
    "fizz"
  } else if (!(x %% 5)) {
    "buzz"
  } else {
    # ensure that the function returns a character vector
    as.character(x)
  }
}
```



```r
fizzbuzz(6)
#> [1] "fizz"
```

Check modulo 3 only once


```r
fizzbuzz2 <- function(x) {
  # these two lines check that x is a valid input
  stopifnot(length(x) == 1)
  stopifnot(is.numeric(x))
  if (!(x %% 3)) {
    if (!(x %% 5)) {
      "fizzbuzz"
    } else {
      "fizz"
    }
  } else if (!(x %% 5)) {
    "buzz"
  } else {
    # ensure that the function returns a character vector
    as.character(x)
  }
}
```


```r
fizzbuzz(6)
#> [1] "fizz"
```

### Vectorized conditionals



```r
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following object is masked from 'package:testthat':
#> 
#>     matches
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
fizzbuzz_vec <- function(x) {
  dplyr::case_when(
    !(x %% 3) & !(x %% 5) ~ "fizzbuzz",
    !(x %% 3) ~ "fizz",
    !(x %% 5) ~ "buzz",
    TRUE ~ as.character(x)
  )
}
```


```r
fizzbuzz(1:10)
#> Error in fizzbuzz(1:10): length(x) == 1 is not TRUE
```


```r
fizzbuzz_vec(1:10)
#>  [1] "1"    "2"    "fizz" "4"    "buzz" "fizz" "7"    "8"   
#>  [9] "fizz" "buzz"
```


### Multiple conditions

```r
if (this) {
  # do that
} else if (that) {
  # do something else
} else {
  # 
}
```

