function [hammingScore microF1 macroF1 predictedLabel] = Evaluate(predictedScore, label)
% [hammingScore microF1 macroF1 predictedLabel] = Evaluate(predictedScore, label)
% Evaluate the performance for multilabel classification using given scores
% and target labels
% INPUT:
%   predictedScore = probability scores of all nodes for each class
%   label          = original label information of nodes
% OUTPUT:
%   hammingScore   = Hamming Score
%   microF1        = Micro-F1 Score
%   macroF1        = Macro-F1 Score
%   predictedLabel = Label Predictions for all nodes
%
% Author: Sharad Nandanwar

	hammingScore = 0;
	microF1 = 0;
	macroF1 = 0;
	
	predictedLabel = zeros(size(label));	
	for i=1:size(label,1)
		[~,I] = sort(predictedScore(i,:),'descend');
		lCount = sum(label(i,:));
		predictedLabel(i,I(1:lCount)) = 1;
	end
	
	TP = predictedLabel & label;

	hammingScore = full(mean(sum(TP,2)./sum(predictedLabel | label,2)) * 100);
	
	microF1 = full(2*sum(TP(:))/(sum(predictedLabel(:)) + sum(label(:))) * 100);
	
	for j=1:size(label,2)
		classF1 = full(2*predictedLabel(:,j)'*label(:,j)/(sum(predictedLabel(:,j)) + sum(label(:,j))) * 100);
		macroF1 = macroF1 + classF1;
	end
	macroF1 = macroF1/size(label,2);
end
