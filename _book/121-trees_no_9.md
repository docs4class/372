# Trees #9 The OJ Dataset

This problem involves the OJ data set which is part of the ISLR package.


```
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
```



```r
dplyr::glimpse(OJ)
#> Rows: 1,070
#> Columns: 18
#> $ Purchase       <fct> CH, CH, CH, MM, CH, CH, CH, CH, CH,…
#> $ WeekofPurchase <dbl> 237, 239, 245, 227, 228, 230, 232, …
#> $ StoreID        <dbl> 1, 1, 1, 1, 7, 7, 7, 7, 7, 7, 7, 7,…
#> $ PriceCH        <dbl> 1.75, 1.75, 1.86, 1.69, 1.69, 1.69,…
#> $ PriceMM        <dbl> 1.99, 1.99, 2.09, 1.69, 1.69, 1.99,…
#> $ DiscCH         <dbl> 0.00, 0.00, 0.17, 0.00, 0.00, 0.00,…
#> $ DiscMM         <dbl> 0.00, 0.30, 0.00, 0.00, 0.00, 0.00,…
#> $ SpecialCH      <dbl> 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0,…
#> $ SpecialMM      <dbl> 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0,…
#> $ LoyalCH        <dbl> 0.500000, 0.600000, 0.680000, 0.400…
#> $ SalePriceMM    <dbl> 1.99, 1.69, 2.09, 1.69, 1.69, 1.99,…
#> $ SalePriceCH    <dbl> 1.75, 1.75, 1.69, 1.69, 1.69, 1.69,…
#> $ PriceDiff      <dbl> 0.24, -0.06, 0.40, 0.00, 0.00, 0.30…
#> $ Store7         <fct> No, No, No, No, Yes, Yes, Yes, Yes,…
#> $ PctDiscMM      <dbl> 0.000000, 0.150754, 0.000000, 0.000…
#> $ PctDiscCH      <dbl> 0.000000, 0.000000, 0.091398, 0.000…
#> $ ListPriceDiff  <dbl> 0.24, 0.24, 0.23, 0.00, 0.00, 0.30,…
#> $ STORE          <dbl> 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0,…
```

(a) train/test Split

Q: Create a training set containing a random sample of 800 observations, and a test set containing the remaining observations.

A: Since this is my first time seeing this dataset, here is my quick overview: The OJ dataset contains 1,070 purchases of two brands of orange juice (‘Citrus Hill’ or ‘Minute Maid’), captured in the values of the Purchase variable (CH or MM). The remaining 17 predictors are characteristics of the customer, product, store, etc. Throughout this question we are basically tasked with predicting which orange juice the customer purchased based on these statistics.

I create train and test below.


```r
set.seed(5)
train_index <- sample(1:nrow(OJ), 800)
train <- OJ[train_index, ]
test <- OJ[-train_index, ]
```
 


(b) Classification Tree

Q: Fit a tree to the training data, with Purchase as the response and the other variables as predictors. Use the summary() function to produce summary statistics about the tree, and describe the results obtained. What is the training error rate? How many terminal nodes does the tree have?

A: The classification tree has 7 terminal nodes and a training error rate of 18.38%.


```r
tree_model <- tree(Purchase ~ ., train)
summary(tree_model)
#> 
#> Classification tree:
#> tree(formula = Purchase ~ ., data = train)
#> Variables actually used in tree construction:
#> [1] "LoyalCH"       "PriceDiff"     "ListPriceDiff"
#> Number of terminal nodes:  9 
#> Residual mean deviance:  0.7347 = 581.1 / 791 
#> Misclassification error rate: 0.1662 = 133 / 800
```

Despite there being 17 predictors in the dataset, only three were used in splits. These were:

    LoyalCH - Customer brand loyalty for CH
    PriceDiff - Sale price of MM less sale price of CH
    DiscCH - Discount offered for CH


(c) tree() - Text Interpretation

Q: Type in the name of the tree object in order to get a detailed text output. Pick one of the terminal nodes, and interpret the information displayed.

