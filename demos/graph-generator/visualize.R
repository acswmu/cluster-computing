# NodeData.txt
# 5,10
# 1,2,3
# 1,3,15
# 1,4,12
# 1,5,8
# 2,3,2
# 2,4,16
# 2,5,10
# 3,4,3
# 3,5,12
# 4,5,7

library(igraph)
library(qgraph)
# Reading in file data
all_content = readLines("NodeData.txt")

# Splits off the header
myheader = all_content[1]
edge_list = all_content[-1]
headvars = unlist(strsplit(myheader, ","))
nodes = as.integer(headvars[1][1])
edges = as.integer(headvars[2][1])

# Intialize empty matrix
mat <- matrix(0, nodes, nodes)
for (i in 1:edges) {
  edgeTemp = as.integer(unlist(strsplit(edge_list[i], ",")))
  mat[edgeTemp[1], edgeTemp[2]] = edgeTemp[3]
  mat[edgeTemp[2], edgeTemp[1]] = edgeTemp[3]
}

# Perform MST
ig <- graph.adjacency(mat, mode = "undirected", weighted = TRUE)
mstoutput = mst(ig)
results <- capture.output(mstoutput)
trimTemp = list()
resultTemp = list()

# Parse and store MST output
for (i in 4:length(results)) {
  trimTemp = unlist(strsplit(results[i], "]"))
  resultTemp = c(resultTemp,trimTemp[2])
}
s <- strsplit(unlist(resultTemp), "[^[:digit:]]")
solution <- as.numeric(unlist(s))
solution <- solution[!is.na(solution)]
minList <- matrix(0, length(solution) / 2 , 3)
temp1 <- list()
temp2 <- list()
for (i in 1:length(solution)) {
  if ((i %% 2) == 1) {
    temp1 = c(temp1, solution[i])
  }
  if ((i %% 2) == 0) {
    temp2 = c(temp2, solution[i])
  }
}

# Storing MST
n1 = unlist(temp1)
n2 = unlist(temp2)
for (i in 1:length(solution) / 2) {
  minList[i, 1] = n1[i]
  minList[i, 2] = n2[i]
  minList[i, 3] = mat[n1[i], n2[i]]
}

# Graph the full matrix
#qgraph(mat, edge.labels = TRUE, filetype="png")
png(filename="FullPlot.png")
plot(ig, edge.label=round(E(ig)$weight, 3))
dev.off()

# Store MST to matrix
mat2 <-  matrix(0, nodes,nodes )
for (i in 1:nrow(minList)) {
  mat2[minList[i,1], minList[i,2]] = minList[i,3]
  mat2[minList[i,2], minList[i,1]] = minList[i,3]
}

# Graph the MST
ik <- graph.adjacency(mat2, mode = "undirected", weighted = TRUE)
png(filename="MST.png")
plot(ik, edge.label=round(E(ik)$weight, 3))
dev.off()

# Print MST 
cat("\nFULL MST\n")
print(minList)
cat('\nedge total= ',sum(minList[, 3]),"\n\n")



#########################################################################
# Spliting the Graph into parts

# Part1
part1 = mat
part1[1:nodes,(ceiling(nodes/2)+1):nodes] = 0
part1[(ceiling(nodes/2)+1):nodes,1:nodes] = 0


ia <- graph.adjacency(part1, mode = "undirected", weighted = TRUE)
mstp1 = mst(ia)
plot(ia, edge.label=round(E(ia)$weight, 3))


results <- capture.output(mstp1)
trimTemp = list()
resultTemp = list()

# Parse and store MST output
for (i in 4:length(results)) {
  trimTemp = unlist(strsplit(results[i], "]"))
  resultTemp = c(resultTemp,trimTemp[2])
}
s <- strsplit(unlist(resultTemp), "[^[:digit:]]")
solution <- as.numeric(unlist(s))
solution <- solution[!is.na(solution)]
minList2 <- matrix(0, length(solution) / 2 , 3)
temp1 <- list()
temp2 <- list()
for (i in 1:length(solution)) {
  if ((i %% 2) == 1) {
    temp1 = c(temp1, solution[i])
  }
  if ((i %% 2) == 0) {
    temp2 = c(temp2, solution[i])
  }
}

# Storing MST
n1 = unlist(temp1)
n2 = unlist(temp2)
for (i in 1:length(solution) / 2) {
  minList2[i, 1] = n1[i]
  minList2[i, 2] = n2[i]
  minList2[i, 3] = part1[n1[i], n2[i]]
}

# Print MST 
print(minList2)
cat('\nPart1 edge total= ',sum(minList2[, 3]),"\n\n")



##### PART 2
part2 = mat
part2[1:ceiling(nodes/2),1:nodes]=0
part2[1:nodes,1:ceiling(nodes/2)]=0
ib <- graph.adjacency(part2, mode = "undirected", weighted = TRUE)
mstp2 = mst(ib)
plot(ib, edge.label=round(E(ib)$weight, 3))

results <- capture.output(mstp2)
trimTemp = list()
resultTemp = list()

# Parse and store MST output
for (i in 4:length(results)) {
  trimTemp = unlist(strsplit(results[i], "]"))
  resultTemp = c(resultTemp,trimTemp[2])
}
s <- strsplit(unlist(resultTemp), "[^[:digit:]]")
solution <- as.numeric(unlist(s))
solution <- solution[!is.na(solution)]
minList3 <- matrix(0, length(solution) / 2 , 3)
temp1 <- list()
temp2 <- list()
for (i in 1:length(solution)) {
  if ((i %% 2) == 1) {
    temp1 = c(temp1, solution[i])
  }
  if ((i %% 2) == 0) {
    temp2 = c(temp2, solution[i])
  }
}

# Storing MST
n1 = unlist(temp1)
n2 = unlist(temp2)
for (i in 1:length(solution) / 2) {
  minList3[i, 1] = n1[i]
  minList3[i, 2] = n2[i]
  minList3[i, 3] = part2[n1[i], n2[i]]
}

# Print MST 
print(minList3)
cat('\nPart2 edge total= ',sum(minList3[, 3]),"\n\n")



part3 = mat
part3=part3-part1
part3=part3-part2
conval = min(part3[part3>0])
loc = which(part3 == conval, arr.ind=TRUE)
cat('\nMerge Edge:',loc[1,1],"<--->",loc[1,2],"   (",mat[loc[1,1],loc[1,2]],")")
cat('\n\nMST by parts:',sum(minList2[, 3])+sum(minList3[, 3])+mat[loc[1,1],loc[1,2]])
