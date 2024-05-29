cplx <- list(1,2,3,4,5,6,c(1,2),c(2,3),c(3,4),c(4,5),c(5,6))
cplxf1 <- c(0,1,2,3,9,0)
cplxf2 <- c(1,12,2,0,1,0)
# for f1
filt1 <- funFiltration(cplxf1,cplx)
diag1 <- filtrationDiag(filt1,maxdimension=2)
diag1$diagram
# for f2
filt2 <- funFiltration(cplxf2,cplx)
diag2 <- filtrationDiag(filt2,maxdimension=2)
diag2$diagram

# plot the persistence diagrams from each filtration
plot(diag1[["diagram"]])
plot(diag2[["diagram"]])

#plot the barcodes from each filtration
plot(diag1[["diagram"]], barcode=TRUE)
plot(diag2[["diagram"]], barcode=TRUE)

diag1$diagram
plot(diag1[["diagram"]])
diag2$diagram

n=20
vals <- array(runif(n*n),c(n,n))
image(vals)

myfilt <- gridFiltration(FUNvalues=vals, sublevel = TRUE, printProgress = TRUE)
diag1 <- gridDiag(FUNvalues=vals, sublevel = TRUE, printProgress = TRUE)
plot(diag1[["diagram"]])

vals <- array(runif(n*n),c(n,n))
image(vals)

myfilt <- gridFiltration(FUNvalues=vals, sublevel = TRUE, printProgress = TRUE)
diag2 <- gridDiag(FUNvalues=vals, sublevel = TRUE, printProgress = TRUE)
plot(diag2[["diagram"]])
bottleneck(Diag1 = diag1$diagram, Diag2 = diag2$diagram, dimension = 1)
