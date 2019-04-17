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
# library("msm") # multistate modeling (cannot be declared silently)
# # Verify these packages are available on the machine, but their functions need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
# requireNamespace("ggplot2") # graphing
library("ggplot2") # graphing
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


d1 <- ds0 %>% 
  dplyr::select(StudentID, SchoolID, wave, construct, value, Tx1) %>% 
  dplyr::mutate(
    value = as.numeric(value)
  )

d1 %>% glimpse(60)

d1 %>% 
  dplyr::filter(construct == "Reading Fluency") %>% 
  TabularManifest::histogram_continuous(variable_name = "value")

set.seed(42)
alpha_value <- .1
g1 <- d1 %>% 
  dplyr::filter(construct %in% c("Reading Fluency")) %>%
  # dplyr::filter(construct %in% c("Empathy")) %>% 
  # dplyr::filter(construct %in% c("Empathy", "Reading Fluency")) %>%
  # dplyr::sample_frac(size = .3) %>% 
  ggplot2::ggplot(
    aes(
      x     = wave,
      y     = value,
      fill  = construct,
      color = construct
    )
  ) + 
  ggplot2::geom_point(
    shape = 21,
    size  = 3,
    fill  = NA
  ) +
  ggplot2::geom_line(
    aes(
      group = StudentID),
    alpha = alpha_value
  ) + 
  main_theme
g1
  

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

