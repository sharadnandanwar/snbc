SNBC: Structural Neighborhood Based Classification of Nodes in a Network

[hammingScore microF1 macroF1] = SNBC_Run ( dataFile )
Run and Evaluate performance of SNBC.
INPUT:
   dataFile    = url of .mat file
OUTPUT:
   hammingScore = Hamming Score
   microF1      = Micro-F1 Score
   macroF1      = Macro-F1 Score

 e.g. [hs mic mac] = SNBC_Run('Datasets/pubmed.mat')

Author: Sharad Nandanwar
