%> @file setInputConstraints.m
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
%> Supports non-linear and linear inequality constraints.
% ======================================================================
function this = setInputConstraints( this, con )

    import java.util.logging.*
    logger = Logger.getLogger('Matlab.MatlabGA');

    % empty constraints

    % A*x <= b
    this.Aineq=[];
    this.Bineq=[];

    % A*x = b (not supported)
    %this.Aeq=[];
    %this.Beq=[];

    % 1 function handle
    this.nonlcon = [];
    nonlinear = {};

    numNonlinear=0;
    for i=1:length(con)

        switch class(con{i})
            case 'LinearConstraint'
                [Aineq Bineq] = getInternal(con{i});

                % combine with previous constraints
                this.Aineq = [this.Aineq ; Aineq];
                this.Bineq = [this.Bineq ; -Bineq];
                numNonlinear=numNonlinear+1;
            otherwise
                nonlinear{end+1} = con{i};
        end
    end

    if ~isempty( nonlinear )
        this.nonlcon = @(x) vectorEvaluateConstraint( nonlinear, x );
    end
end

