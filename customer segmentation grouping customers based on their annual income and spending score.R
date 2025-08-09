#Step 1: Load necessary libraries
install.packages("ggplot2")
install.packages("factoextra")
library(ggplot2)
library(factoextra)

#Step 2: Create a sample dataset
set.seed(42)
customer_data <- data.frame(
  CustomerID = 1:200,
  AnnualIncome = round(runif(200, 15000, 100000), 0),
  SpendingScore = round(runif(200, 1, 100), 0)
)

#Step 3: Visualize the data
ggplot(customer_data, aes(x = AnnualIncome, y = SpendingScore)) +
  geom_point(color = "steelblue") +
  labs(title = "Customer Distribution", x = "Annual Income", y = "Spending Score")

#Step 4: Prepare data for clustering
clustering_data <- customer_data[, c("AnnualIncome", "SpendingScore")]

#Step 5: Determine optimal number of clusters using Elbow Method
fviz_nbclust(clustering_data, kmeans, method = "wss") +
  labs(title = "Elbow Method for Optimal Clusters")

#Step 6: Apply K-Means clustering
set.seed(123)
kmeans_result <- kmeans(clustering_data, centers = 4, nstart = 25)

#Step 7: Add cluster labels to the dataset
customer_data$Cluster <- factor(kmeans_result$cluster)

#Step 8: Visualize the clusters
ggplot(customer_data, aes(x = AnnualIncome, y = SpendingScore, color = Cluster)) +
  geom_point(size = 3, alpha = 0.7) +
  labs(title = "Customer Segmentation", x = "Annual Income", y = "Spending Score") +
  scale_color_brewer(palette = "Set1")