A: I print the text output below.


```r
tree_model
#> node), split, n, deviance, yval, (yprob)
#>       * denotes terminal node
#> 
#>  1) root 800 1068.00 CH ( 0.61250 0.38750 )  
#>    2) LoyalCH < 0.5036 346  412.40 MM ( 0.28324 0.71676 )  
#>      4) LoyalCH < 0.280875 164  125.50 MM ( 0.12805 0.87195 )  
#>        8) LoyalCH < 0.0356415 56   10.03 MM ( 0.01786 0.98214 ) *
#>        9) LoyalCH > 0.0356415 108  103.50 MM ( 0.18519 0.81481 ) *
#>      5) LoyalCH > 0.280875 182  248.00 MM ( 0.42308 0.57692 )  
#>       10) PriceDiff < 0.05 71   67.60 MM ( 0.18310 0.81690 ) *
#>       11) PriceDiff > 0.05 111  151.30 CH ( 0.57658 0.42342 ) *
#>    3) LoyalCH > 0.5036 454  362.00 CH ( 0.86344 0.13656 )  
#>      6) PriceDiff < -0.39 31   40.32 MM ( 0.35484 0.64516 )  
#>       12) LoyalCH < 0.638841 10    0.00 MM ( 0.00000 1.00000 ) *
#>       13) LoyalCH > 0.638841 21   29.06 CH ( 0.52381 0.47619 ) *
#>      7) PriceDiff > -0.39 423  273.70 CH ( 0.90071 0.09929 )  
#>       14) LoyalCH < 0.705326 135  143.00 CH ( 0.77778 0.22222 )  
#>         28) ListPriceDiff < 0.255 67   89.49 CH ( 0.61194 0.38806 ) *
#>         29) ListPriceDiff > 0.255 68   30.43 CH ( 0.94118 0.05882 ) *
#>       15) LoyalCH > 0.705326 288   99.77 CH ( 0.95833 0.04167 ) *
```


Choosing node 11), which is a terminal node as it is marked by a *:

First the root node: 1) root 800 1064.00 CH ( 0.61750 0.38250 )

This means that, at the root node, there are 800 observations, the deviance is 1064.00, the overall prediction is CH and the split is 61.75% CH vs 38.25% MM.

We can see that, from the root node, three splits take place to produce the terminal node labelled by 11):

    A split at LoyalCH = 0.5036
    A split at LoyalCH = 0.142213
    A split at PriceDiff = 0.235

     1) root 800 1064.00 CH ( 0.61750 0.38250 )  
       2) LoyalCH < 0.5036 354  435.50 MM ( 0.30508 0.69492 )  
         4) LoyalCH < 0.142213 100   45.39 MM ( 0.06000 0.94000 ) *
         5) LoyalCH > 0.142213 254  342.20 MM ( 0.40157 0.59843 )  
          10) PriceDiff < 0.235 136  153.00 MM ( 0.25000 0.75000 ) *
          11) PriceDiff > 0.235 118  160.80 CH ( 0.57627 0.42373 ) *

Node 11) is therefore the subset of purchases where 0.142213 < LoyalCH < 0.5036 and PriceDiff > 0.235. The overall prediction is CH, and the node seems quite impure with 57.627% CH vs 42.373% MM.

There are 118 observations in the node, and from the percentages above we know that 68/118 are CH and 50/118 are MM (demonstrated below).


```r
train %>%
  filter(LoyalCH < 0.5036, 
         LoyalCH > 0.142213, 
         PriceDiff > 0.235) %>%
  select(Purchase) %>% 
  table()
#> Purchase
#> CH MM 
#> 57 54
```


Based on the formula on page 325 for the overall deviance of a classification tree $$ (−2∑m∑knmklog(p^mk))$$  where the overall deviance sum is over m regions (terminal nodes). We calculate can the deviance of node 11) only using the code below:


