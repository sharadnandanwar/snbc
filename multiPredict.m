function [score] = multiPredict(graph, model)
% [score] = multiPredict(graph, model)
% Prediction for multilabel classification using
% specified model.
% INPUT:
%   graph   = Adjacency matrix of graph under consideration
%   model   = learned model
% OUTPUT:
%   score   = predicted scores for each class
%
% Author: Sharad Nandanwar

	score = [];
	for i=1:model.nClass
		[decVal] = binaryPredict(graph, model.ovaSVM{i});
		param = model.logitParam{i};
		score(:,i) = 1./(1 + exp(-param(1)-decVal*param(2)));;
	end
end
