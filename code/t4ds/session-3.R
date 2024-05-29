install.packages("TDA")
library(TDA)

myFirstList <- list(1, TRUE, "There's a string in my list too!")

simpleK <- list(1, 2, c(1,2))
simpleK
K <- list(1,2,3,4,c(1,2),c(1,3),c(1,4),c(2,3),c(2,4),c(3,4),c(1,2,3))
K

x <- c(0,1,2,3)
y <- c(0,3,-1,2)
plot(x=x, y=y)

x <- c(0,1,2,3)
y <- c(0,3,-1,2)
X <- cbind(x,y)

# set largest allowed radius of balls < sqrt(5)
mymaxscale <- 2

# set other necessary parameters (more on those to come)
mymaxdimension <- 4
mydist <- "euclidean"
mylibrary <- "Dionysus"

# conduct Rips filtration
FltRips <- ripsFiltration(X = X, maxdimension = mymaxdimension,
                          maxscale = mymaxscale, dist = mydist, library = mylibrary,
                          printProgress = TRUE)

FltRips$cmplx

# set largest allowed radius of balls = sqrt(5)
maxscale <- sqrt(5)

# conduct Rips filtration
FltRips <- ripsFiltration(X = X, maxdimension = mymaxdimension,
                          maxscale = maxscale, dist = "euclidean", library = "Dionysus",
                          printProgress = TRUE)
FltRips$cmplx


maxscale_ex <- sqrt(13)
FltRips <- ripsFiltration(X = X, maxdimension = mymaxdimension,
                          maxscale = maxscale_ex, dist = "euclidean", library = "Dionysus",
                          printProgress = TRUE)
FltRips$cmplx

maxscale_exTwo <- sqrt(17)
FltRips <- ripsFiltration(X = X, maxdimension = mymaxdimension,
                          maxscale = maxscale_exTwo, dist = "euclidean", library = "Dionysus",
                          printProgress = TRUE)
FltRips$cmplx


n=20
vals <- array(runif(n*n),c(n,n))
image(vals)

newfcn <- function(x, y){jitter(-2*x^2+y^2+x+3*y-6*x+x*y,30)}
x <- seq(-5,5)
y <- seq(-5,5)
persp(x,y,outer(x,y,newfcn),zlab="height",theta=55,phi=25,col="palegreen1",shade=0.5)
myfilt <- gridFiltration(FUNvalues=vals, sublevel = TRUE, printProgress = TRUE)
myfilt$cmplx

persistDiag <- ripsDiag(X, maxdimension = 4, maxscale=sqrt(17), dist = mydist,
                        printProgress = TRUE)
plot(persistDiag[["diagram"]], barcode=TRUE)
persistDiag
plot(persistDiag[["diagram"]])

pd=gridDiag(FUNvalues = vals)
plot(pd[["diagram"]])

# create vertices
a <- 1; b=2; c=3
# edges
ac <- c(1,3); cb=c(2,3)
# a complex is a list of simplices
vcplx <- list(a,b,c,ac,cb)
x <-c(0,2,1)
y <- c(0,0,1)
vcoords <- cbind(x,y)
vvals <- c(0,0,1)
vfilt <- funFiltration(vvals,vcplx)
vdiag <- filtrationDiag(vfilt,maxdimension=2)
vdiag$diagram
