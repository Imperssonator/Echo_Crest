%> @file structMerge.m
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
%>	Add structure fields of `s2' to struct `s1',
%>	If s1 already contains fields in `s2',
%>	leave them as-is.
%>
%>	Example:
%>	>> A = struct( 'A', 1, 'B', 2, 'C', 'xxx' );
%>	>> B = struct( 'A',666, 'D', 5, 'C', [ 7 7 ] );
%>	>> struct_merge( A,B)
%>	ans =
%>	 A: 1
%>	 B: 2
%>	 C: 'xxx'
%>	 D: 5
%>
%>	>> struct_merge( B,A)
%>	ans =
%>	 A: 666
%>	 D: 5
%>	 C: [7 7]
%>	 B: 2
% ======================================================================
function s1 = structMerge( s1, s2 )


names = fieldnames( s2 );
for i=1:length(names)
	if ~isfield( s1, names{i} )
		s1 = setfield( s1, names{i}, getfield( s2, names{i} ) );
	end
end
