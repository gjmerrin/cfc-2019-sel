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
# ---- bar-graph ------------------------------------------------
# Scores of a measure in each school
g2 <- ds0 %>% 
  ggplot2::ggplot(
    aes(
     x = SDQpro1
     ,fill = school_state
   )
 ) +
  geom_bar() +
  facet_wrap("school_name") +
  theme_minimal()
g2
# ---- density-graph ------------------------------------------------
# denisty of a measure in across schools
g3 <- ds0 %>% 
  ggplot2::ggplot(
    aes(
      x = SDQpro1
      ,fill = school_state
    )
  ) +
  geom_density() +
  facet_wrap("school_name") +
  theme_minimal()
g3

# ---- box-plot-graph ------------------------------------------------
# box plot of a variable and the treatment variable
g4 <- ds0 %>% 
  ggplot2::ggplot(
    aes(
      x     = Tx1
      ,y    = SDQpro1
      ,fill = Tx1
    )
  ) + 
  geom_boxplot() +
  coord_flip() +
  theme_minimal() 
g4


# ---- poly-graph ------------------------------------------------
# Freqpoly
g5 <- ds0 %>% 
  ggplot2::ggplot(
    mapping = aes(
      x = SDQpro1
    )
  ) +
   geom_freqpoly(
     mapping = aes(
       color = Tx1
     ) , bindwidth = 100
   ) +
  theme_minimal()
g5

# ---- point-graph ------------------------------------------------

g6 <- ds0 %>% 
  ggplot2::ggplot(
    mapping = aes(
      x  = SDQpro1
      ,y = SDQpro2
    )
  ) +
  ggplot2::geom_point()+
  ggplot2::geom_smooth()+
  ggplot2::geom_jitter()+
  theme_minimal()
g6

# ---- line-graph ------------------------------------------------

g7 <- ds0 %>% 
  ggplot2::ggplot() +
  ggplot2::geom_smooth(
    mapping = aes(
      x  = SDQpro1
      ,y = SDQpro2
      ,color = Tx1
    )
  ) + 
theme_minimal()
g7

g8 <- ds0 %>% 
  ggplot2::ggplot() +
  ggplot2::geom_smooth(
    mapping = aes(
      x  = SDQpro1
      ,y = SDQpro2
      ,color = Tx1
    )
  ) + 
  facet_wrap("school_name") +
  theme_minimal()
g8

# ---- by-wave-graph ------------------------------------------------
vars <- c("StudentID","school_name", "school_state", "Tx1")
d9_long <- ds0 %>% 
  dplyr::select_(.dots = c(vars, paste0("SDQpro",1:4))) %>%
  tidyr::gather(
    key    = "key"   # name of new variable to store the key
    ,value = "value" # name of new variable to store the values
    ,SDQpro1, SDQpro2, SDQpro3, SDQpro4 # selection of columns to gather
  ) %>% 
  dplyr::mutate(
    prosocial  = value, # the variable that will store the value of SDQ
    wave       = gsub(pattern = "SDQpro(\\d+)",replacement = "\\1", x = key)
  ) %>% 
  dplyr::select(-key, -value) %>% 
  dplyr::arrange(StudentID)
d9_long %>% print()

p <- d9_long %>%
ggplot2::ggplot(
  mapping = aes(
    x      = wave
    ,y     = prosocial
    ,group = StudentID
    ,color = Tx1
  )
) 

p + geom_point() + geom_jitter()
p + geom_line() 
p + geom_line() + facet_grid(. ~ Tx1)
p + geom_line() + facet_wrap(~school_name)

# ---- school-graph ------------------------------------------------
d9_long_2 <- d9_long %>% 
  group_by(school_name, wave) %>% 
  mutate(
    sm_prosocial = mean(x = prosocial, na.rm = TRUE)
  )

d9_long_2 %>% print()

s <- d9_long_2 %>%
  ggplot2::ggplot(
    mapping = aes(
      x      = wave
      ,y     = sm_prosocial
      ,group = school_name
      ,color = school_state
    ) 
  )

s + geom_point()
s + geom_line() 
s + geom_line() + facet_wrap(~school_name)

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

