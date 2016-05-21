%> @file LOLASampleRanker.m
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
%>	A class that rates samples according to the LOLA non-linearity criterion.
% ======================================================================
classdef LOLASampleRanker < SampleRanker


properties (Access = public)
	dimension;
	outputDimension;
    neighbourhoodSize;
	gradientMethod;
    fastNeighbourhoodCalculation;
	debug;
	combineOutputs;
	sampleSize;
	neighbourhoods;
	neighbourhoodScores;
	neighbourhoodMaxDistance;
	gradients;
	test;
	gradientErrors;
	averageGradientError;
	neighbourhoodSubLeftSide;
	neighbourhoodSubRightSide;
	neighbourhoodSubIndexArray;
	logger;
	inputWeights;
end

methods (Access = public)
	
	function s = LOLASampleRanker(config, varargin)

		import java.util.logging.*
		logger = Logger.getLogger('Matlab.LOLASampleRanker');

		% dimension
		dimension = config.input.getInputDimension();
		outputDimension = config.output.getOutputDimension();
		
		% get the weights
		s.inputWeights = zeros(1, config.input.getInputDimension());
		for i = 0 : config.input.getInputDimension() - 1
			s.inputWeights(i+1) = config.input.getInputDescription(i).getWeight();
		end
		
		% default options
		defaultOptions = struct(...
			'debug', false, ...
			'gradientMethod', 'direct', ...
			'combineOutputs', 'max', ...
            'fastNeighbourhoodCalculation', false, ...
			'neighbourhoodSize', 2);
		
		% merge with defined options
		if nargin == 2
			options = mergeStruct(varargin{1}, defaultOptions, false);
		else
			options = defaultOptions;
		end
		
		if isfield(options, 'inDim')
			dimension = options.inDim;
		end
		if isfield(options, 'outDim')
			outputDimension = options.outDim;
		end

		% neighbourhood size is proportional to dimension
		neighbourhoodSize = options.neighbourhoodSize * dimension;


		% pre-calculate the substraction arrays and the index arrays
		N = factorial(neighbourhoodSize) / 2 / factorial(neighbourhoodSize - 2);
		subLeftSide = zeros(0,1);
		subRightSide = zeros(0,1);
		for i = 1 : neighbourhoodSize
			for j = 1 : neighbourhoodSize - i
				subLeftSide = [subLeftSide ; i];
				subRightSide = [subRightSide ; (j+i)];
			end
		end
		subIndexArray = zeros(neighbourhoodSize, neighbourhoodSize - 1);
		subIndexArray(1,:) = 1 : neighbourhoodSize - 1;
		for i = 2 : neighbourhoodSize
			subIndexArray(i, 1:i-2) = subIndexArray(i-1, 1:i-2) + 1;
			subIndexArray(i,i-1) = subIndexArray(i-1, i-1);
			subIndexArray(i, i:neighbourhoodSize-1) = subIndexArray(i-1, i:neighbourhoodSize-1) + (neighbourhoodSize-i);
		end
		
		s.dimension = dimension;
		s.outputDimension = outputDimension;
		s.neighbourhoodSize = neighbourhoodSize;
        s.fastNeighbourhoodCalculation = options.fastNeighbourhoodCalculation;
		s.gradientMethod = options.gradientMethod;
		s.debug = options.debug;
		s.combineOutputs = options.combineOutputs;
		s.sampleSize = 0;
		s.neighbourhoods = {};
		s.neighbourhoodScores = [];
		s.neighbourhoodMaxDistance = [];
		s.gradients = {};
		s.gradientErrors = {};
		s.averageGradientError = 0;
		s.neighbourhoodSubLeftSide = subLeftSide;
		s.neighbourhoodSubRightSide = subRightSide;
		s.neighbourhoodSubIndexArray = subIndexArray;
		
		s.logger = logger;
	end
	
	[s, error, failedError] = calculateError(s, samples, values);
	[candidates] = getAdditionalCandidates(s, samples, A);
	[neighbourhoods] = getNeighbourhoods(s);
end

methods (Access = private)
	s = addNewSamples(s, samples, values);
	s = addParentLink(s, samples, values, A, B);
	distance = calculateDistortedDistance(p1, p2, gradientError);
	[s, changed] = addSampleToNeighbourhood(s, samples, B, P);
	IF = calculateIinfo( A, neighbours, B );
	score = calculateNeighbourhoodScore(s, A, neighbourhood);
	newGradient = convergeGradient(s, samples, values, A, outputIndex, oldGradient);
	[newScore, worst] = findWorstNeighbour(s, samples, A, P);
	[s] = updateGradientError(s, samples, values, A);
end

end
