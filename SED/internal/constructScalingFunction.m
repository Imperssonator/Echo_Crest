%> @file constructScalingFunction.m
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
%>	Parses a `scaling' field from the configuration.
%>	4 types of scaling are recognized. Any other string will be
%>	interpreted as an implicit function.
%>	     none : no scaling
%>	     max  : scaling by the maximum value
%>	     cap  : cap values bigger than 2 times the average value
%>	     capmax : cap values bigger than 2 times the average, then scale
%>	     by the max
% ======================================================================
function func = constructScalingFunction( str )


switch str
	case 'none'
		func = @(x) x;
	case 'max'
		func = @(x) x / max(x);
    case 'onetozero'
        func = @(x)((x - min(x)) ./ max(1,(max(x) - min(x))));
	case 'cap'
		func = @(x) min( x, 2*average(x) );
	case 'capmax'
		func = @(x) min( x, 2*average(x) ) / min( max(x), average(x) );
	otherwise
		str
		class(str)
		func = str2fun( str );
end
