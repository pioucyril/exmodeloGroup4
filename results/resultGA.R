dat=read.csv("test/population2155.csv")
dat$rescuedDynamicSlow = -dat$rescuedDynamicSlow
dat$rescuedDynamicFast = -dat$rescuedDynamicFast
dat2=dat[order(dat$rescuedDynamicSlow),]
plot(rescuedDynamicFast~rescuedDynamicSlow,data=dat2,type="l",xlim=c(0,60),ylim=c(0,125))

files=list.files(path="test/",pattern=".csv",full.names =T)
for(fi in files){
  dat=read.csv(fi)
  dat$rescuedDynamicSlow = -dat$rescuedDynamicSlow
  dat$rescuedDynamicFast = -dat$rescuedDynamicFast
  dat=dat[order(dat$rescuedDynamicSlow),]
  lines(dat$rescuedDynamicSlow,dat$rescuedDynamicFast,lwd=1)
}
lines(dat2$rescuedDynamicSlow,dat2$rescuedDynamicFast,col=2,lwd=2)