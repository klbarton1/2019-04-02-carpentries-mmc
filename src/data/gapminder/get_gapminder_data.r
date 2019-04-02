# Download the Gapminder data for analysis
#
#
library(here)

file_url <- "https://raw.githubusercontent.com/swcarpentry/r-novice-gapminder/gh-pages/_episodes_rmd/data/gapminder_data.csv"
download.file(url= file_url, destfile = here ("data/gapminder/raw/gapminder_data.csv"))

gap_wide <- gapminder %>%
  gather(key = 'key', value = 'value', c('pop', 'lifeExp', 'gdpPercap')) %>%
  mutate(year_var = paste(key, year, sep = '_')) %>%
  select(country, continent, year_var, value) %>%
  spread(key = 'year_var', value = 'value')
str(gapminder)
skimr:: skim(gapminder)


gap_long <- gap_wide %>%
  gather(key= 'obstype_year', value= 'obs_values', starts_with('pop'),
         starts_with('lifeExp'), starts_with('gdpPercap'))
skimr ::skim(gap_long)

gap_long <- gap_wide %>% gather(obstype_year,obs_values,-continent,-country)
str(gap_long)

gap_long <- gap_long %>% separate(obstype_year,into=c('obs_type','year'),sep="_")
gap_long$year <- as.integer(gap_long$year)


gap_summary<- gap_long %>%
  group_by(continent, obs_type) %>%
  summarize(means=mean(obs_values))

gap_normal <- gap_long %>% spread(obs_type,obs_values)
dim(gap_normal)

dim(gapminder)

names(gap_normal)

names(gapminder)
  
gap_normal <- gap_normal[,names(gapminder)]
all.equal(gap_normal,gapminder)

gap_normal <- gap_normal %>% arrange(country,continent,year)
all.equal(gap_normal,gapminder)

gap_temp <- gap_long %>% unite(var_ID,continent,country,sep="_")
str(gap_temp)

gap_temp <- gap_long %>%
  unite(ID_var,continent,country,sep="_") %>%
  unite(var_names,obs_type,year,sep="_")
str(gap_temp)

gap_wide_new <- gap_long %>%
  unite(ID_var,continent,country,sep="_") %>%
  unite(var_names,obs_type,year,sep="_") %>%
  spread(var_names,obs_values)
str(gap_wide_new)

gap_ludicrously_wide <- gap_long %>%
  unite(var_names,obs_type,year,country,sep="_") %>%
  spread(var_names,obs_values)

