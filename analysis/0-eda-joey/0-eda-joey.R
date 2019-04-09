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
ds0 <- ds0 %>% 
  dplyr::mutate(
    school_id = as.character(SchoolID)
  ) %>% 
  dplyr::filter(!SchoolID == "Mark Twain Elementary in WA_duplicated_140") %>% 
  dplyr::mutate(
    school_id = ifelse(school_id == "Benson Hill Elementary in WA'",
                       "Benson Hill Elementary in WA", school_id)
  )

regex = '(.+)( in )([A-Z]{2})( ?)'
ds0 <- ds0 %>% 
  dplyr::mutate(
    school_id     = gsub(" Elementary ", " ", school_id)
    ,school_name  = gsub(regex, "\\1", school_id)
    ,school_state = gsub(regex, "\\3", school_id)
  )

unique(ds0$SchoolID)
# ---- basic-table --------------------------------------------------------------

t1 <- ds0 %>% 
  dplyr::group_by(SchoolID) %>% 
  dplyr::summarize(
    n_students = length(unique(StudentID))
  )
t1 %>% neat()



# ---- basic-graph --------------------------------------------------------------
# How many students in each school
d1 <- ds0 %>% 
  dplyr::group_by(SchoolID) %>% 
  dplyr::summarize(
    n_students = length(unique(StudentID))
  ) 

d1 %>% 
  TabularManifest::histogram_continuous("n_students")
# ---- facet-graph ------------------------------------------------
# ---- facet-graph ------------------------------------------------

# scores of a measure in each school
g2 <- ds0 %>% 
  ggplot2::ggplot(
    aes(
     x = SDQpro1
     ,fill = school_state
   )
 ) +
  geom_bar() +
  facet_wrap("school_name")
  theme_minimal()
g2
  
# ---- density-graph ------------------------------------------------

g3 <- ds0 %>% 
  ggplot2::ggplot(
    aes(
      x = SDQpro1
      ,fill = school_state
    )
  ) +
  geom_density() +
  facet_wrap("school_name")
  theme_minimal()
g3

# ---- publish ---------------------------------------
path_report_1 <- "./analysis/0-eda-joey/0-eda-joey-0.Rmd"
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

