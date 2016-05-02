deathrow <- readRDS("deathrow.rds")

selection.date.min <- min(deathrow$date)
selection.date.max <- max(deathrow$date)
selection.age.min <- min(deathrow$age)
selection.age.max <- max(deathrow$age)
selection.race <- unique(as.character(deathrow$race))
selection.race <- selection.race[!selection.race=="Other"]
selection.race <- sort(selection.race)
selection.race <- c(selection.race, "Other") 

