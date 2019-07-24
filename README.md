imWo 
================
images of words and more
---------------

### Preparations
Download the zip file from github, unzip, define working directory, and run
the code below.

``` r
source("create_word_images.R") 
source("perimetric_complexity.R")

library(png)
library(readr)
library(readxl)

# Under Windows font problems were solved by defining font
# family explicitly beforehand 
windowsFonts(Arial=windowsFont("TT Arial"))
windowsFonts(Times=windowsFont("TT Times New Roman"))
windowsFonts(Courier= windowsFont("TT Courier New"))
```



### Example import Hindi words from text file
``` r
hindi <- data.frame(read_csv("Hindi_tv.txt", col_names = FALSE))
# the encoding of file names will most proably cause trouble, thats why...
hindi$item.label <- 1:nrow(hindi) # for optional file name in case of encoding issues
```

### Example import German letters from text file
``` r
german <- data.frame(read_csv("alphabet_german.txt", col_names = FALSE))
german$item.label <- 1:nrow(german) # for optional file name in case of encoding issues
```

### Example import Hebrew letters (works best with Excel files)
``` r
hebrew <- read_excel("hebrew_alephbet.xlsx")
```
---------------

# Creates images of words
The function CreateWordImages() takes several - rather self-explanatory arguments for image appearance. Important: provide a name of the data frame from which letters or words should be taken (items.df) and written into png-files.
Not all operating systems allow UTF-8 file names, a workaround is to specify another column in your items.df that contains image.file names.
``` r
CreateWordImages(items.df = hebrew, # provide data frame name; see import options above
                 image.width = 5,
                 image.height = 1,
                 image.resolution = 150,
                 print.color = "black",
                 background.color = "white",
                 font.type = "Arial",
                 item.column = 1, # provide column index
                 file.name.extension = ".png",
                 file.name.column = 2,
                 file.name.encoding = "native")

```
# Computes perimetric complexity 
``` r
PerimetricComplexity(image.path = "itemImages/",
                     add.pi = TRUE, # perimetric complexity according to Pelli et al. (2006) or divided by 4π
                     output.file.name = "hebrew_complexity.Rda")
                     
  ```
