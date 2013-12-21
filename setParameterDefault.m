function setParameterDefault(pname, defval)
% setParameterDefault(pname, defval)
% Author: Tobias Kienzler (http://stackoverflow.com/users/321973)
% sets the parameter NAMED pname to the value defval if it is undefined or
% empty

if ~isParameterDefined('pname')
    error('paramDef:noPname', 'No parameter name defined!');
elseif ~isvarname(pname)
    error('paramDef:pnameNotChar', 'pname is not a valid varname!');
elseif ~isParameterDefined('defval')
    error('paramDef:noDefval', ['No default value for ' pname ' defined!']);
end;

% isParameterNotDefined copy&pasted since evalin can't handle caller's
% caller...
if ~evalin('caller',  ['exist(''' pname ''', ''var'') && ~isempty(' pname ')'])
    callername = evalin('caller', 'mfilename');
    warnMsg = ['Setting ' pname ' to default value'];
    if isscalar(defval) || ischar(defval) || isvector(defval)
        warnMsg = [warnMsg ' (' num2str(defval) ')'];
    end;
    warnMsg = [warnMsg '!'];
    warning([callername ':paramDef:assigning'], warnMsg);
    assignin('caller', pname, defval);
end