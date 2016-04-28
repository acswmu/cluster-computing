      [,1] [,2] [,3]
 [1,]    1   14    9
 [2,]    2    4   10
 [3,]    2   10   10
 [4,]    3    6    8
 [5,]    3   15    2
 [6,]    4    7    5
 [7,]    4   14    5
 [8,]    5   15    5
 [9,]    6    7    8
[10,]    6   12   10
[11,]    8   14    2
[12,]    9   13   13
[13,]    9   14    2
[14,]   11   13    3

1  <--->  14   ( 9 )
2  <--->  4   ( 10 )
3  <--->  15   ( 2 )
4  <--->  7   ( 5 )
5  <--->  15   ( 5 )
6  <--->  3   ( 8 )
7  <--->  4   ( 5 )
8  <--->  14   ( 2 )
9  <--->  14   ( 2 )
10  <--->  2   ( 10 )
11  <--->  13   ( 3 )
12  <--->  6   ( 10 )
13  <--->  11   ( 3 )
14  <--->  8   ( 2 )
15  <--->  3   ( 2 )


mat2 <- matrix(0,  nodes,nodes )
mat3 <-  matrix(0, nodes,nodes )
for (i in 1:nrow(minMat)) {
    mat2[minMat[i,1], minMat[i,2]] = minMat[i,3]
    mat2[minMat[i,2], minMat[i,1]] = minMat[i,3]
}

for (i in 1:nrow(minList)) {
    mat3[minList[i,1], minList[i,2]] = minList[i,3]
    mat3[minList[i,2], minList[i,1]] = minList[i,3]
}
qgraph(mat3, edge.labels = TRUE)
ig <- graph.adjacency(mat3, mode = "undirected", weighted = TRUE)


mat <- ifelse(mat < 0.1,NA,mat)
tot = 0
iter <- length(mat[,1])
minMat <- matrix(0, length(solution) / 2 , 3)
for (i in 1:length(mat[,1])) {
  dest = which.min(mat[,i])
  tot = tot + mat[i,dest]
  minMat[i, 1] = i
  minMat[i, 2] = dest
  minMat[i, 3] = mat[i,dest]
}
print(minMat)