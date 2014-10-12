cumavg <- function(input)
{
  prevsum = input[1]
  count = 1
  cum_avg <- numeric()
  cum_avg <- append(cum_avg,prevsum)
  
  for(i in 2:length(input))
  {
    prevsum = prevsum + input[i]
    newavg = prevsum/i
    cum_avg <- append(cum_avg ,newavg)
  }
  return(cum_avg);
}

asf <- read.table("D:\\Semester 3\\GDM\\P2\\GDM\\P2\\metrics_code\\gmetrics\\amazon.small.gmetrics.csv",header=TRUE,sep=",")
dsf <- read.table("D:\\Semester 3\\GDM\\P2\\GDM\\P2\\metrics_code\\gmetrics\\dplb.small.gmetrics.csv",header=TRUE,sep=",")
ysf <- read.table("D:\\Semester 3\\GDM\\P2\\GDM\\P2\\metrics_code\\gmetrics\\youtube.small.gmetrics.csv",header=TRUE,sep=",")

asf_C <- asf[order(-Conductance),]
c_cum_avg <- cumavg(asf_C$Separability)

asf_F <- asf[order(-FlakeODF),]
f_cum_avg <- cumavg(asf_F$Separability)

asf_FOMD <- asf[order(-FOMD),]
fomd_cum_avg <- cumavg(asf_FOMD$Separability)

asf_tpr <- asf[order(-TPR),]
tpr_cum_avg <- cumavg(asf_tpr$Separability)

asf_cr <-  asf[order(-CutRatio),]
cr_cum_avg <- cumavg(asf_cr$Separability)

ymin <- min(min(c_cum_avg),min(f_cum_avg),min(fomd_cum_avg),min(cr_cum_avg),min(tpr_cum_avg))
ymax <- max(max(c_cum_avg),max(f_cum_avg),max(fomd_cum_avg),max(cr_cum_avg),max(tpr_cum_avg))

plot(seq(1:length(c_cum_avg)),c_cum_avg,type="b",col="blue",ylim=c(ymin,ymax),main="Amazon small(Separability)",xlab="Rank",ylab="cumulative avg")
lines(seq(1:length(f_cum_avg)),f_cum_avg,type="b",col="red")
lines(seq(1:length(fomd_cum_avg)),fomd_cum_avg,type="b",col="yellow")
lines(seq(1:length(tpr_cum_avg)),tpr_cum_avg,type="b",col="pink")
lines(seq(1:length(cr_cum_avg)),cr_cum_avg,type="b",col="green")
legend("topright",lty=c(1,1,1,1,1),col=c("blue","red","yellow","pink","green"),legend=c("Cond","FODF","FOMD","TPR","CR"))

c_cum_avg <- cumavg(asf_C$Density)
f_cum_avg <- cumavg(asf_F$Density)
fomd_cum_avg <- cumavg(asf_FOMD$Density)
tpr_cum_avg <- cumavg(asf_tpr$Density)
cr_cum_avg <- cumavg(asf_cr$Density)

ymin <- min(min(c_cum_avg),min(f_cum_avg),min(fomd_cum_avg),min(cr_cum_avg),min(tpr_cum_avg))
ymax <- max(max(c_cum_avg),max(f_cum_avg),max(fomd_cum_avg),max(cr_cum_avg),max(tpr_cum_avg))

plot(seq(1:length(c_cum_avg)),c_cum_avg,type="b",col="blue",ylim=c(ymin,ymax),main="Amazon small(Density)",xlab="Rank",ylab="cumulative avg")
lines(seq(1:length(f_cum_avg)),f_cum_avg,type="b",col="red")
lines(seq(1:length(fomd_cum_avg)),fomd_cum_avg,type="b",col="yellow")
lines(seq(1:length(tpr_cum_avg)),tpr_cum_avg,type="b",col="pink")
lines(seq(1:length(cr_cum_avg)),cr_cum_avg,type="b",col="green")
legend("topright",lty=c(1,1,1,1,1),col=c("blue","red","yellow","pink","green"),legend=c("Cond","FODF","FOMD","TPR","CR"))

c_cum_avg <- cumavg(asf_C$Cohesiveness)
f_cum_avg <- cumavg(asf_F$Cohesiveness)
fomd_cum_avg <- cumavg(asf_FOMD$Cohesiveness)
tpr_cum_avg <- cumavg(asf_tpr$Cohesiveness)
cr_cum_avg <- cumavg(asf_cr$Cohesiveness)

ymin <- min(min(c_cum_avg),min(f_cum_avg),min(fomd_cum_avg),min(cr_cum_avg),min(tpr_cum_avg))
ymax <- max(max(c_cum_avg),max(f_cum_avg),max(fomd_cum_avg),max(cr_cum_avg),max(tpr_cum_avg))

