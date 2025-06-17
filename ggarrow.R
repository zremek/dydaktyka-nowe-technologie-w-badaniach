library(ggarrow)

p <- ggplot(whirlpool(5), aes(x, y, colour = group)) +
  coord_equal() +
  guides(colour = "none")
p + geom_arrow()

p + geom_arrow(aes(linewidth = I(arc))) # Identity scale for linewidth

ggplot(mtcars, aes(x = mpg, y = disp, colour = factor(gear))) + 
  geom_point() + 
  annotate_arrow(x = c(30, 20), y = c(350, 320), colour = "blue", linewidth = 2)


ggplot(mtcars, aes(x = wt, y = mpg)) + geom_point() +
  annotate_arrow("text", x = 4, y = 25, label = "Some text")


ggplot() +
  annotate_arrow(
    x = c(0, 1), y = c(0, 1),
    arrow_head = arrow_head_line(),
    arrow_fins = arrow_fins_line(),
    length_head = unit(5, "mm"),
    length_fins = unit(5, "mm"))
    