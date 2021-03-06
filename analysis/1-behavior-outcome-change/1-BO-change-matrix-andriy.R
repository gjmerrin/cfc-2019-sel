# knitr::stitch_rmd(script="./___/___.R", output="./___/stitched-output/___.md")
#These first few lines run only when the file is run in RStudio, !!NOT when an Rmd/Rnw file calls it!!
rm(list=ls(all=TRUE))  #Clear the variables from previous runs.
cat("\f") # clear console 

# ---- load-sources ------------------------------------------------------------
# Call `base::source()` on any repo file that defines functions needed below.  Ideally, no real operations are performed.
source("./scripts/common-functions.R") # used in multiple reports
source("./scripts/graphing/graph-presets.R") # fonts, colors, themes 

# ---- load-packages -----------------------------------------------------------
# Attach these packages so their functions don't need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
library(magrittr) # enables piping : %>% 
library(ggplot2)
# library("msm") # multistate modeling (cannot be declared silently)
# # Verify these packages are available on the machine, but their functions need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
requireNamespace("ggplot2") # graphing
requireNamespace("tidyr") # data manipulation
# requireNamespace("dplyr") # Avoid attaching dplyr, b/c its function names conflict with a lot of packages (esp base, stats, and plyr).
library("dplyr") # Avoid attaching dplyr, b/c its function names conflict with a lot of packages (esp base, stats, and plyr).
# requireNamespace("testit")# For asserting conditions meet expected patterns.
# # requireNamespace("car") # For it's `recode()` function.
# requireNamespace("flexsurv") # parameteric survival and multi-state
# requireNamespace("mstate") # multistate modeling
# requireNamespace("foreign") # data input

# ---- declare-globals ---------------------------------------------------------

path_input <- "./data-unshared/derived/0-dto.rds"

# ---- load-data ---------------------------------------------------------------

dt0 <- readRDS(path_input)
ds0 <- dt0 

# ---- inspect-data -------------------------------------------------------------
ds0 %>% glimpse(60)

# ---- tweak-data --------------------------------------------------------------

ds0 %>% 
  dplyr::group_by(school_id, tx) %>% 
  dplyr::count() %>% 
  dplyr::arrange(tx) %>% 
  print(n = nrow(.))


d1 <- ds0 %>% 
  dplyr::select(StudentID, school_id, wave, construct, value, tx) %>% 
  dplyr::mutate(
    value = as.numeric(value)
  )




get_a_sample <- function(d,varname,sample_size, show_all = FALSE){
  # varname = "offense_arrest_cd"
  
  sample_pool <- d %>% 
    dplyr::distinct_(.dots = varname) %>% na.omit() %>% 
    as.list() %>% unlist() %>% as.vector() 
  if(show_all){ sample_size = length(sample_pool)}
  selected_sample <- sample_pool %>% sample(size = sample_size, replace = FALSE )
  
  return(selected_sample)
} 
# d_sample_1 <- d1 %>% get_a_sample(varname = "StudentID",sample_size =  100)


set.seed(42)
alpha_value <- .05
sample_size <- 1000
g1 <- d1 %>% 
  # dplyr::filter(construct %in% c("Empathy")) %>%
  dplyr::filter(construct %in% c("Reading Fluency")) %>%
  # dplyr::filter(construct %in% c("Empathy", "Reading Fluency")) %>%
  dplyr::filter(StudentID %in% get_a_sample(d1,"StudentID",sample_size, F)) %>% 
  ggplot(aes(x = wave, y = value)) +
  # geom_point( shape  = 21, size = 3, fill = NA, alpha = alpha_value)+
  geom_line(aes(group = StudentID), alpha = alpha_value, color = "black")+
  geom_smooth(aes(group = school_id, color = tx), se = F)+
  # geom_smooth(aes(group = SchoolID), color = "blue", se = F)+
  # geom_smooth(aes(group = as.factor(tx)) )+
  main_theme 

g1

g2 <- d1 %>% 
  dplyr::filter(construct %in% c("Reading Fluency")) %>%
  dplyr::filter(StudentID %in% get_a_sample(d1,"StudentID",sample_size, F)) %>%
  ggplot(aes(x = wave, y = value))+
  geom_smooth(aes(group = tx))+
  main_theme
g2
  
  
  
  
  
# ---- basic-table --------------------------------------------------------------


# ---- basic-graph --------------------------------------------------------------

# ---- publish ---------------------------------------
path_report_1 <- "./analysis/1-behavior-outcome-change/1-BO-change-matrix-andriy.Rmd"
path_report_2 <- "./reports/*/report_2.Rmd"
# allReports <- c(path_report_1,path_report_2)
allReports <- c(path_report_1)

pathFilesToBuild <- c(allReports)
testit::assert("The knitr Rmd files should exist.", base::file.exists(pathFilesToBuild))
# Build the reports
for( pathFile in pathFilesToBuild ) {
  
  rmarkdown::render(input = pathFile,
                    output_format=c(
                      "html_document" # set print_format <- "html" in seed-study.R
                      # "pdf_document"
                      # ,"md_document"
                      # "word_document" # set print_format <- "pandoc" in seed-study.R
                    ),
                    clean=TRUE)
}

