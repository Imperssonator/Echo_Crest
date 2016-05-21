%> @file stringSplit.m
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
%>	Split 'str' in all parts that are separated by `delimiter'. Delimiter
%>	defaults to ' ' if omitted.  Empty delimited substrings are returned as such:
%>	If isRegex is true the delimiter is treated as a Java compatible regular expression.
%>
%>	Example:
%>	stringSplit( 'fffxxx,fff,xxx', 'fff' )
%>	 ans =
%>	   ''    'xxx,'    ',xxx'
% ======================================================================
function parts = stringSplit( str, delimiter, isRegex )


if(~exist('delimiter','var'))
    delimiter = ' ';
end

if(~exist('isRegex','var'))
    isRegex = false;
end

if(isRegex)
    s = java.lang.String(str);
    parts = cell(s.split(delimiter));
else
    indices = strfind( str, delimiter );
    
    if isempty( indices )
        parts = { str };
    else
        if indices(1) == 1
            parts = { '' };
        else
            parts = { str(1:(indices(1)-1)) };
        end
        for k=2:length(indices)
            start = indices(k-1) + length(delimiter);
            stop = indices(k)-1;
            if stop < start
                parts{end+1} = '';
            else
                parts{end+1} = str(start:stop);
            end
        end
        
        start = indices(end)+length(delimiter);
        if start > length(str)
            parts{end+1} = '';
        else
            parts{end+1} = str(start:end);
        end
    end
end
