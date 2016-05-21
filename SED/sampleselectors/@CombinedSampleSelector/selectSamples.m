%> @file selectSamples.m
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
%>	Call selectSamples on each subobject and glue them together
% ======================================================================
function [this, newsamples, priorities] = selectSamples( this, state )


this.logger.fine('Starting combined sample selection...');

newsamples = zeros( 0, this.dimension );

% total number of samples to distribute
numNewSamples = state.numNewSamples;
originalNumNewSamples = numNewSamples;

% number of sample selectors
nSelectors = length(this.subObjects);

% default of zeroes for each selector
samplesPerSelector = zeros(nSelectors, 1);

% if ratios are set and valid, first distribute the samples according to their ratios
if sum(this.ratios) > eps && abs(sum(this.ratios) - 1.0) < eps
	for i = 1 : nSelectors
		samplesPerSelector(i) = floor(numNewSamples * this.ratios(i));
	end
	numNewSamples = numNewSamples - sum(samplesPerSelector);
end

% distribute evenly
samplesPerSelector = samplesPerSelector + repmat(floor(numNewSamples / nSelectors), nSelectors, 1);

% distribute the remaining samples randomly
samplesLeft = state.numNewSamples - sum(samplesPerSelector);
order = randperm(nSelectors);
order = order(1:samplesLeft);
samplesPerSelector(order) = samplesPerSelector(order) + 1;

for k=1:length(this.subObjects)
	state.numNewSamples = samplesPerSelector(k);
	[this.subObjects{k}, tmp] = selectSamples( this.subObjects{k}, state );
	newsamples = [newsamples ; tmp];
	this.logger.fine(sprintf('%d samples selected by %s: %s', samplesPerSelector(k), class(this.subObjects{k}), arr2str(tmp)));
end

% assign zero priorities - not possible to combine priorities in this case
priorities = zeros(size(newsamples,1), 1);

% push all samples through the merge criterion - might be used for
% filtering samples too close to each other
if ~isempty(this.mergeCriterion)
	state.numNewSamples = originalNumNewSamples;
	[this.mergeCriterion, newsamples, priorities] = this.mergeCriterion.selectSamples(newsamples, priorities, state);
	this.logger.fine(sprintf('After merging the samples from the sample selectors, %d were filtered, %d remain.', originalNumNewSamples - size(newsamples,1), size(newsamples,1)));
end
