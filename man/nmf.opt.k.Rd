\name{nmf.opt.k}
\alias{nmf.opt.k}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Selection of optimum number of clusters (k)
}
\description{
Given a single or multiple types of datasets (e.g. DNA methylation, mRNA expression, protein expression, DNA copy number) measured on same set of samples, the function finds optimum number of clusters for the data or dataset.
}
\usage{
nmf.opt.k(dat = dat, n.runs = 30, n.fold = 5, k.range = 2:8, result = TRUE,
make.plot = TRUE, progress = TRUE, st.count = 10, maxiter = 100,
wt=if(is.list(dat)) rep(1,length(dat)) else 1)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{dat}{
A single data or list of multiple types of data set measured on same set of samples. For each data matrix in the list, samples should be on rows and genomic features should be on columns.
}
  \item{n.runs}{
Number of runs of algorithm in order to find optimum number of clusters, default is 30.
}
  \item{n.fold}{
Number of folds for k-fold cross-validation, default is 5.
}
  \item{k.range}{
Search range for optimum number of clusters, default is 2:8
}
  \item{result}{
Logical, to display the result-matrix, default is TRUE.
}
  \item{make.plot}{
Logical, to display the plot of cluster prediction index vs search range of clusters, default is TRUE
}
  \item{progress}{
Logical, to display the progress (in percentage) of the algorithm, default is TRUE
}
  \item{st.count}{
Count for stability in connectivity matrix, default is 10.
}
  \item{maxiter}{
Maximum number of iteration, default is 100.
}
   \item{wt}{
Weight, default is 1 for each data.
}
}
\value{
The function returns a matrix of cluster prediction index (CPI) values for each run (columns) over the search range of number of clusters (rows). The function also generates plot of CPI over the search range of number of clusters.
}
\author{
Prabhakar Chalise, Rama Raghavan, Brooke Fridley
}
\references{
Chalise P and Fridley B (2017). Integrative clustering of multi-level 'omic data based on non-negative matrix factorization algorithm. PLOS ONE, 12(5), e0176278.

Chalise P, Raghavan R and Fridley B (2016). InterSIM: Simulation tool for multiple integrative 'omic datasets. Computer Methods and Programs in Biomedicine, 128:69-74.
}
\examples{
#### Simulation of three interrelated dataset
#prop <- c(0.65,0.35)
#prop <- c(0.30,0.40,0.30)
prop <- c(0.20,0.30,0.27,0.23)
effect <- 2.5

library(InterSIM)
sim.D <- InterSIM(n.sample=100, cluster.sample.prop=prop, delta.methyl=effect,
delta.expr=effect, delta.protein=effect, p.DMP=0.25, p.DEG=NULL, p.DEP=NULL,
do.plot=FALSE, sample.cluster=TRUE, feature.cluster=TRUE)
dat1 <- sim.D$dat.methyl
dat2 <- sim.D$dat.expr
dat3 <- sim.D$dat.protein
true.cluster.assignment <- sim.D$clustering.assignment

## Make all data positive by shifting to positive direction.
## Also rescale the datasets so that they are comparable.
if (!all(dat1>=0)) dat1 <- pmax(dat1 + abs(min(dat1)), .Machine$double.eps)
dat1 <- dat1/max(dat1)
if (!all(dat2>=0)) dat2 <- pmax(dat2 + abs(min(dat2)), .Machine$double.eps)
dat2 <- dat2/max(dat2)
if (!all(dat3>=0)) dat3 <- pmax(dat3 + abs(min(dat3)), .Machine$double.eps)
dat3 <- dat3/max(dat3)
# The function nmf.mnnals requires the samples to be on rows and variables on columns.
dat1[1:5,1:5]
dat2[1:5,1:5]
dat3[1:5,1:5]
dat <- list(dat1,dat2,dat3)

# Find optimum number of clusters for the data
#opt.k <- nmf.opt.k(dat=dat, n.runs=5, n.fold=5, k.range=2:7, result=TRUE,
#make.plot=TRUE,progress=TRUE)
}
