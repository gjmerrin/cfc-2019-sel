---
title: "EDA-0"
output:
  html_document:
    keep_md: yes
    toc: yes
---

<!-- These two chunks should be added in the beginning of every .Rmd that you want to source an .R script -->
<!--  The 1st mandatory chunck  -->
<!--  Set the working directory to the repository's base directory -->


<!--  The 2nd mandatory chunck  -->
<!-- Set the report-wide options, and point to the external code file. -->




<!-- Load 'sourced' R files.  Suppress the output when loading packages. --> 



<!-- Load the sources.  Suppress the output when loading sources. --> 



<!-- Load any Global functions and variables declared in the R file.  Suppress the output. --> 


<!-- Declare any global functions specific to a Rmd output.  Suppress the output. --> 


<!-- Load the datasets.   -->


<!-- Inspect the datasets.   -->

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
   <td style="text-align:left;"> Mark Twain Elementary in WA_duplicated_140 </td>
   <td style="text-align:right;"> 168 </td>
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

<!-- Basic graph view.   -->





