#This is a script that first splits the dataset by municipalities, can
#be included in the clean function later The second part of the script
#manually plots housing stock for the initial attempts to create a
#sidebar with several graphs

clean_plot <- function () { datafin =
  clean_housing_stock_data2(read_housing_stock_data2())

  #Splitting the dataset by municipalities for plotting each
  region_name <- paste0("Municipality of ", datafin$Regions)
  split_by_region <- split(datafin, region_name)

  #Plot with ggplot, but probably it is better to use plotly for
  #hovering and other interactive stuff.  At this point I know only
  #how to create each plot manually, we can create them all in a for
  #loop, but indexing dataframes is tricky and will require a lot of
  #coding Some example plots here, so I can see how to add them in a
  #sub-menu on shiny

  p1 = ggplot(data = split_by_region$`Municipality of Assen`,
    aes(x = year, y = `housing stock`)) + geom_line()+ geom_point()

  p2 = ggplot(data = split_by_region$`Municipality of Delfzijl`,
    aes(x = year, y = `housing stock`)) + geom_line()+ geom_point()

  p3 = ggplot(data = split_by_region$`Municipality of Emmen`,
    aes(x = year, y = `housing stock`)) + geom_line()+ geom_point()

  #This municipality has missing values for housing stock column p4 =
  ggplot(data = split_by_region$`Municipality of Het Hogeland`,
    aes(x = year, y = `housing stock`)) + geom_line()+ geom_point()

}