plot(seq(1:length(c_cum_avg)),c_cum_avg,type="b",col="blue",ylim=c(ymin,ymax),main="Amazon small(Cohesiveness)",xlab="Rank",ylab="cumulative avg")
lines(seq(1:length(f_cum_avg)),f_cum_avg,type="b",col="red")
lines(seq(1:length(fomd_cum_avg)),fomd_cum_avg,type="b",col="yellow")
lines(seq(1:length(tpr_cum_avg)),tpr_cum_avg,type="b",col="pink")
lines(seq(1:length(cr_cum_avg)),cr_cum_avg,type="b",col="green")
legend("topright",lty=c(1,1,1,1,1),col=c("blue","red","yellow","pink","green"),legend=c("Cond","FODF","FOMD","TPR","CR"))

c_cum_avg <- cumavg(asf_C$ClusteringCoeff)
f_cum_avg <- cumavg(asf_F$ClusteringCoeff)
fomd_cum_avg <- cumavg(asf_FOMD$ClusteringCoeff)
tpr_cum_avg <- cumavg(asf_tpr$ClusteringCoeff)
cr_cum_avg <- cumavg(asf_cr$ClusteringCoeff)

ymin <- min(min(c_cum_avg),min(f_cum_avg),min(fomd_cum_avg),min(cr_cum_avg),min(tpr_cum_avg))
ymax <- max(max(c_cum_avg),max(f_cum_avg),max(fomd_cum_avg),max(cr_cum_avg),max(tpr_cum_avg))

plot(seq(1:length(c_cum_avg)),c_cum_avg,type="b",col="blue",ylim=c(ymin,ymax),main="Amazon small(Clustering coeff)",xlab="Rank",ylab="cumulative avg")
lines(seq(1:length(f_cum_avg)),f_cum_avg,type="b",col="red")
lines(seq(1:length(fomd_cum_avg)),fomd_cum_avg,type="b",col="yellow")
lines(seq(1:length(tpr_cum_avg)),tpr_cum_avg,type="b",col="pink")
lines(seq(1:length(cr_cum_avg)),cr_cum_avg,type="b",col="green")
legend("topright",lty=c(1,1,1,1,1),col=c("blue","red","yellow","pink","green"),legend=c("Cond","FODF","FOMD","TPR","CR"))

attach(dsf)
asf_C <- dsf[order(-Conductance),]
c_cum_avg <- cumavg(asf_C$Separability)

asf_F <- dsf[order(-FlakeODF),]
f_cum_avg <- cumavg(asf_F$Separability)

asf_FOMD <- dsf[order(-FOMD),]
fomd_cum_avg <- cumavg(asf_FOMD$Separability)

asf_tpr <- dsf[order(-TPR),]
tpr_cum_avg <- cumavg(asf_tpr$Separability)

asf_cr <-  dsf[order(-CutRatio),]
cr_cum_avg <- cumavg(asf_cr$Separability)

ymin <- min(min(c_cum_avg),min(f_cum_avg),min(fomd_cum_avg),min(cr_cum_avg),min(tpr_cum_avg))
ymax <- max(max(c_cum_avg),max(f_cum_avg),max(fomd_cum_avg),max(cr_cum_avg),max(tpr_cum_avg))

plot(seq(1:length(c_cum_avg)),c_cum_avg,type="b",col="blue",ylim=c(ymin,ymax),main="dplb small(Separability)",xlab="Rank",ylab="cumulative avg")
lines(seq(1:length(f_cum_avg)),f_cum_avg,type="b",col="red")
lines(seq(1:length(fomd_cum_avg)),fomd_cum_avg,type="b",col="yellow")
lines(seq(1:length(tpr_cum_avg)),tpr_cum_avg,type="b",col="pink")
lines(seq(1:length(cr_cum_avg)),cr_cum_avg,type="b",col="green")
legend("topright",lty=c(1,1,1,1,1),col=c("blue","red","yellow","pink","green"),legend=c("Cond","FODF","FOMD","TPR","CR"))

c_cum_avg <- cumavg(asf_C$Density)
f_cum_avg <- cumavg(asf_F$Density)
fomd_cum_avg <- cumavg(asf_FOMD$Density)
tpr_cum_avg <- cumavg(asf_tpr$Density)
cr_cum_avg <- cumavg(asf_cr$Density)

ymin <- min(min(c_cum_avg),min(f_cum_avg),min(fomd_cum_avg),min(cr_cum_avg),min(tpr_cum_avg))
ymax <- max(max(c_cum_avg),max(f_cum_avg),max(fomd_cum_avg),max(cr_cum_avg),max(tpr_cum_avg))