```r
-2 * (68 * log(68/118) + 50 * log(50/118))
#> [1] 160.8262
```


tree() reports the number as 160.80, and testing with other nodes revealed this is because it’s rounding the result to 4 significant figures.


(d) Plotting

Q: Create a plot of the tree, and interpret the results.

A: 
LoyalCH is certainly the most important variable (the top 3 nodes all split on this variable), followed by PriceDiff and DiscCH. We can see node 11) is the third terminal node (from left → right).

LoyalCH ranges from 0 to 1, so the first split sends those less loyal to Citrus Hill (CH) orange juice to the left and those more loyal to the right:

plot(tree_model)
text(tree_model, pretty = 0, cex = 0.7)

Those that scored lowest in Citrus Hill loyalty (LoyalCH < 0.142213) were predicted to buy Minute Maid (MM), which isn’t surprising. Those that were slightly more loyal to CH (0.142213 < LoyalCH < 0.5036) would still buy MM if it wasn’t too much more expensive (PriceDiff < 0.235), but if the price difference is large enough (CH was much cheaper) they could end up purchasing CH.

Those on the far-right terminal node are the most loyal to CH (LoyalCH > 0.705699), so it should be unsurprising that this is their predicted purchase. Those with slightly lower brand loyalty (0.5036 < LoyalCH < 0.705699) would still purchase CH if it was much cheaper (PriceDiff > 0.25), or if it wasn’t but was sufficiently discounted (PriceDiff < 0.25 & DiscCH > 0.15). For those cases where CH wasn’t much cheaper (PriceDiff < 0.25) and wasn’t sufficiently discounted (DiscCH < 0.15), the predicted purchase actually ended up being MM.

This was a much more detailed explanation, but this could be summarized at a much higher level in the following way: people go with the brand they are more loyal towards, but there are some edge cases (based on discounts and the prices relative to one another) that can sway people against their usual brand loyalties.


(e) Test Error

Q: Predict the response on the test data, and produce a confusion matrix comparing the test labels to the predicted test labels. What is the test error rate?

A:

Here is the confusion matrix for the unpruned regression tree:


```r
test_pred <- predict(tree_model, test, type = "class")
table(test_pred, test_actual = test$Purchase)
#>          test_actual
#> test_pred  CH  MM
#>        CH 148  32
#>        MM  15  75
```




##          test_actual
## test_pred  CH  MM
##        CH 125  32
##        MM  34  79

The test error rate corresponding to it:

1 - mean(test_pred == test$Purchase)

## [1] 0.2444444

CH was the most common orange juice in train so, for comparison, a baseline classifier (that predicted CH for all observations in test) would have the following error rate:

1 - mean(test$Purchase == "CH")

## [1] 0.4111111


(f) Cost-Complexity Pruning

Q: Apply the cv.tree() function to the training set in order to determine the optimal tree size.

A:

Since our goal appears to be low test error, I specify FUN = prune.misclass. This indicates that we want the classification error rate to guide the cross-validation and pruning process, rather than the default for the cv.tree() function, which is deviance.


```r
set.seed(2)
cv_tree_model <- cv.tree(tree_model, K = 10, FUN = prune.misclass)
cv_tree_model
#> $size
#> [1] 9 6 5 3 2 1
#> 
#> $dev
#> [1] 149 149 149 173 172 310
#> 
#> $k
#> [1]  -Inf   0.0   1.0   8.5   9.0 150.0
#> 
#> $method
#> [1] "misclass"
#> 
#> attr(,"class")
#> [1] "prune"         "tree.sequence"
```


(g) CV Error Plot

Q: Produce a plot with tree size on the x-axis and cross-validated classification error rate on the y-axis.

A:

The plot is below. Note that cv_tree_model$size is the number of terminal nodes (so 1 means it is just the root node with no splits), and cv_tree_model$dev gives the total number of errors made from the out-of-fold predictions during cross-validation (only because we specified FUN = prune.misclass - omitting this would mean this reports the deviance). From this we can obtain the cross-validation error rate.


