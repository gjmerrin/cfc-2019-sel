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
# this live_meta object would be manually edited in Excel to create dead_meta

# ---- input-augmented-meta -------------------
# input the dead meta data
d_meta <- readr::read_csv("./data-unshared/raw/dead-meta.csv")

# ---- inspect-data ---------------------------
# ds0 %>% dplyr::glimpse(80) # 365 columns, 9076 rows
d_meta

# ---- tweak-data ----------------------------
ds0 <- ds0 %>% 
  dplyr::mutate(
    SchoolID = as.character(SchoolID)
  ) %>% 
  dplyr::filter(!SchoolID == "Mark Twain Elementary in WA_duplicated_140") %>% 
  dplyr::mutate(
    SchoolID = ifelse(SchoolID == "Cascade Elementary in WA ",
                       "Cascade Elementary in WA", SchoolID)
    ,SchoolID = ifelse(SchoolID == "Benson Hill Elementary in WA'",
                      "Benson Hill Elementary in WA", SchoolID)
  )

regex = '(.+)( in )([A-Z]{2})( ?)'
ds0 <- ds0 %>% 
  dplyr::mutate(
    school_id     = gsub(" Elementary ", " ", SchoolID)
    ,school_name  = gsub(regex, "\\1", SchoolID)
    ,school_state = gsub(regex, "\\3", SchoolID)
  )

unique(ds0$school_id)

# function to compute the typical value in a character vector
getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

# creating a correct treatment (tx) variable
ds0 <- ds0 %>% 
  dplyr::mutate(
    Tx1 = as.character(Tx1)
  ) %>% 
  dplyr::group_by(school_id) %>% 
  dplyr::mutate(
    tx = getmode(Tx1)
  ) %>% 
  dplyr::ungroup()

# sanity check: each school should have only one level of Tx
ds0 %>% 
  dplyr::group_by(school_id) %>% 
  dplyr::summarize(
    n_levels_tx = length(unique(tx))
  ) %>%
  print(n = nrow(.))

# what is the level of tx for each of the school?
ds0 %>% 
  dplyr::group_by(school_id, tx) %>% 
  dplyr::count() %>% 
  dplyr::arrange(tx) %>% 
  print(n = nrow(.))



# define the relevant scope of vision needed for analytic goals
variables_included <- d_meta %>% 
  dplyr::filter( include == TRUE) %>% 
  dplyr::select(name) %>% 
  as.list() %>% unlist() %>% as.character()

variables_included %>% str()

ds1 <- ds0 %>% 
  dplyr::select_(.dots = c(variables_included,"school_id","school_name","school_state", "tx")) %>%
  # dplyr::select_(.dots = c(variables_included)) %>% 
  dplyr::arrange(StudentID)
  

ds1 %>% dplyr::glimpse(60)


# prepare for gathering
have_waves <- d_meta %>% 
  dplyr::filter(!is.na(wave)) %>% 
  dplyr::filter(name %in% variables_included) %>% 
  dplyr::select(name) %>% 
  as.list() %>% unlist() %>% as.character()

ds1_long <- ds1 %>%
  # dplyr::arrange(StudentID) %>% dplyr::slice(1:100) %>%  # minimize for evaluation
  tidyr::gather("key", "value", have_waves) %>% 
  dplyr::left_join(d_meta, by = c("key" = "name")) %>% 
  dplyr::select(-include)

# ---- sanity-check ---------------


# ---- save-to-disk ----------------------------

saveRDS(ds1_long, "./data-unshared/derived/0-dto.rds")