plot(seq(1:length(c_cum_avg)),c_cum_avg,type="b",col="blue",ylim=c(ymin,ymax),main="dplb small(Density)",xlab="Rank",ylab="cumulative avg")
lines(seq(1:length(f_cum_avg)),f_cum_avg,type="b",col="red")
lines(seq(1:length(fomd_cum_avg)),fomd_cum_avg,type="b",col="yellow")
lines(seq(1:length(tpr_cum_avg)),tpr_cum_avg,type="b",col="pink")
lines(seq(1:length(cr_cum_avg)),cr_cum_avg,type="b",col="green")
legend("topright",lty=c(1,1,1,1,1),col=c("blue","red","yellow","pink","green"),legend=c("Cond","FODF","FOMD","TPR","CR"))

c_cum_avg <- cumavg(asf_C$Cohesiveness)
f_cum_avg <- cumavg(asf_F$Cohesiveness)
fomd_cum_avg <- cumavg(asf_FOMD$Cohesiveness)
tpr_cum_avg <- cumavg(asf_tpr$Cohesiveness)
cr_cum_avg <- cumavg(asf_cr$Cohesiveness)

ymin <- min(min(c_cum_avg),min(f_cum_avg),min(fomd_cum_avg),min(cr_cum_avg),min(tpr_cum_avg))
ymax <- max(max(c_cum_avg),max(f_cum_avg),max(fomd_cum_avg),max(cr_cum_avg),max(tpr_cum_avg))

plot(seq(1:length(c_cum_avg)),c_cum_avg,type="b",col="blue",ylim=c(ymin,ymax),main="dplb small(Cohesiveness)",xlab="Rank",ylab="cumulative avg")
lines(seq(1:length(f_cum_avg)),f_cum_avg,type="b",col="red")
lines(seq(1:length(fomd_cum_avg)),fomd_cum_avg,type="b",col="yellow")
lines(seq(1:length(tpr_cum_avg)),tpr_cum_avg,type="b",col="pink")
lines(seq(1:length(cr_cum_avg)),cr_cum_avg,type="b",col="green")
legend("topright",lty=c(1,1,1,1,1),col=c("blue","red","yellow","pink","green"),legend=c("Cond","FODF","FOMD","TPR","CR"))

c_cum_avg <- cumavg(asf_C$ClusteringCoeff)
f_cum_avg <- cumavg(asf_F$ClusteringCoeff)
fomd_cum_avg <- cumavg(asf_FOMD$ClusteringCoeff)
tpr_cum_avg <- cumavg(asf_tpr$ClusteringCoeff)
cr_cum_avg <- cumavg(asf_cr$ClusteringCoeff)

ymin <- min(min(c_cum_avg),min(f_cum_avg),min(fomd_cum_avg),min(cr_cum_avg),min(tpr_cum_avg))
ymax <- max(max(c_cum_avg),max(f_cum_avg),max(fomd_cum_avg),max(cr_cum_avg),max(tpr_cum_avg))

plot(seq(1:length(c_cum_avg)),c_cum_avg,type="b",col="blue",ylim=c(ymin,ymax),main="dplb small(Clustering coeff)",xlab="Rank",ylab="cumulative avg")
lines(seq(1:length(f_cum_avg)),f_cum_avg,type="b",col="red")
lines(seq(1:length(fomd_cum_avg)),fomd_cum_avg,type="b",col="yellow")
lines(seq(1:length(tpr_cum_avg)),tpr_cum_avg,type="b",col="pink")
lines(seq(1:length(cr_cum_avg)),cr_cum_avg,type="b",col="green")
legend("topright",lty=c(1,1,1,1,1),col=c("blue","red","yellow","pink","green"),legend=c("Cond","FODF","FOMD","TPR","CR"))

attach(ysf)
asf_C <- ysf[order(-Conductance),]
c_cum_avg <- cumavg(asf_C$Separability)

asf_F <- ysf[order(-FlakeODF),]
f_cum_avg <- cumavg(asf_F$Separability)

asf_FOMD <- ysf[order(-FOMD),]
fomd_cum_avg <- cumavg(asf_FOMD$Separability)

asf_tpr <- ysf[order(-TPR),]
tpr_cum_avg <- cumavg(asf_tpr$Separability)

asf_cr <-  ysf[order(-CutRatio),]
cr_cum_avg <- cumavg(asf_cr$Separability)

ymin <- min(min(c_cum_avg),min(f_cum_avg),min(fomd_cum_avg),min(cr_cum_avg),min(tpr_cum_avg))
ymax <- max(max(c_cum_avg),max(f_cum_avg),max(fomd_cum_avg),max(cr_cum_avg),max(tpr_cum_avg))

