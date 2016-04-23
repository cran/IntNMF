\name{ConsensusMatPlot}
\alias{ConsensusMatPlot}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
A function to create image plot of the consensus matrix
}
\description{
Given the integrative NMF fit object, the function creates image plot of the consensus matrix ordered according to clusters groups. Cleaner block structure indicates stronger clusters. 
}
\usage{
ConsensusMatPlot(fit, rowLab = TRUE, colLab = TRUE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{fit}{
A nmf.mnnals fit object 
}
  \item{rowLab}{
If true row label is displayed. Default is true.
}
  \item{colLab}{
If true column label is displayed. Default is true.
}
}

\value{
Image plot of the consensus matrix ordered according to cluster groups is returned.  
}
\references{
Brunnet J, Tamayo P Golub, T and Mesirov J (2004) Metagene and molecular pattern discovery using matrix factorization. PNAS, 101, 4164-4169

Monti S, Tamayo P, Mesirov J and Golup T (2003). Consesus Clustering: A resampling based method for class discovery and visualization of gene expression microarray data. Machine Learning J, 52:91-118. 
}
\author{
Prabhakar Chalise, Rama Raghavan, Brooke Fridley
}

\examples{

prop <- c(0.20,0.30,0.27,0.23)
effect <- 2.5
sim.D <- InterSIM(n.sample=100,cluster.sample.prop=prop,delta.methyl=effect,
delta.expr=effect,delta.protein=effect,p.DMP=0.25,p.DEG=NULL,p.DEP=NULL,
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
dat <- list(dat1,dat2,dat3)
fit <- nmf.mnnals(dat=dat,k=length(prop),maxiter=200,st.count=20,n.ini=15,ini.nndsvd=TRUE,
seed=TRUE)

ConsensusMatPlot(fit,rowLab=TRUE,colLab=TRUE)
 
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
