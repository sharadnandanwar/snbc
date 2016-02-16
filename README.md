<h3>SNBC: Structural Neighborhood Based Classification of Nodes in a Network</h3>

<h5>Usage:</h5>
<tt>[hammingScore microF1 macroF1] = SNBC_Run ( filePath )</tt><br/>
Run and Evaluate performance of SNBC.

<h6>INPUT:</h6>
<tt> &nbsp; &nbsp; &nbsp;filePath &nbsp; &nbsp; = &nbsp;url of .mat file</tt>

<h6>OUTPUT:</h6>
<tt> &nbsp; &nbsp; &nbsp;hammingScore = Hamming Score</tt><br/>
<tt> &nbsp; &nbsp; &nbsp;microF1 &nbsp; &nbsp; &nbsp;= Micro-F1 Score</tt><br/>
<tt> &nbsp; &nbsp; &nbsp;macroF1 &nbsp; &nbsp; &nbsp;= Macro-F1 Score</tt><br/>

<h6>Example:</h6>
<tt> [hs mic mac] = SNBC_Run('Datasets/pubmed.mat')</tt>

<h6><bold><tt>Author: Sharad Nandanwar</tt></bold></h6>
