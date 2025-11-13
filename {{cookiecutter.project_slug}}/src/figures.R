###########################################################################
#
#                            figures
#
###########################################################################
# Author: Matthew Muller
# Script Name: figures
# Output directory:
experiment <- "figures"
outdir <- file.path("output", experiment)
dir.create(outdir, showWarnings = FALSE)

#======================== LIBRARIES ========================
library(tidyverse)
library(glue)
library(rmatt)

#======================== CODE ========================










#======================== END ========================
writeLines(capture.output(sessionInfo()), file.path(outdir, "session.log"))
save.image(file.path(outdir, "session.RData"))