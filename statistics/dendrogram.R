rawData <- read.csv("microArray.csv")	# Read data 
rawData[,1] <- factor(rawData[,1])		# Convert gene number to factor 
rawData
rawData.dist <- dist(rawData[,2:3])		# Create a distance matrix at Euclidean distance 
round(rawData.dist,3)					# Display of brute force distance 
rawData.cluster <- hclust(rawData.dist, method="average")	# Cluster analysis by group average method 
plot(rawData.cluster, hang=-1,
	main="Cluster analysis by group average method",
	xlab="Gene No",
	sub"")	# Dendrogram output 
