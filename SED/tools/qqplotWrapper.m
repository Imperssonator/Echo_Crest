%> @file qqplotWrapper.m
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
%>	Wraps around qqplot of the Statistics toolbox if available
%>	Otherwise, providesown implementation
% ======================================================================
function qqplotWrapper( qqdata, varargin )


% We expect validationset

if nargin == 1
	% do nothing, qqdata should be 2 column vector.
	% first column: prediction
	% second column: real values
elseif nargin == 4 % model versus given testset
	% qqdata is 1-column vector with real values
	bestModel = varargin{1};
	outputIdx = varargin{2};
	testset = varargin{3};
	
	pred = evaluate( bestModel, testset );
	qqdata = [pred(:, outputIdx) qqdata];
end

stat = ver('stats'); % Look for Statistics toolbox
figure(gcf);

qqdata = complexFix( qqdata );

if isempty(stat)
	plot( qqdata(:,1), qqdata(:,2), 'k.');
	hold on
	plot( qqdata(:,2), qqdata(:,2) ); % column 2 are the real values
else
	qqplot( qqdata(:,1), qqdata(:,2) );
end

%title( 'QQPlot', 'FontSize', 14);
xlabel('y','FontSize',14,'interpreter','none');
ylabel('Predicted y','FontSize',14,'interpreter','none');
set(gca,'FontSize',14);
hold off

end
