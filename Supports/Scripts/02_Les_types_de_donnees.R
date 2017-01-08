## ----defaults,results='hide',echo=FALSE----------------------------------
require(MASS,quietly=T,warn.conflicts=FALSE)
require(xtable,quietly=T,warn.conflicts=FALSE)
require(stringr,quietly=T,warn.conflicts=FALSE)
require(RSQLite,quietly=T,warn.conflicts=FALSE)
require(foreign,quietly=T,warn.conflicts=FALSE)
suppressPackageStartupMessages(require(XLConnect,quietly=T,warn.conflicts=FALSE))

opts_chunk$set(fig.path='graphiques/beamer-',fig.align='center',fig.show='hold',size='footnotesize',
               fig.height=7,fig.width=7,out.width="\\textwidth",resize.height="0.8\\textheight",
               tidy=FALSE,prompt=TRUE
               )

options(width=45)


## ------------------------------------------------------------------------
.Machine$integer.max

