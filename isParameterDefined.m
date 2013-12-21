function b = isParameterDefined(pname)
% b = isParameterDefined(pname)
% Author: Tobias Kienzler (http://stackoverflow.com/users/321973)
% returns true if a parameter NAMED pname exists in the caller's workspace
% and if it is not empty

b = evalin('caller',  ['exist(''' pname ''', ''var'') && ~isempty(' pname ')']) ;