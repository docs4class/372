evaluateGuess <- function(guessVec, answerVec) {
  wordLength <- length(answerVec)
  
  resVec <- rep("-", wordLength)
  # first pass: mark exact matches (green)
  for (i in 1:wordLength) {
    if (guessVec[i] == answerVec[i]) {
      resVec[i] <- "G"
      answerVec[i] <- "-"  # mark unavailable for yellow
    }
  }
  
  # second pass: mark yellow
  for (i in 1:wordLength) {
    if (resVec[i] != "G") {
      idx <- match(guessVec[i], answerVec)
      if (!is.na(idx)) {
        resVec[i] <- "Y"
        answerVec[idx] <- "-"
      }
    }
  }
  
  resVec
}

# example
evaluateGuess(strsplit("early", "")[[1]], 
              strsplit("later", "")[[1]])
# [1] "Y" "G" "Y" "Y" "-"

playGame <- function(dictionary, wordLength = 5, nGuesses = 6) {
  # select an answer
  possibleAnswers <- dictionary[nchar(dictionary) == wordLength]
  answer <- sample(possibleAnswers, 1)
  answerVec <- strsplit(answer, "")[[1]]
  
  print(paste("You have", nGuesses, "chances to guess a word of length", 
              wordLength))
  
  guessCnt <- 0
  lettersLeft <- LETTERS
  while (guessCnt < nGuesses) {
    # display "keyboard"
    print(paste(c("Letters left:", lettersLeft), collapse = " "))
    
    # read in guess
    guessCnt <- guessCnt + 1
    guess <- readline(paste0("Enter guess ", guessCnt, ": "))
    while (nchar(guess) != wordLength) {
      guess <- readline(paste0("Guess must have ", wordLength, " characters: "))
    }
    guess <- toupper(guess)
    guessVec <- strsplit(guess, "")[[1]]
    
    # evaluate guess and update keyboard
    resVec <- evaluateGuess(guessVec, answerVec)
    
    # update keyboard
    lettersLeft <- setdiff(lettersLeft, guessVec)
    
    # print result
    print(paste(strsplit(guess, "")[[1]], collapse = " "))
    print(paste(resVec, collapse = " "))
    if (all(resVec == "G")) {
      print("You won!")
      return(guessCnt)
    }
  }
  print(paste("Sorry, you lost! Answer was ", answer))
  return(guessCnt)
}

# scrabble
dictionary <- read.csv("C:/Users/jtturner/Desktop/Collins Scrabble Words (2019).txt", 
                       header = FALSE, skip = 2)[, 1]

# google
dictionary <- read.csv("../Dictionaries/google-10000-english-usa-no-swears.txt",
                       head = FALSE)[, 1]

playGame(dictionary)
# [1] "You have 6 chances to guess a word of length 5"
# [1] "Letters left: A B C D E F G H I J K L M N O P Q R S T U V W X Y Z"
# Enter guess 1: state
# [1] "S T A T E"
# [1] "Y - Y G Y"
# [1] "Letters left: B C D F G H I J K L M N O P Q R U V W X Y Z"
# Enter guess 2: Seat
# Guess must have 5 characters: seats
# [1] "S E A T S"
# [1] "Y G Y G -"
# [1] "Letters left: B C D F G H I J K L M N O P Q R U V W X Y Z"
# Enter guess 3: pesta
# [1] "P E S T A"
# [1] "- G G G G"
# [1] "Letters left: B C D F G H I J K L M N O Q R U V W X Y Z"
# Enter guess 4: vesta
# [1] "V E S T A"
# [1] "G G G G G"
# [1] "You won!"
# [1] 4
