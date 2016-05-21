%> @file HillClimberOptimizer.m
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
%>	Simple hill climbing algorithm, starting from a large initial
%>	population.
% ======================================================================
classdef HillClimberOptimizer < Optimizer


% private members
	properties (SetAccess = 'private', GetAccess = 'private')
		maxIterations = 200;
		step = 10^-3;
		timeLimit = 120;
		lineSteps = 100;
	end
	
	methods
		% constructor
		% Description:
		%     Creates an Hill Climber Optimizer
		function this = HillClimberOptimizer(varargin)
			% call superclass
			this = this@Optimizer(varargin{:});
	
			if nargin == 1
				config = varargin{1};
				this.maxIterations = config.self.getIntOption('maxIterations', this.maxIterations);
				this.step = config.self.getDoubleOption('step', this.step);
				this.timeLimit = config.self.getIntOption('timeLimit', this.timeLimit);
				this.lineSteps = config.self.getIntOption('lineSteps', this.lineSteps);
			elseif nargin == 3
				this.maxIterations = varargin{3};
			end
		end
		
	end
	
	methods (Access = private)
		[xMin, fMin] = climbHill(this, xStart, f);
	end
end
