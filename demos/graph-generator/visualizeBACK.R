library(igraph)
library(qgraph)
all_content = readLines("/home/blake/github/cluster-computing/demos/graph-generator/NodeData.txt")
myheader = all_content[1]
edge_list = all_content[-1]
headvars = unlist(strsplit(myheader, ","))
nodes = as.integer(headvars[1][1])
edges = as.integer(headvars[2][1])
mat<-matrix(0, nodes, nodes)
for (i in 1:edges){
edgeTemp=as.integer(unlist(strsplit(edge_list[i], ",")))
mat[edgeTemp[1],edgeTemp[2]] = edgeTemp[3]
mat[edgeTemp[2],edgeTemp[1]] = edgeTemp[3]
}
qgraph(mat,edge.labels=TRUE)
ig <- graph.adjacency(mat, mode="undirected", weighted=TRUE)
mstoutput=mst(ig)
results <- capture.output(mstoutput)
trimresults = substring(results[4],5)
s <- strsplit(trimresults, "[^[:digit:]]")
solution <- as.numeric(unlist(s))
solution <- solution[!is.na(solution)]
minlist<-matrix(0,length(solution)/2 , 3)
temp1 <- list()
temp2 <- list()
for (i in 1:length(solution)){
if ((i%%2)==1) {
 temp1=c(temp1,solution[i])
}
if ((i%%2)==0) {
  temp2=c(temp2,solution[i])
  }

}
n1=unlist(temp1)
n2=unlist(temp2)
for (i in 1:length(solution)/2){
minlist[i,1]=n1[i]
minlist[i,2]=n2[i]
minlist[i,3]=mat[n1[i],n2[i]]
}
print(minlist)
print('edge total=')
print(sum(minlist[,3]))
#plot(ig, edge.label=round(E(ig)$weight, 3))

#NodeData.txt
#10,15
#1,3,5
#1,9,6
#1,10,10
#2,6,9
#3,6,13
#3,10,3
#4,6,2
#4,7,3
#4,9,3
#5,8,3
#5,10,14
#6,9,18
#6,10,8
#7,8,13
#8,10,16