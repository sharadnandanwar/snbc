function [propogatedPred] = binaryPredict(X, model)
% [pred] = binaryPredict(X, model)
% Performs prediction using supplied model for binary
% structural neighborhood based classification problem.
% INPUT:
%   X       = Adjacency matrix of graph under consideration
%   model   = model learned
% OUTPUT:
%   pred    = predicted decision values for all nodes
%
% Author: Sharad Nandanwar

    N = size(X,1);

    w = model.w;
    b = model.b;

    degree = sum(X,2);
    invD = spdiags(1./degree,0,N,N);

    alpha = 1-1./log2(2+degree);
    ALPHA = spdiags(alpha,0,N,N);
    COMPALPHA = spdiags(1-alpha,0,N,N);

    M = COMPALPHA * invD * X;

    pow = 8;
    pred = X*w';
    propogatedPred = zeros(size(pred));
        
    for i=1:pow
        propogatedPred = M*propogatedPred + pred;
    end
    propogatedPred = M*propogatedPred + pred;
    propogatedPred = ALPHA * propogatedPred;

    propogatedPred = propogatedPred + b;

end
