library(tidyverse)
library(haven)

df <- haven::read_spss("/Users/remek/OneDrive\ -\ Uniwersytet\ Łódzki/analiza\ w\ SPSS/kwestionariusz_dane.sav")


df_recode <- df %>% mutate(
  co_all = CowedługPanaijestnajbardziejatrakcyjneturystyczniewŁodzi
)


patterns <- c("Różnorodna architektura miejska",
              "Dziedzictwo poprzemysłowe miasta",
              "Obiekty kulturowe",
              "Sztuka uliczna",
              "Szeroka oferta wydarzeń kulturalnych miasta",
              "Łódź filmowa",
              "Oferta gastronomiczna",
              "Dziedzictwo żydowskie",
              "Łódź wielokulturowa",
              "Duża ilość terenów zieleni miejskiej",
              "Inne")


df_recode <- df_recode %>% 
  mutate(co_architektura = str_detect(co_all, patterns[1]))


df_recode %>% count(co_architektura) #good :) 

df_recode <- df_recode %>% 
  mutate(co_poprzemysl = str_detect(co_all, patterns[2]), 
         co_obiekty_kult = str_detect(co_all, patterns[3]), 
         co_sztuka_ul = str_detect(co_all, patterns[4]), 
         co_szeroka_oferta = str_detect(co_all, patterns[5]), 
         co_filomowa = str_detect(co_all, patterns[6]), 
         co_gastro = str_detect(co_all, patterns[7]), 
         co_zydowskie = str_detect(co_all, patterns[8]),
         co_wielokult = str_detect(co_all, patterns[9]), 
         co_duzo_zieleni = str_detect(co_all, patterns[10]),
         co_inne = str_detect(co_all, patterns[11]))


df_recode %>% count(co_gastro, zamieszkanie)
df_recode %>% count(co_obiekty_kult)
df_recode %>% count(co_sztuka_ul)

haven::write_sav(df_recode,
                 "/Users/remek/OneDrive\ -\ Uniwersytet\ Łódzki/analiza\ w\ SPSS/fix_recoded_kwestionariusz_dane.sav")



