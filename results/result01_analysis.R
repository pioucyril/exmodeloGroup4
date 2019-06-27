dat=read.csv("result01.csv")

nbSlow = seq(0, 125, by =25)
hRs1 = seq(0.1,0.4, by =0.1)
hIp1 = seq(0.1, 1.0, by =0.1)

opt=list(param=c(0,0.1,0.1),rDm=0)

pdf("results01.pdf",height=8,width=6)
par(mfrow=c(3,2))
times=seq(0,500,by=20)
for(hIp in hIp1){
   for(hRs in hRs1){
      for(nb in nbSlow){
         sdat=dat[dat$hIp1 == hIp & dat$hRs1 == hRs & dat$nbSlow == nb,]
         plot(times, sdat$rescuedDynamicMed,lwd=2,col=1,xlab='time',main=paste("nb",nb,"hRs",hRs,"hIp",hIp,sep=" "),type="l",ylim=c(0,100))
         lines(times,sdat$rescuedDynamicMax,lwd=1,lty=2)
         lines(times,sdat$rescuedDynamicMin,lwd=1,lty=2)
         
         lines(times,sdat$rescuedDynamicFastMed,lwd=2,lty=1,col=3)
         lines(times,sdat$rescuedDynamicSlowMed,lwd=2,lty=1,col=2)         

         lines(times,sdat$zombifiedDynamicMed,lwd=2,lty=1,col="gray")        
         if(opt$rDm<sum(sdat$rescuedDynamicMed)){
            opt=list(param=c(nb,hRs,hIp),rDm=sum(sdat$rescuedDynamicMed))
         }
      }
   }
}
dev.off()


#library(rgl)
#
#plot3d(nbSlow,hRs1,hIp1)