\name{nmf.mnnals}
\alias{nmf.mnnals}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Nonnegative Matrix Factorization of Multiple data using Nonnegative Alternating Least Square
}
\description{
Given a single or multiple types of datasets (e.g. DNA methylation, mRNA expression, protein expression, DNA copy number) measured on same set of samples and pre-defined number of clusters, the function carries out clustering of the samples together with cluster membership assignment to the samples utilizing all the data set in a single comprehensive step.
}
\usage{
nmf.mnnals(dat = dat, k = k, maxiter = 200, st.count = 20, n.ini = 30, ini.nndsvd = TRUE,
seed = TRUE,wt=if(is.list(dat)) rep(1,length(dat)) else 1)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{dat}{
	A single data or a list of multiple data matrices measured on same set of samples. For each data matrix in the list, samples should be on rows and genomic features should be on columns.
}
  \item{k}{
Number of clusters
}
  \item{maxiter}{
Maximum number of iteration, default is 200.
}
  \item{st.count}{
Count for stability in connectivity matrix, default is 20.
}
  \item{n.ini}{
Number of initializations of the random matrices, default is 30.
}
  \item{ini.nndsvd}{
Initialization of the Hi matrices using non negative double singular value decomposition (NNDSVD). If true, one of the initializations of algorithm will use NNDSVD. Default is TRUE.
}
  \item{seed}{
Random seed for initialization of algorithm, default is TRUE
}
   \item{wt}{
Weight, default is 1 for each data.
}
}

\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...

 \item{consensus}{Consensus matrix}
 \item{W}{Common basis matrix across the multiple data sets}
 \item{H}{List of data specific coefficient matrices.}
 \item{convergence}{Matrix with five columns and number of rows equal to number of iterative steps required to converge the algorithm or number of maximum iteration. The five columns represent number of iterations, count for stability in connectivity matrix, stability indicator (1/0), absolute difference in reconstruction error between ith and (i-1)th iteration and value of the objective function respectively.}
 \item{min.f.WH}{Collection of values of objective function at convergence for each initialization of the algorithm.}
 \item{clusters}{Cluster membership assignment to samples.}

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
#make.plot=TRUE, progress=TRUE)
# Find clustering assignment for the samples
fit <- nmf.mnnals(dat=dat, k=length(prop), maxiter=200, st.count=20, n.ini=15,
ini.nndsvd=TRUE, seed=TRUE)
table(fit$clusters)
fit$clusters[1:10]
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
