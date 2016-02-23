# Otto_Product_Classification

As part of CS 521 Data Mining Technique class project, we have chosen Otto Group Product
Classification Challenge from Kaggle. The Otto Group is one of the world’s biggest e-commerce
companies which sells millions of products worldwide, with several thousand products being
added to product line.

A consistent analysis of the performance of products is crucial. However, due to diverse global
infrastructure, many identical products get classified differently. Therefore, the quality of
product analysis depends heavily on the ability to accurately cluster similar products. The better
the classification, the more insights the company can generate about product range. So we have
to develop a classifier which predicts the product group based on the given features accurately.


Given data consists of train and test files. Description of data present in these files is given below.
Data fields:
 id - an anonymous id unique to a product
 feat_1, feat_2, ..., feat_93 - the various features of a product
 target - the class of a product (present only in train data)

Train data consists of 61878 rows and 95 columns (id, feat_1-93, and target)
Test data consists of 144368 rows and 94 columns (id, feat_1-93)
Each row corresponds to a single product. 
There are a total of 93 numerical features and the data doesn’t consist of any nominal, binary, ordinal variables. All are positive integer values and no
negatives are present.
All features have been obscured and are not defined.
There are nine categories for all products.
Each target category represents one of most important product categories (like fashion, electronics, etc.). The products for the training and testing sets
are selected randomly.
