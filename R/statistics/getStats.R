# Author: Laura K. Wiley, University Colorado Anschutz

## getStats(df, predicted, reference)
getStats <- function(df, ...){
  df %>%
	select_(.dots = lazyeval::lazy_dots(...)) %>%
	mutate_all(funs(factor(., levels = c(1,0)))) %>% 
	table() %>% 
	confusionMatrix()
}
