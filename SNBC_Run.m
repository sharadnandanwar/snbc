function [hammingScore microF1 macroF1] = SNBC_Run ( dataFile )
% [hammingScore microF1 macroF1] = SNBC_Run ( dataFile )
% Run and Evaluate performance of SNBC.
% INPUT:
%   dataFile    = url of .mat file
% OUTPUT:
%   hammingScore = Hamming Score
%   microF1      = Micro-F1 Score
%   macroF1      = Macro-F1 Score
%
% e.g. [hs mic mac] = SNBC_Run('Datasets/pubmed.mat')
%
% Author: Sharad Nandanwar

    eval(['load ' dataFile]);

    %% Fraction of nodes to use in training
    frac = 0.1;
    
    disp('Randomly sampling nodes from graph for training...');
    [Test Train] = Snowball(graph, 0.1);
    disp('Sampling over...');
    %% Set options structure, containing parameters for SGD learning
    options={};
    options.trainIdx = Train;
    options.testIdx = Test;
    options.k = min(size(Train,1), ceil(0.1*size(graph,1)));
    options.maxIter = 1000;
    options.lamda = 2^-6;

    disp('Training model...');
    %% Train
    model = multiTrain(label, graph, options);
    disp('Training over...');
    disp('Getting predictions for test nodes...');
    %% Predict
    score = multiPredict(graph, model);

    testLabel = label(Test,:);
    testScore = score(Test,:);
    disp('Evaluating performance...');
    %% Evaluate Performace
    [hammingScore microF1 macroF1] = Evaluate(testScore, testLabel);

end
