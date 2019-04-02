#Make a plot of life expectancy in Africa
#Read in the data
gapminder<- readr::read_csv(here("data/gapminder/raw/gapminder_data.csv"))

mean(gapminder$gdpPercap[gapminder$continent =="Africa"])
mean(gapminder$gdpPercap[gapminder$continent =="Americas"])

library(tidyverse)

year_country_gdp <- select(gapminder, year, country, gdpPercap)

year_country_gdp <- gapminder %>%
  filter(continent =="Europe") %>%
  select(year, country, gdpPercap) 

  
africa <- gapminder %>%
  filter(continent =="Africa") %>%
  select (year, country, lifeExp)

gapminder %>%
  group_by(continent) %>%
  summarize(mean_val = mean(gdpPercap))

  
gapminder %>%
    group_by(country) %>%
    summarize(mean_val = mean(lifeExp))%>%
    arrange (mean_val) %>%
    filter(mean_lifeExp == min(mean_lifeExp) | mean_lifeExp == max(mean_lifeExp))

gapminder %>%
  group_by(country) %>%
  summarize(mean_val = mean(gdpPercap), 
            sd_gdpPercap = sd(gdpPercap))

gapminder %>%
  filter(continent == "Africa") %>%
  ggplot(aes(x = year, y= lifeExp, color= continent)) + 
  geom_line() +
  facet_wrap( ~country)
  



