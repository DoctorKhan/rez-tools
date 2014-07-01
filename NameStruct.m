function vo = NameStruct(varargin)

% vo = NameStruct(varargin);
%
% Returns struct and creates names objects from elements.
%
% Khan 01/10/2012
 
%% Default params


%% Initialize
% if Option('prefix.*=')
% 	[~,~,varargin,~,~,sPrefix] = Option('prefix.*=');
% end
Default sPrefix = "o"

%% Main
if isstruct(varargin{1})
	vo = varargin{1};
else
	vo = Str2Struct(varargin);
end

for o = vo
	sName = [sPrefix, StructName(o)];
	assignin('caller', sName, o);
end

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
