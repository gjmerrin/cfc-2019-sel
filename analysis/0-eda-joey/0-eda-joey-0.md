---
title: "EDA-0"
output:
  html_document:
    css: ~/Documents/GitHub/cfc/cfc-2019-sel/libs/css/sidebar.css
    keep_md: yes
    toc: yes
---

<!-- These two chunks should be added in the beginning of every .Rmd that you want to source an .R script -->
<!--  The 1st mandatory chunck  -->
<!--  Set the working directory to the repository's base directory -->


<!--  The 2nd mandatory chunck  -->
<!-- Set the report-wide options, and point to the external code file. -->


# Exposition

<!-- Load 'sourced' R files.  Suppress the output when loading packages. --> 

```r
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
```


<!-- Load the sources.  Suppress the output when loading sources. --> 

```r
# Call `base::source()` on any repo file that defines functions needed below.  Ideally, no real operations are performed.
source("./scripts/common-functions.R") # used in multiple reports
source("./scripts/graphing/graph-presets.R") # fonts, colors, themes 
```


<!-- Load any Global functions and variables declared in the R file.  Suppress the output. --> 

```r
path_input <- "./data-unshared/derived/0-dto.rds"
```

<!-- Declare any global functions specific to a Rmd output.  Suppress the output. --> 

```r
#Put code in here.  It doesn't call a chunk in the codebehind file.
```

<!-- Load the datasets.   -->

```r
dt0 <- readRDS(path_input)
ds0 <- dt0 
```

<!-- Inspect the datasets.   -->

```r
ds0 %>% glimpse(60)
```

