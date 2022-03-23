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


```r
if (c(TRUE, FALSE)) {}
#> Warning in if (c(TRUE, FALSE)) {: the condition has length >
#> 1 and only the first element will be used
#> NULL
```


```r
if (NA) {}
#> Error in if (NA) {: missing value where TRUE/FALSE needed
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

#### switch


```r
calc_op <- function(x, y, op) {
  switch(op,
         plus = x + y,
         minus = x - y,
         times = x * y,
         divide = x / y,
         stop("Unknown op!")
  )
}
```


```r
calc_op(10, 20, "times")
#> [1] 200
```


```r
calc_op(10, 20, "divide")
#> [1] 0.5
```

#### cut


```r
describe_temp <- function(temp) {
  if (temp <= 0) {
    "freezing"
  } else if (temp <= 10) {
    "cold"
  } else if (temp <= 20) {
    "cool"
  } else if (temp <= 30) { 
    "warm"
  } else {
    "hot"
  }
}
```


```r
describe_temp(16)
#> [1] "cool"
```

Current function can't handle vectors


```r
describe_temp(c(16, 61))
#> Warning in if (temp <= 0) {: the condition has length > 1
#> and only the first element will be used
#> Warning in if (temp <= 10) {: the condition has length > 1
#> and only the first element will be used
#> Warning in if (temp <= 20) {: the condition has length > 1
#> and only the first element will be used
#> [1] "cool"
```

How cut works:


```r
values <- -10:10
values
#>  [1] -10  -9  -8  -7  -6  -5  -4  -3  -2  -1   0   1   2   3
#> [15]   4   5   6   7   8   9  10
```


```r
cut(values, c(-Inf, -5, -1, 1, 7, Inf))
#>  [1] (-Inf,-5] (-Inf,-5] (-Inf,-5] (-Inf,-5] (-Inf,-5]
#>  [6] (-Inf,-5] (-5,-1]   (-5,-1]   (-5,-1]   (-5,-1]  
#> [11] (-1,1]    (-1,1]    (1,7]     (1,7]     (1,7]    
#> [16] (1,7]     (1,7]     (1,7]     (7, Inf]  (7, Inf] 
#> [21] (7, Inf] 
#> Levels: (-Inf,-5] (-5,-1] (-1,1] (1,7] (7, Inf]
```


```r
cut(values, c(-Inf, -5, -1, 1, 7, Inf), labels = LETTERS[1:5], right = TRUE)
#>  [1] A A A A A A B B B B C C D D D D D D E E E
#> Levels: A B C D E
```


```r
cut(values, c(-Inf, -5, -1, 1, 7, Inf), labels = LETTERS[1:5], right = FALSE)
#>  [1] A A A A A B B B B C C D D D D D D E E E E
#> Levels: A B C D E
```

## Exercise

1. Rewrite the function using `cut`


```r
describe_temp <- function(temp) {
  if (temp <= 0) {
    "freezing"
  } else if (temp <= 10) {
    "cold"
  } else if (temp <= 20) {
    "cool"
  } else if (temp <= 30) {
    "warm"
  } else {
    "hot"
  }
}
```

2. How do you indicate `<` and `<=`?
