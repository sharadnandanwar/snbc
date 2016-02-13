function [model] = multiTrain(label, data, options)
% [model] = multiTrain(label, data, options)
% Learn a model for multilabel classification using
% Structural Neighborhood based classification approach
% INPUT:
%   label   = Label matrix for nodes with rows
%             corresponding to nodes and columns to classes
%             a value of 1 indicates that node belongs to a
%             class, 0 otherwise.
%   data    = Adjacency Matrix of the graph to learn from
%   options = Structure containing indices of train and 
%             test nodes as well as other SGD parameters
% OUTPUT:
%   model   = Learned model for multilabel classificaiton
%
% Author: Sharad Nandanwar

    trainIdx = options.trainIdx;
    testIdx = options.testIdx;

    model = {};
    model.nClass = size(label,2);
    ovaSVM = {};
    logitParam = {};
    
    disp(strcat('Total Number of Nodes in Graph: ', num2str(size(label,1))));
    disp(strcat('Number of Nodes in Train Set: ', num2str(length(trainIdx))));
    disp(strcat('Number of Classes: ',num2str(size(label,2))));
    for i=1:model.nClass
	    target = label(:,i);
	    target(target==0) = -1;
	    target(testIdx,:) = 0;
	    ovaSVM{i} = binaryTrain(data, full(target), options);
	
	    trainTarget = label(:,i);
	    trainTarget(trainTarget==0) = -1;
	    trainTarget(trainIdx,:) = 0;
	    [decVal] = binaryPredict(data, ovaSVM{i});
	
	    target = target(trainIdx,:);
	    target(target==-1) = 0;
	    [logitParam{i}] = glmfit(decVal(trainIdx,:), full(target), 'binomial', 'link', 'logit');
    end

    model.ovaSVM = ovaSVM;
    model.logitParam = logitParam;

end
