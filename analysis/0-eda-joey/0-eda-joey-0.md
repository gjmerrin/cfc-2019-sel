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


#Exploration

##Tables
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

##Graphs
<!-- Basic graph view.   -->

```r
# How many students in each school
d1 <- ds0 %>% 
  dplyr::group_by(SchoolID) %>% 
  dplyr::summarize(
    n_students = length(unique(StudentID))
  ) 

d1 %>% 
  TabularManifest::histogram_continuous("n_students")
```

<img src="figure_rmd_0/basic-graph-1.png" width="550px" />


```r
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
```

```
List of 59
 $ line                 :List of 6
  ..$ colour       : chr "black"
  ..$ size         : num 0.5
  ..$ linetype     : num 1
  ..$ lineend      : chr "butt"
  ..$ arrow        : logi FALSE
  ..$ inherit.blank: logi TRUE
  ..- attr(*, "class")= chr [1:2] "element_line" "element"
 $ rect                 :List of 5
  ..$ fill         : chr "white"
  ..$ colour       : chr "black"
  ..$ size         : num 0.5
  ..$ linetype     : num 1
  ..$ inherit.blank: logi TRUE
  ..- attr(*, "class")= chr [1:2] "element_rect" "element"
 $ text                 :List of 11
  ..$ family       : chr ""
  ..$ face         : chr "plain"
  ..$ colour       : chr "black"
  ..$ size         : num 11
  ..$ hjust        : num 0.5
  ..$ vjust        : num 0.5
  ..$ angle        : num 0
  ..$ lineheight   : num 0.9
  ..$ margin       : 'margin' num [1:4] 0pt 0pt 0pt 0pt
  .. ..- attr(*, "valid.unit")= int 8
  .. ..- attr(*, "unit")= chr "pt"
  ..$ debug        : logi FALSE
  ..$ inherit.blank: logi TRUE
  ..- attr(*, "class")= chr [1:2] "element_text" "element"
 $ axis.title.x         :List of 11
  ..$ family       : NULL
  ..$ face         : NULL
  ..$ colour       : NULL
  ..$ size         : NULL
  ..$ hjust        : NULL
  ..$ vjust        : num 1
  ..$ angle        : NULL
  ..$ lineheight   : NULL
  ..$ margin       : 'margin' num [1:4] 2.75pt 0pt 0pt 0pt
  .. ..- attr(*, "valid.unit")= int 8
  .. ..- attr(*, "unit")= chr "pt"
  ..$ debug        : NULL
  ..$ inherit.blank: logi TRUE
  ..- attr(*, "class")= chr [1:2] "element_text" "element"
 $ axis.title.x.top     :List of 11
  ..$ family       : NULL
  ..$ face         : NULL
  ..$ colour       : NULL
  ..$ size         : NULL
  ..$ hjust        : NULL
  ..$ vjust        : num 0
  ..$ angle        : NULL
  ..$ lineheight   : NULL
  ..$ margin       : 'margin' num [1:4] 0pt 0pt 2.75pt 0pt
  .. ..- attr(*, "valid.unit")= int 8
  .. ..- attr(*, "unit")= chr "pt"
  ..$ debug        : NULL
  ..$ inherit.blank: logi TRUE
  ..- attr(*, "class")= chr [1:2] "element_text" "element"
 $ axis.title.y         :List of 11
  ..$ family       : NULL
  ..$ face         : NULL
  ..$ colour       : NULL
  ..$ size         : NULL
  ..$ hjust        : NULL
  ..$ vjust        : num 1
  ..$ angle        : num 90
  ..$ lineheight   : NULL
  ..$ margin       : 'margin' num [1:4] 0pt 2.75pt 0pt 0pt
  .. ..- attr(*, "valid.unit")= int 8
  .. ..- attr(*, "unit")= chr "pt"
  ..$ debug        : NULL
  ..$ inherit.blank: logi TRUE
  ..- attr(*, "class")= chr [1:2] "element_text" "element"
 $ axis.title.y.right   :List of 11
  ..$ family       : NULL
  ..$ face         : NULL
  ..$ colour       : NULL
  ..$ size         : NULL
  ..$ hjust        : NULL
  ..$ vjust        : num 0
  ..$ angle        : num -90
  ..$ lineheight   : NULL
  ..$ margin       : 'margin' num [1:4] 0pt 0pt 0pt 2.75pt
  .. ..- attr(*, "valid.unit")= int 8
  .. ..- attr(*, "unit")= chr "pt"
  ..$ debug        : NULL
  ..$ inherit.blank: logi TRUE
  ..- attr(*, "class")= chr [1:2] "element_text" "element"
 $ axis.text            :List of 11
  ..$ family       : NULL
  ..$ face         : NULL
  ..$ colour       : chr "grey30"
  ..$ size         : 'rel' num 0.8
  ..$ hjust        : NULL
  ..$ vjust        : NULL
  ..$ angle        : NULL
  ..$ lineheight   : NULL
  ..$ margin       : NULL
  ..$ debug        : NULL
  ..$ inherit.blank: logi TRUE
  ..- attr(*, "class")= chr [1:2] "element_text" "element"
 $ axis.text.x          :List of 11
  ..$ family       : NULL
  ..$ face         : NULL
  ..$ colour       : NULL
  ..$ size         : NULL
  ..$ hjust        : NULL
  ..$ vjust        : num 1
  ..$ angle        : NULL
  ..$ lineheight   : NULL
  ..$ margin       : 'margin' num [1:4] 2.2pt 0pt 0pt 0pt
  .. ..- attr(*, "valid.unit")= int 8
  .. ..- attr(*, "unit")= chr "pt"
  ..$ debug        : NULL
  ..$ inherit.blank: logi TRUE
  ..- attr(*, "class")= chr [1:2] "element_text" "element"
 $ axis.text.x.top      :List of 11
  ..$ family       : NULL
  ..$ face         : NULL
  ..$ colour       : NULL
  ..$ size         : NULL
  ..$ hjust        : NULL
  ..$ vjust        : num 0
  ..$ angle        : NULL
  ..$ lineheight   : NULL
  ..$ margin       : 'margin' num [1:4] 0pt 0pt 2.2pt 0pt
  .. ..- attr(*, "valid.unit")= int 8
  .. ..- attr(*, "unit")= chr "pt"
  ..$ debug        : NULL
  ..$ inherit.blank: logi TRUE
  ..- attr(*, "class")= chr [1:2] "element_text" "element"
 $ axis.text.y          :List of 11
  ..$ family       : NULL
  ..$ face         : NULL
  ..$ colour       : NULL
  ..$ size         : NULL
  ..$ hjust        : num 1
  ..$ vjust        : NULL
  ..$ angle        : NULL
  ..$ lineheight   : NULL
  ..$ margin       : 'margin' num [1:4] 0pt 2.2pt 0pt 0pt
  .. ..- attr(*, "valid.unit")= int 8
  .. ..- attr(*, "unit")= chr "pt"
  ..$ debug        : NULL
  ..$ inherit.blank: logi TRUE
  ..- attr(*, "class")= chr [1:2] "element_text" "element"
 $ axis.text.y.right    :List of 11
  ..$ family       : NULL
  ..$ face         : NULL
  ..$ colour       : NULL
  ..$ size         : NULL
  ..$ hjust        : num 0
  ..$ vjust        : NULL
  ..$ angle        : NULL
  ..$ lineheight   : NULL
  ..$ margin       : 'margin' num [1:4] 0pt 0pt 0pt 2.2pt
  .. ..- attr(*, "valid.unit")= int 8
  .. ..- attr(*, "unit")= chr "pt"
  ..$ debug        : NULL
  ..$ inherit.blank: logi TRUE
  ..- attr(*, "class")= chr [1:2] "element_text" "element"
 $ axis.ticks           : list()
  ..- attr(*, "class")= chr [1:2] "element_blank" "element"
 $ axis.ticks.length    : 'unit' num 2.75pt
  ..- attr(*, "valid.unit")= int 8
  ..- attr(*, "unit")= chr "pt"
 $ axis.line            : list()
  ..- attr(*, "class")= chr [1:2] "element_blank" "element"
 $ axis.line.x          : NULL
 $ axis.line.y          : NULL
 $ legend.background    : list()
  ..- attr(*, "class")= chr [1:2] "element_blank" "element"
 $ legend.margin        : 'margin' num [1:4] 5.5pt 5.5pt 5.5pt 5.5pt
  ..- attr(*, "valid.unit")= int 8
  ..- attr(*, "unit")= chr "pt"
 $ legend.spacing       : 'unit' num 11pt
  ..- attr(*, "valid.unit")= int 8
  ..- attr(*, "unit")= chr "pt"
 $ legend.spacing.x     : NULL
 $ legend.spacing.y     : NULL
 $ legend.key           : list()
  ..- attr(*, "class")= chr [1:2] "element_blank" "element"
 $ legend.key.size      : 'unit' num 1.2lines
  ..- attr(*, "valid.unit")= int 3
  ..- attr(*, "unit")= chr "lines"
 $ legend.key.height    : NULL
 $ legend.key.width     : NULL
 $ legend.text          :List of 11
  ..$ family       : NULL
  ..$ face         : NULL
  ..$ colour       : NULL
  ..$ size         : 'rel' num 0.8
  ..$ hjust        : NULL
  ..$ vjust        : NULL
  ..$ angle        : NULL
  ..$ lineheight   : NULL
  ..$ margin       : NULL
  ..$ debug        : NULL
  ..$ inherit.blank: logi TRUE
  ..- attr(*, "class")= chr [1:2] "element_text" "element"
 $ legend.text.align    : NULL
 $ legend.title         :List of 11
  ..$ family       : NULL
  ..$ face         : NULL
  ..$ colour       : NULL
  ..$ size         : NULL
  ..$ hjust        : num 0
  ..$ vjust        : NULL
  ..$ angle        : NULL
  ..$ lineheight   : NULL
  ..$ margin       : NULL
  ..$ debug        : NULL
  ..$ inherit.blank: logi TRUE
  ..- attr(*, "class")= chr [1:2] "element_text" "element"
 $ legend.title.align   : NULL
 $ legend.position      : chr "right"
 $ legend.direction     : NULL
 $ legend.justification : chr "center"
 $ legend.box           : NULL
 $ legend.box.margin    : 'margin' num [1:4] 0cm 0cm 0cm 0cm
  ..- attr(*, "valid.unit")= int 1
  ..- attr(*, "unit")= chr "cm"
 $ legend.box.background: list()
  ..- attr(*, "class")= chr [1:2] "element_blank" "element"
 $ legend.box.spacing   : 'unit' num 11pt
  ..- attr(*, "valid.unit")= int 8
  ..- attr(*, "unit")= chr "pt"
 $ panel.background     : list()
  ..- attr(*, "class")= chr [1:2] "element_blank" "element"
 $ panel.border         : list()
  ..- attr(*, "class")= chr [1:2] "element_blank" "element"
 $ panel.spacing        : 'unit' num 5.5pt
  ..- attr(*, "valid.unit")= int 8
  ..- attr(*, "unit")= chr "pt"
 $ panel.spacing.x      : NULL
 $ panel.spacing.y      : NULL
 $ panel.grid           :List of 6
  ..$ colour       : chr "grey92"
  ..$ size         : NULL
  ..$ linetype     : NULL
  ..$ lineend      : NULL
  ..$ arrow        : logi FALSE
  ..$ inherit.blank: logi TRUE
  ..- attr(*, "class")= chr [1:2] "element_line" "element"
 $ panel.grid.minor     :List of 6
  ..$ colour       : NULL
  ..$ size         : 'rel' num 0.5
  ..$ linetype     : NULL
  ..$ lineend      : NULL
  ..$ arrow        : logi FALSE
  ..$ inherit.blank: logi TRUE
  ..- attr(*, "class")= chr [1:2] "element_line" "element"
 $ panel.ontop          : logi FALSE
 $ plot.background      : list()
  ..- attr(*, "class")= chr [1:2] "element_blank" "element"
 $ plot.title           :List of 11
  ..$ family       : NULL
  ..$ face         : NULL
  ..$ colour       : NULL
  ..$ size         : 'rel' num 1.2
  ..$ hjust        : num 0
  ..$ vjust        : num 1
  ..$ angle        : NULL
  ..$ lineheight   : NULL
  ..$ margin       : 'margin' num [1:4] 0pt 0pt 5.5pt 0pt
  .. ..- attr(*, "valid.unit")= int 8
  .. ..- attr(*, "unit")= chr "pt"
  ..$ debug        : NULL
  ..$ inherit.blank: logi TRUE
  ..- attr(*, "class")= chr [1:2] "element_text" "element"
 $ plot.subtitle        :List of 11
  ..$ family       : NULL
  ..$ face         : NULL
  ..$ colour       : NULL
  ..$ size         : NULL
  ..$ hjust        : num 0
  ..$ vjust        : num 1
  ..$ angle        : NULL
  ..$ lineheight   : NULL
  ..$ margin       : 'margin' num [1:4] 0pt 0pt 5.5pt 0pt
  .. ..- attr(*, "valid.unit")= int 8
  .. ..- attr(*, "unit")= chr "pt"
  ..$ debug        : NULL
  ..$ inherit.blank: logi TRUE
  ..- attr(*, "class")= chr [1:2] "element_text" "element"
 $ plot.caption         :List of 11
  ..$ family       : NULL
  ..$ face         : NULL
  ..$ colour       : NULL
  ..$ size         : 'rel' num 0.8
  ..$ hjust        : num 1
  ..$ vjust        : num 1
  ..$ angle        : NULL
  ..$ lineheight   : NULL
  ..$ margin       : 'margin' num [1:4] 5.5pt 0pt 0pt 0pt
  .. ..- attr(*, "valid.unit")= int 8
  .. ..- attr(*, "unit")= chr "pt"
  ..$ debug        : NULL
  ..$ inherit.blank: logi TRUE
  ..- attr(*, "class")= chr [1:2] "element_text" "element"
 $ plot.tag             :List of 11
  ..$ family       : NULL
  ..$ face         : NULL
  ..$ colour       : NULL
  ..$ size         : 'rel' num 1.2
  ..$ hjust        : num 0.5
  ..$ vjust        : num 0.5
  ..$ angle        : NULL
  ..$ lineheight   : NULL
  ..$ margin       : NULL
  ..$ debug        : NULL
  ..$ inherit.blank: logi TRUE
  ..- attr(*, "class")= chr [1:2] "element_text" "element"
 $ plot.tag.position    : chr "topleft"
 $ plot.margin          : 'margin' num [1:4] 5.5pt 5.5pt 5.5pt 5.5pt
  ..- attr(*, "valid.unit")= int 8
  ..- attr(*, "unit")= chr "pt"
 $ strip.background     : list()
  ..- attr(*, "class")= chr [1:2] "element_blank" "element"
 $ strip.placement      : chr "inside"
 $ strip.text           :List of 11
  ..$ family       : NULL
  ..$ face         : NULL
  ..$ colour       : chr "grey10"
  ..$ size         : 'rel' num 0.8
  ..$ hjust        : NULL
  ..$ vjust        : NULL
  ..$ angle        : NULL
  ..$ lineheight   : NULL
  ..$ margin       : 'margin' num [1:4] 4.4pt 4.4pt 4.4pt 4.4pt
  .. ..- attr(*, "valid.unit")= int 8
  .. ..- attr(*, "unit")= chr "pt"
  ..$ debug        : NULL
  ..$ inherit.blank: logi TRUE
  ..- attr(*, "class")= chr [1:2] "element_text" "element"
 $ strip.text.x         : NULL
 $ strip.text.y         :List of 11
  ..$ family       : NULL
  ..$ face         : NULL
  ..$ colour       : NULL
  ..$ size         : NULL
  ..$ hjust        : NULL
  ..$ vjust        : NULL
  ..$ angle        : num -90
  ..$ lineheight   : NULL
  ..$ margin       : NULL
  ..$ debug        : NULL
  ..$ inherit.blank: logi TRUE
  ..- attr(*, "class")= chr [1:2] "element_text" "element"
 $ strip.switch.pad.grid: 'unit' num 2.75pt
  ..- attr(*, "valid.unit")= int 8
  ..- attr(*, "unit")= chr "pt"
 $ strip.switch.pad.wrap: 'unit' num 2.75pt
  ..- attr(*, "valid.unit")= int 8
  ..- attr(*, "unit")= chr "pt"
 - attr(*, "class")= chr [1:2] "theme" "gg"
 - attr(*, "complete")= logi TRUE
 - attr(*, "validate")= logi TRUE
```

```r
g2
```

```
Warning: Removed 2603 rows containing non-finite values (stat_count).
```

<img src="figure_rmd_0/facet-graph-1.png" width="900" />