```
Observations: 9,076
Variables: 53
$ StudentID  <dbl> 101101125, 101101189, 101101192, 10110…
$ ATeacherID <chr> "101101", "101101", "101101", "101101"…
$ BTeacherID <chr> "101101", "101101", "101101", "101101"…
$ CTeacherID <chr> "101204", "      ", "101203", "      "…
$ DTeacherID <chr> "101204", "      ", "101203", "      "…
$ SchoolID   <fct> Cascade Elementary in WA , Cascade Ele…
$ Tx1        <fct> Intervention Group (1), Intervention G…
$ Tx2        <fct> Intervention Group (1), NA, Interventi…
$ ASDQ1      <fct> Certainly True, Somewhat True, Certain…
$ ASDQ2      <fct> Not True, Not True, Not True, Not True…
$ ASDQ3      <fct> Not True, Not True, Not True, Not True…
$ ASDQ4      <fct> Certainly True, Somewhat True, Certain…
$ ASDQ5      <fct> Not True, Not True, Not True, Certainl…
$ ASDQ6      <fct> Not True, Not True, Not True, Not True…
$ ASDQ7      <fct> Certainly True, Certainly True, Certai…
$ ASDQ8      <fct> Not True, Not True, Not True, Not True…
$ ASDQ9      <fct> Certainly True, Somewhat True, Certain…
$ ASDQ10     <fct> Not True, Not True, Not True, Not True…
$ ASDQ11     <fct> Certainly True, Certainly True, Certai…
$ ASDQ12     <fct> Not True, Not True, Not True, Not True…
$ ASDQ13     <fct> Not True, Not True, Not True, Not True…
$ ASDQ14     <fct> Certainly True, Certainly True, Certai…
$ ASDQ15     <fct> Not True, Not True, Not True, Not True…
$ ASDQ16     <fct> Not True, Not True, Not True, Not True…
$ ASDQ17     <fct> Certainly True, Somewhat True, Certain…
$ ASDQ18     <fct> Not True, Not True, Not True, Not True…
$ ASDQ19     <fct> Not True, Not True, Not True, Not True…
$ ASDQ20     <fct> Somewhat True, Somewhat True, Somewhat…
$ ASDQ21     <fct> Certainly True, Somewhat True, Certain…
$ ASDQ22     <fct> Not True, Not True, Not True, Not True…
$ ASDQ23     <fct> Not True, Not True, Not True, Not True…
$ ASDQ24     <fct> Not True, Not True, Not True, Not True…
$ ASDQ25     <fct> Somewhat True, Certainly True, Certain…
$ SDQpro1    <dbl> 1.8, 1.0, 1.8, 0.2, 1.0, 1.0, 0.2, 0.2…
$ SDQpro2    <dbl> 1.6, 1.4, 2.0, 1.0, 0.6, 2.0, 0.2, 1.2…
$ SDQhyper1  <dbl> 0.2, 0.2, 0.0, 0.2, 0.2, 0.2, 0.8, 0.2…
$ SDQhyper2  <dbl> 0.0, 0.6, 0.0, 0.2, 0.6, 0.0, 1.2, 0.6…
$ SDQemot1   <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,…
$ SDQemot2   <dbl> 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,…
$ SDQcon1    <dbl> 0.0, 0.0, 0.0, 0.6, 0.2, 0.0, 0.4, 0.4…
$ SDQcon2    <dbl> 0.0, 0.2, 0.0, 0.0, 0.8, 0.4, 0.4, 0.2…
$ SDQpeer1   <dbl> 0.0, 0.0, 0.0, 0.6, 0.0, 0.0, 0.4, 0.2…
$ SDQpeer2   <dbl> 0.0, 0.0, 0.2, 0.4, 0.2, 0.0, 0.2, 0.2…
$ SDQpro3    <dbl> 2.0, NA, 1.2, NA, 0.4, NA, 0.4, 1.4, N…
$ SDQpro4    <dbl> 2.0, NA, 1.6, NA, 1.0, NA, 1.0, 1.4, N…
$ SDQhyper3  <dbl> 1.2, NA, 0.0, NA, 0.8, NA, 1.4, 0.4, N…
$ SDQhyper4  <dbl> 0.8, NA, 0.0, NA, 1.0, NA, 1.2, 1.4, N…
$ SDQemot3   <dbl> 0.0, NA, 0.6, NA, 0.0, NA, 0.0, 0.0, N…
$ SDQemot4   <dbl> 0.2, NA, 1.4, NA, 0.0, NA, 0.4, 0.4, N…
$ SDQcon3    <dbl> 0.2, NA, 0.0, NA, 0.4, NA, 1.0, 0.8, N…
$ SDQcon4    <dbl> 0.0, NA, 0.0, NA, 0.4, NA, 0.2, 1.0, N…
$ SDQpeer3   <dbl> 0.2, NA, 0.0, NA, 0.4, NA, 0.6, 0.8, N…
$ SDQpeer4   <dbl> 0.2, NA, 0.2, NA, 0.2, NA, 0.0, 1.4, N…
```

<!-- Tweak the datasets.   -->

```r
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
```

