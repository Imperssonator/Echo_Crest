%> @file vectorizeString.m
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
%>	Convert a char array to a single line, with \n characters for
%>	indicating newlines instead of separate rows in the 2D array.
%>	Also trim whitespace from each line.
%>	Example:
%>	vectorizeString(['test1';'  2  '])
% ======================================================================
function vectorStr = vectorizeString(matrixStr)


if isempty(matrixStr)
	% empty matrix -> empty vector
	vectorStr = '';
else
	% start with the first line
	vectorStr = strtrim(matrixStr(1,:));
	
	% add the other lines in a loop, each line preceded by a lineSep
	for i=2:size(matrixStr,1)
		vectorStr = sprintf('%s\n%s', vectorStr, strtrim(matrixStr(i,:)));
	end
end
