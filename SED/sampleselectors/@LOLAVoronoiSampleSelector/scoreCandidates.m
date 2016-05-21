%> @file scoreCandidates.m
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
%>	Ranks a set of externally provided candidate samples according to the
%>	LOLA-Voronoi error metric.
% ======================================================================
function [this, scores] = scoreCandidates(this, candidates, state)


s.logger.fine('Starting LOLA-Voronoi sample scoring...');

% calculate both errors
[s.LOLA, errorLOLA, errorLOLAFailed] = s.LOLA.calculateError(state);
[s.Voronoi, errorVoronoi, errorVoronoiFailed] = s.Voronoi.calculateError(state);

% aggregate into one score, for both succesful and failed samples
averageErrors = ([errorLOLA;errorLOLAFailed] + 1) .* ([errorVoronoi;errorVoronoiFailed] + 1);

% samples and failed samples together
samples = [state.samples ; state.samplesFailed];

% now calculate in which Voronoi cell the candidates fall
distances = buildDistanceMatrix(samples, candidates);
[dummy, candidateCells] = min(distances, [], 1);

% now assign to each candidate, based on their respective cells, the right
% error
scores = averageErrors(candidateCells);

s.logger.fine('LOLA-Voronoi sample scoring finished...');