```
 [1] Cascade Elementary in WA               Bryn Mawr Elementary in WA            
 [3] Tiffany Park Elementary in WA          Sierra Heights Elementary in WA       
 [5] Kennydale Elementary in WA             Nautilus K-8 in WA                    
 [7] Twin Lakes Elementary in WA            Lakeland Elementary in WA             
 [9] Woodmont K-8 in WA                     Silver Lake Elementary in WA          
[11] Mark Twain Elementary in WA            Olympic View Elementary in WA         
[13] Suquamish Elementary in WA             Hilder Pearson Elementary in WA       
[15] Poulsbo Elementary in WA               Breidablik Elementary in WA           
[17] Vinland Elementary in WA               Redmond Elementary in WA              
[19] Juanita Elementary in WA               Rose Hill Elementary in WA            
[21] Elizabeth Blackwell Elementary in WA   Olivia Park Elementary in WA          
[23] Campbell Hill Elementary in WA         Talbot Hill Elementary in WA          
[25] Highlands Elementary in WA             Benson Hill Elementary in WA'         
[27] Maplewood Heights Elementary in WA     Honey Dew Elementary in WA            
[29] Richard Gordon Elementary in WA        David Wolfle Elementary in WA         
[31] Green Gables Elementary in WA          Sherwood Forest Elementary in WA      
[33] Brigadoon Elementary in WA             Rainier View Elementary in WA         
[35] Mirror Lake Elementary in WA           Wildwood Elementary in WA             
[37] Alexander Graham Bell Elementary in WA Einstein Elementary in WA             
[39] Rachel Carson Elementary in WA         Fairmount Elementary in WA            
[41] Highland Elementary in AZ              Johnson Elementary in AZ              
[43] Irving Elementary in AZ                Taft Elementary in AZ                 
[45] Edison Elementary in AZ                Robson Elementary in AZ               
[47] Webster Elementary in AZ               Lindbergh Elementary in AZ            
[49] Adams Elementary in AZ                 Lincoln Elementary in AZ              
[51] Mendoza Elementary in AZ               Entz Elementary in AZ                 
[53] Hawthorne Elementary in AZ             Wilson Elementary in AZ               
[55] Porter Elementary in AZ                Salk Elementary in AZ                 
[57] Kerr Elementary in AZ                  Redbird Elementary in AZ              
[59] Eisenhower Elementary in AZ            Longfellow Elementary in AZ           
61 Levels: Cascade Elementary in WA  Bryn Mawr Elementary in WA ... Longfellow Elementary in AZ
```


# Exploration

## Tables
<!-- Basic table view.   -->

```r
t1 <- ds0 %>% 
  dplyr::group_by(SchoolID) %>% 
  dplyr::summarize(
    n_students = length(unique(StudentID))
  )
t1 %>% neat()
```

