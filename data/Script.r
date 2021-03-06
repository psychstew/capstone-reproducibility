setwd("~/Documents/PSY441/Capstone/Assignment/data")
politics<-read.csv("politics.csv")
head((politics$party=="independent")&
       (politics$sex!="female"))
str(politics)
politics[5,2]
politics[5,]
head(politics[,2])
tail(politics$income)
2
length(2)
head(1:66)
head(66:1)
a<-c(1:3,12,61,(length(politics$income)-2):length(politics$income))
 politics$income[a]
2==2
2==3
2!=3
head(politics$party)
head(politics$party=="independent")
head((politics$party=="independent")&
       (politics$sex!="female"))
head((politics$party=="independent")|
       (politics$party=="republican"))
head(politics$income[politics$testtime=="pre"])
head(politics$subject[politics$testtime=="pre"]==
       politics$subject[politics$testtime=="post"])
sum(1:3)
sum(!c(TRUE,TRUE,FALSE,FALSE,FALSE))
trues<-politics$testtime=="pre"
sum(!(politics$subject[trues]==politics$subject[!trues]))
sum(!(politics$party[trues]==politics$party[!trues]))
sum(!(politics$subject[trues]==politics$subject[!trues]))
sum(!(politics$sex[trues]==politics$sex[!trues]))
sum(!(politics$income[trues]==politics$income[!trues]))
str(politics)
incomes<-politics$income[trues]
summary(incomes)
min(incomes)
var(incomes)
sd(incomes)
sd(incomes)==sqrt(var(incomes))
biased<-sum((incomes-mean(incomes))^2)/length(incomes)
unbiased<-sum((incomes-mean(incomes))^2)/(length(incomes)-1)
var(incomes)==biased
var(incomes)==unbiased
hist(incomes)
library("dplyr")
library("ggplot2")
library("gplots")
pre=politics[trues,]
post=politics[!trues,]
mytable<-table(pre$party,pre$minwage)
mytable
write.table(mytable,"clipboard",sep="\t",col.names=NA)
margin.table(mytable,1) #Row margins
margin.table(mytable,2) #Column margins
chisq.test(pre$party,pre$minwage)
t.test(pre$optimism[pre$sex=="male"],
       pre$optimism[pre$sex=="female"],
       paired=FALSE, var.equal=FALSE,
       alternative="two.sided",
       conf.level=.95)
t.test(politics$optimism[(politics$testtime=="pre")&
                           (politics$party=="republican")],
       politics$optimism[(politics$testtime=="post")&
                             (politics$party=="republican")],
       paired=TRUE, conf.level=1-.05/3)
polsum<-politics%>%group_by(party,testtime)%>%arrange(party,testtime)%>%
  summarize(means=mean(optimismscore),
              sems=sd(optimismscore)/sqrt(length(optimismscore)))
polsum
pubs<-polsum[polsum$party=="republican",]
pubs
fig<-ggplot(pubs,aes(x=factor(testtime),y=means))
fig<-fig + geom_bar(stat="identity", color="black",
                      fill=c("deepskyblue2","deeppink"))
fig<-fig+geom_errorbar(aes(ymax=means+sems, ymin=means-sems), width=.2)
fig
fig<-fig+ggtitle("Pre & Post Video Optimism Scores")
fig<-fig+labs(x="Test Version", y="Optimism Scores\n(higher=more optimistic")
fig<-fig+scale_x_discrete(breaks=c("pre","post"),labels=c("Pre","Post"))
fig
fig<-fig+theme(plot.title=element_text(size=15,face="bold",vjust=.5))
fig
fig<-fig+theme(axis.title.x=element_text(size=12,face="bold",vjust=-.25))
fig<-fig+theme(axis.title.y=element_text(size=12,face="bold",vjust=1))
fig<-fig+theme(axis.text.x=element_text(size=10,face="bold",color="black"))
fig<-fig+theme(axis.text.y=element_text(size=10,face="bold",color="black"))
fig
fig<-fig+coord_cartesian(ylim=c(min(pubs$means)-2*max(pubs$sems),
                                max(pubs$means)+2*max(pubs$sems)))
fig
fig<-fig+theme(panel.border=element_blank(), axis.line=element_line())
fig
fig<-fig+theme(panel.grid.major.x=element_blank())
fig<-fig+theme(panel.grid.major.y=element_line(color="darkgrey"))
fig<-fig+theme(panel.grid.minor.y=element_blank())
fig
summary(aov(income~party,data=politics[politics$testtime=="pre",]))
summary(aov(income~party*sex,data=politics[politics$testtime=="pre",]))
summary(aov(income~party*sex,data=politics[politics$testtime=="pre",]))
polsum<-politics[politics$testtime=="pre",]%>%group_by(party,sex)%>%
  summarize(means=mean(income),sems=sd(income)/sqrt(length(income)))
col1=col2hex("deeppink")
col2=col2hex("deepskyblue2")
fig<-ggplot(polsum, aes(x=party, y=means, fill=sex))+
  geom_bar(stat="identity",position=position_dodge())+
   scale_fill_manual(values=c(col1,col2),name="Sex",breaks=c("female","male"),
                       labels=c("Female", "Male"))+
   theme(legend.key=element_rect(color="black"))+
   geom_errorbar(aes(ymax=means+sems, ymin=means-sems),
                   width=.2,position=position_dodge(.9))+
   ggtitle("Incomes by Sex and Political Affiliation")+
   labs(x="Political Party Affiliation",y="Income\n(thousands of dollars)")+
   scale_x_discrete(breaks=c("democrat","independent","republican"),
                      labels=c("Democrat","Independent","Republican"))+
   theme(plot.title=element_text(size=15,face="bold",vjust=.5))+
   theme(axis.title.x=element_text(size=12,face="bold",vjust=-.25))+
   theme(axis.title.y=element_text(size=12,face="bold",vjust=1))+
   theme(axis.text.x=element_text(size=10,face="bold",color="black"))+
   theme(axis.text.y=element_text(size=10,face="bold",color="black"))+
   coord_cartesian(ylim=c(min(polsum$means)-2*max(polsum$sems),
                            max(polsum$means)+2*max(polsum$sems)))+
   theme(panel.border=element_blank(),axis.line=element_line())+
   theme(panel.grid.major.x=element_blank())+
   theme(panel.grid.major.y=element_line(color="darkgrey"))+
   theme(panel.grid.minor.y=element_blank())+
   theme(legend.position=c(.2,.76))+
   theme(legend.background=element_blank())+
   theme(legend.background=element_rect(color="black"))+
   theme(legend.title=element_blank())+
   theme(legend.title=element_text(size=12))+
   theme(legend.title.align=.5)+
   theme(legend.text=element_text(size=10,face="bold"))
    fig                     
                           
