%> @file buildManhattanDistanceMatrix.m
%> @authors: SUMO Lab Team
%> @version 7.0.2 (Revision: 6486)
%> @date 2006-2010
%>
%> This file is part of the Surrogate Modeling Toolbox ("SUMO Toolbox")
%> and you can redistribute it and/or modify it under the terms of the
%> GNU Affero General Public License version 3 as published by the
%> Free Software Foundation.  With the additional provision that a commercial
%> license must be purchased if the SUMO Toolbox is used, modified, or extended
%> in a commercial setting. For details see the included LICENSE.txt file.
%> When referring to the SUMO Toolbox please make reference to the corresponding
%> publication:
%>   - A Surrogate Modeling and Adaptive Sampling Toolbox for Computer Based Design
%>   D. Gorissen, K. Crombecq, I. Couckuyt, T. Dhaene, P. Demeester,
%>   Journal of Machine Learning Research,
%>   Vol. 11, pp. 2051-2055, July 2010. 
%>
%> Contact : sumo@sumo.intec.ugent.be - http://sumo.intec.ugent.be

% ======================================================================
%> @brief TODO
%>
%>	Calculate the manhattan distance between 'samples' and 'targets'
%>	'targets' is optional and is assumed to be identical to samples if it
%>	is not given.
% ======================================================================
function distances = buildManhattanDistanceMatrix(samples, targets, pdistMode)


% calculate the distance
Xt = permute(samples, [1 3 2]);
Yt = permute(targets, [3 1 2]);
%distances = sqrt(sum(abs( Xt(:,ones(1,size(targets,1)),:) - Yt(ones(1,size(samples,1)),:,:) ).^2, 3))
distances = sum(abs( Xt(:,ones(1,size(targets,1)),:) - Yt(ones(1,size(samples,1)),:,:) ), 3);

% pdist mode?
if exist('pdistMode', 'var')
	if pdistMode
		tmp = tril(distances);
		distances = tmp(tmp ~= 0)';
	end
end

% all done
return;

%% OLD CODE BELOW

[sz1,d] = size(samples);

distances = zeros(1, sz1.*(sz1-1)./2); % initialise output matrix

if ndims(samples) ~= 2
 error('Input must be a matrix.');
end

nr=1;
for i = 1:sz1-1
	xi = samples(i,:);
	diff = xi(ones(sz1-i,1),:) - samples(i+1:sz1,:);    % difference
	dist = sum(abs(diff), 2);        % distance
	
	%distances(i+1:sz1,i) = dist.';
	distances(1,nr:(nr-1+sz1-i)) = dist.';
	
	%distances(i,i+1:sz1) = dist.';
	
	nr=nr+sz1-i;
end
	
