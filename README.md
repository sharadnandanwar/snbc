SNBC: Structural Neighborhood Based Classification of Nodes in a Network<br />
<br />
[hammingScore microF1 macroF1] = SNBC_Run ( dataFile )<br />
Run and Evaluate performance of SNBC.<br />
INPUT:<br />
   dataFile    = url of .mat file<br />
OUTPUT:<br />
   hammingScore = Hamming Score<br />
   microF1      = Micro-F1 Score<br />
   macroF1      = Macro-F1 Score<br />
<br />
 e.g. [hs mic mac] = SNBC_Run('Datasets/pubmed.mat')<br />
<br />
Author: Sharad Nandanwar<br />
