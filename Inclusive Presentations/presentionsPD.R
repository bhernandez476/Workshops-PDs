
# load packages ------------------------------------------------------
library(ggplot2)
library(extrafont)
extrafont::font_import()

getwd()
setwd("/Users/bah17005/Desktop/")


approve <- read.csv("approval_polllist.csv", header = TRUE)



# base plots ------------------------------------------------------
# ggplot inputs are additive, so we'll add on layers to change features
# these are the base plots: bar & scatter

# bar plot:
# geom_bar data needs to come from a data frame
polls <- as.data.frame(table(approve$pollster))

ggplot(data = polls[1:10, ], aes(x = Var1, y = Freq)) +
  geom_bar(stat = "identity")

ggplot(data = approve[1:100, ], aes(x = adjusted_approve, y = approve)) +
  geom_point()

# sample additions
ggplot(data = approve[1:100, ], aes(x = adjusted_approve, y = approve)) +
  geom_point() +
  scale_y_continuous(name="Stopping distance", limits=c(0, 100)) +
  scale_x_continuous(name="Stopping distance", limits=c(0, 100))

ggplot(data = approve[1:100, ], aes(x = adjusted_approve, y = approve)) +
  geom_point() +
  scale_y_continuous(name="Approve", limits=c(40, 70)) +
  scale_x_continuous(name="Adjusted", limits=c(40, 70)) +
  geom_abline(intercept = 0, slope = 1)



# color palattes ------------------------------------------------------
# http://www.cookbook-r.com/Graphs/Colors_(ggplot2)/
# https://coolors.co/ee6352-067291-f4e8ef-57a773-484d6d 
# https://www.sessions.edu/color-calculator/
# https://brand.uconn.edu/guidelines-usage/color-palette/

# change colors by name
ggplot(data = polls[1:10, ], aes(x = Var1, y = Freq)) +
  geom_bar(stat = "identity", color = "red", fill = "blue")

# changing colors by hex code
ggplot(data = polls[1:10, ], aes(x = Var1, y = Freq)) +
  geom_bar(stat = "identity", color = "#0072B2", fill = "#E69F00")

# change color based on characteristic
# changing population to 2 groups
table(approve$population)
approve$population[approve$population == "lv"] <- "v"
approve$population[approve$population == "rv"] <- "v"

ggplot(data = approve[1:100, ], aes(x = adjusted_approve, y = approve, color = population)) +
  geom_point()

ggplot(data = approve[1:100, ], aes(x = adjusted_approve, y = approve, color = population)) +
  geom_point() +
  scale_color_manual(values = c("#0072B2", "#E69F00"))



# you might want to sometimes use color palettes that aren't the most inclusive
# in those cases you want an additional way to designate group differences
# e.g., line dashes, shapes, etc.

# shapes:
# https://blog.albertkuo.me/post/point-shape-options-in-ggplot/

# change the point shape
ggplot(data = approve[1:100, ], aes(x = adjusted_approve, y = approve, color = population, shape = population)) +
  geom_point() +
  scale_color_manual(values = c("#0072B2", "#E69F00")) +
  scale_shape_manual(values = c(20, 23))



# fonts ------------------------------------------------------
# be simple and consistent with fonts
# for choosing fonts:
# https://www.andrewheiss.com/blog/2017/09/27/working-with-r-cairo-graphics-custom-fonts-and-ggplot/
# https://www.canva.com/learn/the-ultimate-guide-to-font-pairing/
# https://www.bdadyslexia.org.uk/advice/employers/creating-a-dyslexia-friendly-workplace/dyslexia-friendly-style-guide

# changing fonts in r
# first make the labels clearer
ggplot(data = polls[1:10,], aes(x = Var1, y = Freq)) +
  geom_bar(stat = "identity", color = "#0072B2", fill = "#E69F00") + 
  theme(axis.text.x = element_text(face = "bold", color = "#0072B2", size = 12, angle = 45, hjust = 1))

ggplot(data = polls[1:10,], aes(x = Var1, y = Freq)) +
  geom_bar(stat = "identity", color = "#0072B2", fill = "#E69F00") + 
  theme(axis.text.x = element_text(face = "bold", color = "#0072B2", size = 12, angle = 45, hjust = 1, family = "Times New Roman"))

# not all fonts will be accessible in r




# save file ------------------------------------------------------
# file formats 
# use .png (not .jpeg)
# ideal resolution: 300 DPI
# transparent backgrounds

ggplot(data = polls[1:10,], aes(x = Var1, y = Freq)) +
  geom_bar(stat = "identity", color = "#0072B2", fill = "#E69F00") + 
  theme(axis.text.x = element_text(face = "bold", color = "#0072B2", size = 12, angle = 45, hjust = 1, family = "Times New Roman"),
        panel.background = element_rect(fill='transparent'), #transparent panel bg
        plot.background = element_rect(fill='transparent', color=NA), #transparent plot bg
        #panel.grid.major = element_blank(), #remove major gridlines
        panel.grid.minor = element_blank(), #remove minor gridlines
        legend.background = element_rect(fill='transparent'), #transparent legend bg
        legend.box.background = element_rect(fill='transparent') #transparent legend panel
        )

# save the most recent plot to the working directory
ggsave('myplot.png', dpi = 300, bg='transparent')


# after saving ------------------------------------------------------

# check how accessible the plots are for color blinded audience members
# http://www.color-blindness.com/coblis-color-blindness-simulator/

# add alt text descriptions for visually impaired
# alt text: https://www.perkinselearning.org/technology/blog/how-write-alt-text-and-image-descriptions-visually-impaired

# convert from rgb to cmyk
# https://www.rgb2cmyk.org






