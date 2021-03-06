library(igraph)
library(qgraph)
library(partitons)
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
print(minList)
cat('\nedge total= ',sum(minList[, 3]))