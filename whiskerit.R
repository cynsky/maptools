if(!require("stringr")) install.packages("stringr", repos = "http://cran.rstudio.com")
if(!require("whisker")) install.packages("whisker", repos = "http://cran.rstudio.com")

library("stringr"); library("whisker")

pattern <- "pkg>[A-Za-z0-9]+|pkg>[A-Za-z0-9]+\\.[A-Za-z0-9]+|pkg>[A-Za-z0-9]+\\.[A-Za-z0-9]+\\.[A-Za-z0-9]+"
out <- paste0(readLines("tools.ctv"), collapse = " ")
pkgs <- str_extract_all(out, pattern)[[1]]
pkgs <- unique(gsub("^pkg>", "", pkgs))
pkgs <- pkgs[ !pkgs %in% c('sp') ]
pkgs <- sort(pkgs)
pkgs <- as.list(pkgs)
pkgs <- lapply(pkgs, function(x) list(package=x))
template <- readLines("tools.ctv")
writeLines(whisker.render(template), "MappingTools.ctv")