<table class="table table-striped table-hover table-condensed table-responsive" style="width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:left;"> SchoolID </th>
   <th style="text-align:right;"> n_students </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Cascade Elementary in WA </td>
   <td style="text-align:right;"> 142 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Bryn Mawr Elementary in WA </td>
   <td style="text-align:right;"> 174 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Tiffany Park Elementary in WA </td>
   <td style="text-align:right;"> 135 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Sierra Heights Elementary in WA </td>
   <td style="text-align:right;"> 153 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Kennydale Elementary in WA </td>
   <td style="text-align:right;"> 136 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Nautilus K-8 in WA </td>
   <td style="text-align:right;"> 134 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Twin Lakes Elementary in WA </td>
   <td style="text-align:right;"> 152 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Lakeland Elementary in WA </td>
   <td style="text-align:right;"> 149 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Woodmont K-8 in WA </td>
   <td style="text-align:right;"> 149 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Silver Lake Elementary in WA </td>
   <td style="text-align:right;"> 156 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Mark Twain Elementary in WA </td>
   <td style="text-align:right;"> 177 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Olympic View Elementary in WA </td>
   <td style="text-align:right;"> 156 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Suquamish Elementary in WA </td>
   <td style="text-align:right;"> 150 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hilder Pearson Elementary in WA </td>
   <td style="text-align:right;"> 130 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Breidablik Elementary in WA </td>
   <td style="text-align:right;"> 126 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Vinland Elementary in WA </td>
   <td style="text-align:right;"> 137 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Redmond Elementary in WA </td>
   <td style="text-align:right;"> 146 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Juanita Elementary in WA </td>
   <td style="text-align:right;"> 138 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Rose Hill Elementary in WA </td>
   <td style="text-align:right;"> 135 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Elizabeth Blackwell Elementary in WA </td>
   <td style="text-align:right;"> 127 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Olivia Park Elementary in WA </td>
   <td style="text-align:right;"> 140 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Campbell Hill Elementary in WA </td>
   <td style="text-align:right;"> 140 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Highlands Elementary in WA </td>
   <td style="text-align:right;"> 140 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Benson Hill Elementary in WA' </td>
   <td style="text-align:right;"> 145 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Talbot Hill Elementary in WA </td>
   <td style="text-align:right;"> 147 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Maplewood Heights Elementary in WA </td>
   <td style="text-align:right;"> 150 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Honey Dew Elementary in WA </td>
   <td style="text-align:right;"> 144 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Richard Gordon Elementary in WA </td>
   <td style="text-align:right;"> 169 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Poulsbo Elementary in WA </td>
   <td style="text-align:right;"> 131 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> David Wolfle Elementary in WA </td>
   <td style="text-align:right;"> 138 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Green Gables Elementary in WA </td>
   <td style="text-align:right;"> 134 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Sherwood Forest Elementary in WA </td>
   <td style="text-align:right;"> 129 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Brigadoon Elementary in WA </td>
   <td style="text-align:right;"> 147 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Rainier View Elementary in WA </td>
   <td style="text-align:right;"> 137 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Mirror Lake Elementary in WA </td>
   <td style="text-align:right;"> 146 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Wildwood Elementary in WA </td>
   <td style="text-align:right;"> 160 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Alexander Graham Bell Elementary in WA </td>
   <td style="text-align:right;"> 136 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Einstein Elementary in WA </td>
   <td style="text-align:right;"> 162 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Rachel Carson Elementary in WA </td>
   <td style="text-align:right;"> 118 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Fairmount Elementary in WA </td>
   <td style="text-align:right;"> 147 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Highland Elementary in AZ </td>
   <td style="text-align:right;"> 173 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Johnson Elementary in AZ </td>
   <td style="text-align:right;"> 155 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Irving Elementary in AZ </td>
   <td style="text-align:right;"> 141 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Taft Elementary in AZ </td>
   <td style="text-align:right;"> 144 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Edison Elementary in AZ </td>
   <td style="text-align:right;"> 171 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Robson Elementary in AZ </td>
   <td style="text-align:right;"> 145 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Webster Elementary in AZ </td>
   <td style="text-align:right;"> 160 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Lindbergh Elementary in AZ </td>
   <td style="text-align:right;"> 140 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Adams Elementary in AZ </td>
   <td style="text-align:right;"> 170 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Lincoln Elementary in AZ </td>
   <td style="text-align:right;"> 161 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Mendoza Elementary in AZ </td>
   <td style="text-align:right;"> 151 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Entz Elementary in AZ </td>
   <td style="text-align:right;"> 171 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Wilson Elementary in AZ </td>
   <td style="text-align:right;"> 154 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Porter Elementary in AZ </td>
   <td style="text-align:right;"> 128 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Salk Elementary in AZ </td>
   <td style="text-align:right;"> 163 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Kerr Elementary in AZ </td>
   <td style="text-align:right;"> 167 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hawthorne Elementary in AZ </td>
   <td style="text-align:right;"> 189 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Redbird Elementary in AZ </td>
   <td style="text-align:right;"> 148 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Eisenhower Elementary in AZ </td>
   <td style="text-align:right;"> 164 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Longfellow Elementary in AZ </td>
   <td style="text-align:right;"> 151 </td>
  </tr>
</tbody>
</table>

## Graphs
<!-- Basic graph view.   -->

### Basic

```r
# How many students in each school
g1 <- ds0 %>% 
  dplyr::group_by(SchoolID) %>% 
  dplyr::summarize(
    n_students = length(unique(StudentID))
  ) 

g1 %>% 
  TabularManifest::histogram_continuous("n_students")
```

<img src="figure_rmd_0/basic-graph-1.png" width="550px" />

### Bar

```r
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
```

```
Warning: Removed 2603 rows containing non-finite values (stat_count).
```

<img src="figure_rmd_0/bar-graph-1.png" width="900" />

### Density

```r
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
```

```
Warning: Removed 2603 rows containing non-finite values (stat_density).
```

<img src="figure_rmd_0/density-graph-1.png" width="900" />

### Box-Plot

```r
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
```

