
CreateWordImages <- function(items.df,
                             image.width = 5,
                             image.height = 1,
                             image.resolution = 150,
                             print.color = "black",
                             background.color = "white",
                             item.column = 1,
                             font.type = "Courier",
                             file.name.extension = ".png",
                             file.name.column = 2,
                             file.name.encoding = "UTF-8"){

# Creates empty folder to save word image files 
dir.create("itemImages/")
# Define path for item images
item.image.path = "itemImages/"

# Loops through word list
for(item.counter in 1 : nrow(items.df)){
  
#  Prepares file name
  item.image.name <- paste(item.image.path,items.df[item.counter,file.name.column],
                             file.name.extension, sep="")

  if(file.name.encoding == "native"){
    item.image.name <- enc2native(item.image.name)
  }
  if(file.name.encoding == "UTF-8"){
    item.image.name <- enc2utf8(item.image.name)
  } 

  # Plots into png device
  png(item.image.name, width = image.width, height = image.height,
      units = "in", res = image.resolution, bg = background.color)
  par(mar = c(0,0,0,0), family= font.type)
  plot(c(0, 1), c(0, 1), ann = F, bty = 'n', type = 'n', xaxt = 'n',
       yaxt = 'n')
  text(x = 0.5, y=0.8, items.df[item.counter,item.column], cex = 4, 
       col = print.color, pos = 1)
  
  dev.off()
  
}
}
