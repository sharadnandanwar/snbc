function [Test, Train] = Snowball(graph, TrFraction)
% [Train, Test] = Snowball(graph, Fraction)
% Samples a specified fraction of nodes from graph
% using Snowball sampling.
% INPUT:
%    graph      =  Adjaceny Matrix of the graph from which
%                nodes are to be sampled
%    TrFraction =  Fraction of nodes to sample as Train
% OUTPUT:
%    Train      =  List of nodes sampled as train
%    Test       =  List of nodes sampled as test
%
% Author: Sharad Nandanwar

    graph = graph+graph';
    graph(graph>0) = 1;

    [src dest] = find(graph>0);
    sparseGraph = [src dest];
    
    TsFraction = 1-TrFraction;
    %computing the number of Test nodes
    Nodes = unique(sparseGraph);
    n_Test = floor(size(Nodes,1).* TsFraction);

    Test = zeros(n_Test,1);
    Train = zeros(size(Nodes,1)-n_Test,1);

    n_seed=ceil(n_Test*0.02);
    % n_seed=1;

    Seed = unique(sparseGraph(randi(size(sparseGraph,1),[n_seed,1]),1));
    Selected = Seed;

    while size(Selected,1)< n_Test
        % Finding the unselected Neighbors of seed nods
        tmp_Neighbor = (ismember(sparseGraph(:,1),Seed) & ~ismember(sparseGraph(:,2),Selected));
        Neighbor = unique(sparseGraph(tmp_Neighbor,2));
            
        % Randomly selecting the neighors
        tmp_Selected = [];
        if ~isempty(Neighbor)
            tmp_Selected = Neighbor(rand(size(Neighbor,1),1)<=(TsFraction/2));
        end
        % if none of the neighbors are selected a new set of seeds should
        % be selected to continue 
        if isempty(tmp_Selected)
           Seed = unique(sparseGraph(randi(size(sparseGraph,1),[n_seed,1]),1));
        else
        % when at least one neighbors is selected they will be added to the
        % selected nodes and the seeds set will be updated
           Selected = [Selected;tmp_Selected];
           Seed = tmp_Selected;
        end
    end
    Test = Selected(1:n_Test);
    tmp_Train = Nodes;
    tmp_Train(ismember(Nodes,Test)) = [];
    Train = tmp_Train;

    return
end