```
Warning: Removed 2603 rows containing non-finite values (stat_boxplot).
```

<img src="figure_rmd_0/box-plot-graph-1.png" width="900" />

### Poly

```r
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
```

```
Warning: Ignoring unknown parameters: bindwidth
```

```r
g5
```

```
Warning: Removed 2603 rows containing non-finite values (stat_bin).
```

<img src="figure_rmd_0/poly-graph-1.png" width="1100" />

### Point

```r
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
```

```
Warning: Removed 3617 rows containing non-finite values (stat_smooth).
```

```
Warning: Removed 3617 rows containing missing values (geom_point).

Warning: Removed 3617 rows containing missing values (geom_point).
```

<img src="figure_rmd_0/point-graph-1.png" width="900" />

```r
g6_2 <- ds0 %>% 
  subset(!is.na(Tx1)) %>% 
  ggplot2::ggplot(
    aes(
      x  = school_name
      ,y = SDQpro1
    )
   ) +
  geom_point(
    alpha     = 0.3
    ,color    = "tomato"
    ,position = "jitter") +
  geom_boxplot(alpha=0) + 
  coord_flip() + 
  facet_grid(. ~ Tx1) +
  theme_minimal()
g6_2
```

```
Warning: Removed 957 rows containing non-finite values (stat_boxplot).
```

```
Warning: Removed 957 rows containing missing values (geom_point).
```

<img src="figure_rmd_0/point-graph-2.png" width="900" />

### Line

```r
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
```

```
Warning: Removed 3617 rows containing non-finite values (stat_smooth).
```

<img src="figure_rmd_0/line-graph-1.png" width="900" />

```r
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
```

```
Warning: Removed 3617 rows containing non-finite values (stat_smooth).
```

```
Warning in simpleLoess(y, x, w, span, degree = degree, parametric = parametric, : pseudoinverse used at 1
```

```
Warning in simpleLoess(y, x, w, span, degree = degree, parametric = parametric, : neighborhood radius 0.4
```

```
Warning in simpleLoess(y, x, w, span, degree = degree, parametric = parametric, : reciprocal condition number 4.9396e-17
```

```
Warning in predLoess(object$y, object$x, newx = if (is.null(newdata)) object$x else if (is.data.frame(newdata))
as.matrix(model.frame(delete.response(terms(object)), : pseudoinverse used at 1
```

```
Warning in predLoess(object$y, object$x, newx = if (is.null(newdata)) object$x else if (is.data.frame(newdata))
as.matrix(model.frame(delete.response(terms(object)), : neighborhood radius 0.4
```

```
Warning in predLoess(object$y, object$x, newx = if (is.null(newdata)) object$x else if (is.data.frame(newdata))
as.matrix(model.frame(delete.response(terms(object)), : reciprocal condition number 4.9396e-17
```

<img src="figure_rmd_0/line-graph-2.png" width="900" />

### By Wave

```r
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
```

```
Warning: select_() is deprecated. 
Please use select() instead

The 'programming' vignette or the tidyeval book can help you
to program with select() : https://tidyeval.tidyverse.org
This warning is displayed once per session.
```

```r
d9_long %>% print()
```

```
# A tibble: 35,632 x 6
   StudentID school_name school_state Tx1                    prosocial wave 
       <dbl> <chr>       <chr>        <fct>                      <dbl> <chr>
 1 101101125 Cascade     WA           Intervention Group (1)       1.8 1    
 2 101101125 Cascade     WA           Intervention Group (1)       1.6 2    
 3 101101125 Cascade     WA           Intervention Group (1)       2   3    
 4 101101125 Cascade     WA           Intervention Group (1)       2   4    
 5 101101189 Cascade     WA           Intervention Group (1)       1   1    
 6 101101189 Cascade     WA           Intervention Group (1)       1.4 2    
 7 101101189 Cascade     WA           Intervention Group (1)      NA   3    
 8 101101189 Cascade     WA           Intervention Group (1)      NA   4    
 9 101101192 Cascade     WA           Intervention Group (1)       1.8 1    
10 101101192 Cascade     WA           Intervention Group (1)       2   2    
# … with 35,622 more rows
```

