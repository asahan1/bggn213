#Class 5 Data Visualization

#Base R plot
plot(1:5)


#for prettier plots, we will use ggplot2 (already installed)
#install.packages("ggplot2")
library(ggplot2)

plot(cars)

p <- ggplot(cars) +
  aes(speed,dist) + 
  geom_point() + 
  geom_line() +
  geom_smooth() + 
  labs(title="distance vs speed", caption = "cars plot")

p


#RNA-seq plot

url <- "https://bioboot.github.io/bimm143_S20/class-material/up_down_expression.txt"
genes <- read.delim(url)
head(genes)

nrow(genes)

colnames(genes)
ncol(genes)
table(genes$State)

p <- ggplot(genes,
       aes(Condition1, Condition2, col = State)) +
       geom_point(alpha = 0.2)
p

p<- p + scale_colour_manual( values=c("blue","gray","red") )+ 
  labs(title = "Gene Expression Changes Upon Drug Treatment", xlabs = "Control(no drug)", ylabs = "Drug Treatment")

p

#gapminder optional part
#install("gapminder")
library(gapminder)
library(dplyr)

gapminder_2007 <- gapminder %>% filter(year==2007)

ggplot(gapminder_2007,aes(gdpPercap, lifeExp, color=continent, size = pop))+
  geom_point(alpha=0.5)

ggplot(gapminder_2007) + 
  aes(x = gdpPercap, y = lifeExp, color = pop) +
  geom_point(alpha=0.8) +
  scale_size_area(max_size = 10)

gapminder_1957 <- gapminder %>% filter(year==1957 | year ==2007)

ggplot(gapminder_1957) + 
  aes(x = gdpPercap, y = lifeExp, color = continent, size = pop) +
  geom_point(alpha=0.8) +
  scale_size_area(max_size = 10) +
  facet_wrap(~year)

#bar charts
gapminder_top5 <- gapminder %>% 
  filter(year==2007) %>% 
  arrange(desc(pop)) %>% 
  top_n(5, pop)

gapminder_top5

p1 <- ggplot(gapminder_top5) + 
  geom_col(aes(x = country, y = pop, fill = continent))

p2 <- ggplot(gapminder_top5) + 
  geom_col(aes(x = country, y = pop, fill = lifeExp))


p3 <- ggplot(gapminder_top5) + 
  geom_col(aes(x = country, y = pop, fill = gdpPercap))


p4 <- ggplot(gapminder_top5) + 
  geom_col(aes(x = reorder(country, +pop), y = pop, fill = gdpPercap))+
  coord_flip()

#load package patchwork to arrange multiple plots together
library(patchwork)
(p1 | p2 )/ ( p3 | p4)
# for making pdf report
#install.packages("tinytex")
#library(tinytex)
#install_tinytex()
