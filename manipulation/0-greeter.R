# this script imports the raw data described in this shared document 
# https://drive.google.com/file/d/10idMxy8eX8nTHr6wr2Q40x4XOP3Y5ck7/view
# and prepares a state of data used as a standard point of departure for any subsequent reproducible analytics

# Lines before the first chunk are invisible to Rmd/Rnw callers
# Run to stitch a tech report of this script (used only in RStudio)
# knitr::stitch_rmd(
#   script = "./manipulation/0-greeter.R",
#   output = "./manipulation/stitched-output/0-greeter.md"
# )
# this command is typically executed by the ./manipulation/governor.R

rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. 
# This is not called by knitr, because it's above the first chunk.
cat("\f") # clear console when working in RStudio

# ---- load-sources ------------------------------------------------------------
# Call `base::source()` on any repo file that defines functions needed below.  Ideally, no real operations are performed.
base::source("./scripts/common-functions.R")
# ---- load-packages -----------------------------------------------------------
# Attach these packages so their functions don't need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
library(magrittr) #Pipes
library(haven)


# ---- declare-globals ---------------------------------------------------------
path_input <- "data-unshared/raw/2018-09-26/2018.09.26.sav"

# ---- load-data ---------------------------------------------------------------
# ds0 <- haven::read_sav(path_input, )
ds0 <- foreign::read.spss(path_input,use.value.labels = T,use.missings = TRUE) %>% 
  tibble::as_tibble()


# ---- create-stem-for-meta -----------------------

# variable_names  <- attr(ds0, "names")
# variable_labels <- attr(ds0, "variable.labels")
# 
# live_meta <- data.frame(
#   name = variable_names
#   ,label = variable_labels
# )
# live_meta %>% readr::write_csv("./data-unshared/derived/live-meta.csv")

# ---- input-augmented-meta -------------------
# input the dead meta data
d_meta <- readr::read_csv("./data-unshared/raw/dead-meta.csv")


# ---- tweak-data ----------------------------
variables_included <- d_meta %>% 
  dplyr::filter( include == TRUE) %>% 
  dplyr::select(name) %>% 
  as.list() %>% unlist() %>% as.character()

variables_included %>% str()

ds1 <- ds0 %>% 
  dplyr::select_(.dots = c(variables_included))

ds1 %>% dplyr::glimpse(60)
# 

# ---- define-utility-functions ---------------


# ---- save-to-disk ----------------------------