```r
data.frame(size = cv_tree_model$size, CV_Error = cv_tree_model$dev / nrow(train)) %>%
  mutate(min_CV_Error = as.numeric(min(CV_Error) == CV_Error)) %>%
  ggplot(aes(x = size, y = CV_Error)) +
  geom_line(col = "grey55") +
  geom_point(size = 2, aes(col = factor(min_CV_Error))) +
  scale_x_continuous(breaks = seq(1, 7), minor_breaks = NULL) +
  scale_y_continuous(labels = scales::percent_format()) +
  scale_color_manual(values = c("deepskyblue3", "green")) +
  theme(legend.position = "none") +
  labs(title = "OJ Dataset - Classification Tree",
       subtitle = "Selecting tree 'size' (# of terminal nodes) using cross-validation",
       x = "Tree Size",
       y = "CV Error")
```

![](121-trees_no_9_files/figure-epub3/unnamed-chunk-10-1.png)<!-- -->

(h) Best Tree - CV Error

Q: Which tree size corresponds to the lowest cross-validated classification error rate?

A:

Of the sequence of trees generated, trees of sizes 4 and 7 have the same cross-validation error. It makes sense to select the more parsimonious model here with 4 terminal nodes.


(i) Best Tree - Selecting

Q: Produce a pruned tree corresponding to the optimal tree size obtained using cross-validation. If cross-validation does not lead to selection of a pruned tree, then create a pruned tree with five terminal nodes.

A:

I produce the tree with 4 terminal nodes. Interestingly we have the same cross-validation error as the full tree with 7 terminal nodes, but have only split on LoyalCH to achieve this. This would have the added benefit of simplifying the interpretation in part (d).


```r
pruned_tree_model <- prune.tree(tree_model, best = 4)
pruned_tree_model
#> node), split, n, deviance, yval, (yprob)
#>       * denotes terminal node
#> 
#> 1) root 800 1068.00 CH ( 0.61250 0.38750 )  
#>   2) LoyalCH < 0.5036 346  412.40 MM ( 0.28324 0.71676 )  
#>     4) LoyalCH < 0.280875 164  125.50 MM ( 0.12805 0.87195 ) *
#>     5) LoyalCH > 0.280875 182  248.00 MM ( 0.42308 0.57692 ) *
#>   3) LoyalCH > 0.5036 454  362.00 CH ( 0.86344 0.13656 )  
#>     6) PriceDiff < -0.39 31   40.32 MM ( 0.35484 0.64516 ) *
#>     7) PriceDiff > -0.39 423  273.70 CH ( 0.90071 0.09929 ) *
```



(j) Training Error Comparison

Q: Compare the training error rates between the pruned and unpruned trees. Which is higher?

A: 
Here is the training error for the unpruned tree (7 terminal nodes):


```r
mean(predict(tree_model, type = "class") != train$Purchase)
#> [1] 0.16625
```



The same for the pruned tree (4 terminal nodes):


```r
mean(predict(pruned_tree_model, type = "class") != train$Purchase)
#> [1] 0.18875
```


The training error for the pruned tree is higher. This isn’t surprising - we would expect the training error of a tree to monotonically decrease as its flexibility (number of splits) increases.


(k) Test Error Comparison

Q: Compare the test error rates between the pruned and unpruned trees. Which is higher?

A:

The test error for the unpruned tree:



```r
mean(predict(tree_model, type = "class", newdata = test) != test$Purchase)
#> [1] 0.1740741
```

The same for the pruned tree:


```r
mean(predict(pruned_tree_model, type = "class", newdata = test) != test$Purchase)
#> [1] 0.2
```


Now the order has reversed and the error is higher for the unpruned tree.

It is interesting that the cross-validation errors were in fact equal but the test error is noticeably lower for the simpler tree. A lot of this probably comes from random variability when working with a small dataset; using a different random state for the CV folds and train/test split would likely change all of these results (particularly because decision trees are such high-variance approaches).
