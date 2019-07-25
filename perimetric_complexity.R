PerimetricComplexity <- function(image.path = "itemImages/",
                                 output.file.name = "output_file.Rda", 
                                 add.pi = TRUE){


file.names <- list.files(path = image.path)

ink.complexity.df <- data.frame(item.id = file.names)
ink.complexity.df$item.id <- as.character(ink.complexity.df$item.id)
ink.complexity.df$complexity <- NA

for (file.counter in 1:length(file.names)){

# Imports png image, 
# extracts one of the three matrices (RGB) 
# rounds values to 1 or 0
# Invertes image, so that 1 represents "ink" and 0 "paper"
item.image <- readPNG(paste(image.path, file.names[file.counter], sep="/"))
item.image <- round(item.image@.Data[,,1],0)
item.image <- abs(item.image-1)

# Moves image matrix to 8 different directions
item.image.left <- rbind(item.image[-1,], 0)
item.image.left.down <- cbind(0, item.image.left[,-ncol(item.image.left)])
item.image.left.up <- cbind(item.image.left[,-1], 0)
item.image.right <- rbind(0,item.image[-nrow(item.image),])
item.image.right.down <- cbind(0,item.image.right[,-ncol(item.image.right)])
item.image.right.up <- cbind(item.image.right[,-1], 0)
item.image.up <- cbind(0, item.image[,-ncol(item.image)])
item.image.down <- cbind(item.image[,-1], 0)

# Combines the shifted images into one matrix
item.image.all <- (item.image + 
                     item.image.up +
                     item.image.right +
                     item.image.right.down + 
                     item.image.right.up +
                     item.image.down +
                     item.image.left +
                     item.image.left.down + 
                     item.image.left.up)
# Recodes overlapping pixels to 1
item.image.all[item.image.all > 1] <- 1

# Subtracts the enlarged image from the original image, which
# creates a one pixel outline
outline.image <- item.image.all - item.image

# See Pelli et al., (2006) single pixels of a diagonal do not represent 
# line length, therefore adding pixels to three pixel thick outline
outline.image.left <- rbind(outline.image[-1,], 0)
outline.image.right <- rbind(0,outline.image[-nrow(outline.image),])
outline.image.up <- cbind(0, outline.image[,-ncol(outline.image)])
outline.image.down <- cbind(outline.image[,-1], 0)

outline.image.thicker <- (outline.image +
                            outline.image.up +
                            outline.image.down +
                            outline.image.left + 
                            outline.image.right)
outline.image.thicker[outline.image.thicker > 1] <- 1 

# sanity check displays image
# grid::grid.raster(item.image)

p <- length(which(outline.image.thicker == 1))/3
a <- length(which(item.image == 1))

# See paper 
if(add.pi == T){
  ink.complexity <- p^2/(a*4*pi)
}else{
  ink.complexity <- p^2/a
  }
ink.complexity.df$complexity[ink.complexity.df$item.id == file.names[file.counter]] <- ink.complexity

}
save(ink.complexity.df, file = output.file.name)

}
