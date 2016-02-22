function [model] = binaryTrain(X,Y,options)
% [model] = binaryTrain(X, Y, options)
% Learn a model for binary classification using
% Structural Neighborhood based classification approach
% INPUT:
%   X       = Adjacency Matrix of the graph to learn from
%   Y       = Label vector for nodes with containing 1
%             if node belongs to class, -1 if it does not
%             belongs to the class and 0 if unknown.
%   options = Structure containing SGD parameters
% OUTPUT:
%   model   = Learned model for classificaiton
%
% Author: Sharad Nandanwar

lamda = options.lamda;
k = options.k;
maxIter = options.maxIter;

pow = 8;
N =size(X,1);

trainIdx = find(Y~=0);
NTr = length(trainIdx);

wpos = sum(Y==-1)/sum(Y==1);
wneg = 1;

weight = zeros(size(Y));
weight(Y==1) = wpos;
weight(Y==-1) = wneg;

if(size(Y,1)~=N)
    disp('Error: Number of elements in X and Y must same\nSee pegasos usage for further help');
    return;
end

degree = sum(X,2);
logd = log2(2+degree);

invD = spdiags(1./degree,0,N,N);

alpha = 1-1./log2(2+degree);
ALPHA = spdiags(alpha,0,N,N);
COMPALPHA = spdiags(1-alpha,0,N,N);

M = COMPALPHA * invD * X;

w = rand(1,size(X,2));
w = w/(sqrt(lamda)*norm(w));

Tolerance=1e-6;

for t = 1:maxIter
    if(mod(t,100) == 0)
        disp(strcat('iteration # ',num2str(t), '/', num2str(maxIter)));
    end
    w_old = w;
    
    pred = X*w';
    propogatedPred = zeros(size(pred));
    
    for i=1:pow
        propogatedPred = M*propogatedPred + pred;
    end
    propogatedPred = M*propogatedPred + pred;
    propogatedPred = alpha .* propogatedPred;
    
    b = mean(Y(trainIdx) - propogatedPred(trainIdx));

    idx = randi(NTr,1,k);
    randomSubset = trainIdx(idx);

    idx1 = (propogatedPred(randomSubset,:)+b).*Y(randomSubset,:)<1;

    misClass = randomSubset(idx1);
    grad = weight(misClass,:).*Y(misClass).*alpha(misClass);
    part = grad'*M(misClass,:);
    At = sparse(size(part,1),size(part,2));
    for i=1:pow
        At = At*M + part;
    end
    grad = At*X + grad'*X(misClass,:);
    grad = lamda*w.*logd' - 1/k*grad;
    
    etat = 1/(2+lamda*t);
    w1 = w - etat * grad;
    w = min(1,1/(sqrt(lamda)*norm(w1)))*w1;


    if(norm(w-w_old) < Tolerance)
        break;
    end

end

if(t<maxIter)
    disp(strcat('W converged in ',num2str(t),' iterations.'));
else
    disp(strcat('W not converged in ',num2str(maxIter),' iterations.'));
end

pred = X*w';
propogatedPred = zeros(size(pred));
    
for i=1:pow
    propogatedPred = M*propogatedPred + pred;
end
propogatedPred = M(trainIdx,:)*propogatedPred + pred(trainIdx,:);
propogatedPred = ALPHA(trainIdx,trainIdx) * propogatedPred;

b = mean(Y(trainIdx) - propogatedPred);

Tr = sum(sign(propogatedPred+b)==Y(trainIdx,:));
F = NTr - Tr;
TrainAccuracy = full(100*Tr/(Tr+F));
disp(strcat('Accuracy on Training set = ',num2str(TrainAccuracy),' %\n'));

model = {};
model.w = w;
model.b = b;

end