plot(seq(1:length(c_cum_avg)),c_cum_avg,type="b",col="blue",ylim=c(ymin,ymax),main="youtube small(Separability)",xlab="Rank",ylab="cumulative avg")
lines(seq(1:length(f_cum_avg)),f_cum_avg,type="b",col="red")
lines(seq(1:length(fomd_cum_avg)),fomd_cum_avg,type="b",col="yellow")
lines(seq(1:length(tpr_cum_avg)),tpr_cum_avg,type="b",col="pink")
lines(seq(1:length(cr_cum_avg)),cr_cum_avg,type="b",col="green")
legend("topright",lty=c(1,1,1,1,1),col=c("blue","red","yellow","pink","green"),legend=c("Cond","FODF","FOMD","TPR","CR"))

c_cum_avg <- cumavg(asf_C$Density)
f_cum_avg <- cumavg(asf_F$Density)
fomd_cum_avg <- cumavg(asf_FOMD$Density)
tpr_cum_avg <- cumavg(asf_tpr$Density)
cr_cum_avg <- cumavg(asf_cr$Density)

ymin <- min(min(c_cum_avg),min(f_cum_avg),min(fomd_cum_avg),min(cr_cum_avg),min(tpr_cum_avg))
ymax <- max(max(c_cum_avg),max(f_cum_avg),max(fomd_cum_avg),max(cr_cum_avg),max(tpr_cum_avg))

plot(seq(1:length(c_cum_avg)),c_cum_avg,type="b",col="blue",ylim=c(ymin,ymax),main="youtube small(Density)",xlab="Rank",ylab="cumulative avg")
lines(seq(1:length(f_cum_avg)),f_cum_avg,type="b",col="red")
lines(seq(1:length(fomd_cum_avg)),fomd_cum_avg,type="b",col="yellow")
lines(seq(1:length(tpr_cum_avg)),tpr_cum_avg,type="b",col="pink")
lines(seq(1:length(cr_cum_avg)),cr_cum_avg,type="b",col="green")
legend("topright",lty=c(1,1,1,1,1),col=c("blue","red","yellow","pink","green"),legend=c("Cond","FODF","FOMD","TPR","CR"))

c_cum_avg <- cumavg(asf_C$Cohesiveness)
f_cum_avg <- cumavg(asf_F$Cohesiveness)
fomd_cum_avg <- cumavg(asf_FOMD$Cohesiveness)
tpr_cum_avg <- cumavg(asf_tpr$Cohesiveness)
cr_cum_avg <- cumavg(asf_cr$Cohesiveness)

ymin <- min(min(c_cum_avg),min(f_cum_avg),min(fomd_cum_avg),min(cr_cum_avg),min(tpr_cum_avg))
ymax <- max(max(c_cum_avg),max(f_cum_avg),max(fomd_cum_avg),max(cr_cum_avg),max(tpr_cum_avg))

plot(seq(1:length(c_cum_avg)),c_cum_avg,type="b",col="blue",ylim=c(ymin,ymax),main="youtube small(Cohesiveness)",xlab="Rank",ylab="cumulative avg")
lines(seq(1:length(f_cum_avg)),f_cum_avg,type="b",col="red")
lines(seq(1:length(fomd_cum_avg)),fomd_cum_avg,type="b",col="yellow")
lines(seq(1:length(tpr_cum_avg)),tpr_cum_avg,type="b",col="pink")
lines(seq(1:length(cr_cum_avg)),cr_cum_avg,type="b",col="green")
legend("topright",lty=c(1,1,1,1,1),col=c("blue","red","yellow","pink","green"),legend=c("Cond","FODF","FOMD","TPR","CR"))

c_cum_avg <- cumavg(asf_C$ClusteringCoeff)
f_cum_avg <- cumavg(asf_F$ClusteringCoeff)
fomd_cum_avg <- cumavg(asf_FOMD$ClusteringCoeff)
tpr_cum_avg <- cumavg(asf_tpr$ClusteringCoeff)
cr_cum_avg <- cumavg(asf_cr$ClusteringCoeff)

ymin <- min(min(c_cum_avg),min(f_cum_avg),min(fomd_cum_avg),min(cr_cum_avg),min(tpr_cum_avg))
ymax <- max(max(c_cum_avg),max(f_cum_avg),max(fomd_cum_avg),max(cr_cum_avg),max(tpr_cum_avg))

plot(seq(1:length(c_cum_avg)),c_cum_avg,type="b",col="blue",ylim=c(ymin,ymax),main="youtube small(Clustering coeff)",xlab="Rank",ylab="cumulative avg")
lines(seq(1:length(f_cum_avg)),f_cum_avg,type="b",col="red")
lines(seq(1:length(fomd_cum_avg)),fomd_cum_avg,type="b",col="yellow")
lines(seq(1:length(tpr_cum_avg)),tpr_cum_avg,type="b",col="pink")
lines(seq(1:length(cr_cum_avg)),cr_cum_avg,type="b",col="green")
legend("topright",lty=c(1,1,1,1,1),col=c("blue","red","yellow","pink","green"),legend=c("Cond","FODF","FOMD","TPR","CR"))