```r
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
```

```
Warning: Removed 12462 rows containing missing values (geom_point).
```

```
Warning: Removed 12462 rows containing missing values (geom_point).
```

<img src="figure_rmd_0/by-wave-graph-1.png" width="900" />

```r
p + geom_line() 
```

```
Warning: Removed 11898 rows containing missing values (geom_path).
```

<img src="figure_rmd_0/by-wave-graph-2.png" width="900" />

```r
p + geom_line() + facet_grid(. ~ Tx1)
```

```
Warning: Removed 11898 rows containing missing values (geom_path).
```

<img src="figure_rmd_0/by-wave-graph-3.png" width="900" />

```r
p + geom_line() + facet_wrap(~school_name)
```

```
Warning: Removed 11898 rows containing missing values (geom_path).
```

<img src="figure_rmd_0/by-wave-graph-4.png" width="900" />

### School

```r
d9_long_2 <- d9_long %>% 
  group_by(school_name, wave) %>% 
  mutate(
    sm_prosocial = mean(x = prosocial, na.rm = TRUE)
  )

d9_long_2 %>% print()
```

```
# A tibble: 35,632 x 7
# Groups:   school_name, wave [240]
   StudentID school_name school_state Tx1                    prosocial wave  sm_prosocial
       <dbl> <chr>       <chr>        <fct>                      <dbl> <chr>        <dbl>
 1 101101125 Cascade     WA           Intervention Group (1)       1.8 1             1.22
 2 101101125 Cascade     WA           Intervention Group (1)       1.6 2             1.43
 3 101101125 Cascade     WA           Intervention Group (1)       2   3             1.44
 4 101101125 Cascade     WA           Intervention Group (1)       2   4             1.47
 5 101101189 Cascade     WA           Intervention Group (1)       1   1             1.22
 6 101101189 Cascade     WA           Intervention Group (1)       1.4 2             1.43
 7 101101189 Cascade     WA           Intervention Group (1)      NA   3             1.44
 8 101101189 Cascade     WA           Intervention Group (1)      NA   4             1.47
 9 101101192 Cascade     WA           Intervention Group (1)       1.8 1             1.22
10 101101192 Cascade     WA           Intervention Group (1)       2   2             1.43
# … with 35,622 more rows
```

```r
s <- d9_long_2 %>%
  ggplot2::ggplot(
    mapping = aes(
      x      = wave
      ,y     = sm_prosocial
      ,group = school_name
      ,color = school_state
    ) 
  )

s + ggplot2::geom_point(
  #shape  = 19  # Use solid circles
  shape  = 1   # Use hollow circles
  ,alpha = 1/4 # 1/4 opacity
) + 
  ggplot2::geom_jitter()
```

<img src="figure_rmd_0/school-graph-1.png" width="900" />

```r
s + ggplot2::geom_line() 
```

<img src="figure_rmd_0/school-graph-2.png" width="900" />

```r
s + ggplot2::geom_line() + facet_wrap(~school_name)
```

<img src="figure_rmd_0/school-graph-3.png" width="900" />

```r
# similar to the geom_line above
# s +
#   ggplot2::geom_smooth() +
#   facet_wrap("school_name") +
#   theme_minimal()

g15 <- d9_long %>% 
  group_by(school_name, wave) %>% 
  mutate(
    sm_prosocial = mean(x = prosocial, na.rm = TRUE)
  ) %>% 
  subset(!is.na(Tx1)) %>% 
  ggplot2::ggplot(
    aes(
     x = sm_prosocial
    ,fill = Tx1
    )
  ) +
  geom_density() +
  facet_wrap("wave") +
  theme_minimal()
g15
```

<img src="figure_rmd_0/school-graph-4.png" width="900" />






