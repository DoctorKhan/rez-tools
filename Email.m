function Email(sTo, sCC, sBody, varargin)

% Email(sRecipient, varargin);
%
% Emails the current figure as png to designated person and CCs it to you
% as well.
% Edit UserEmail.m to add contacts or type the full email address as the
% first argument.
%
% Usage: Email reswanul@gmail.com This is the latest figure
% Usage: Email This figure will be sent only to me.
% Usage: Email David This is the latest figure.
%
% Khan 03/01/2010

%% Validation
assert(isunix, 'Email requires unix.');

%% Default params
Default csTo | csCC | sBody | sSubject;

%% Argument handling
csCC = regexp(sCC, ' ', 'split');
vbEmails = CellFun(@isEmail, csCC);

if any(~vbEmails)
	csBody = [csCC(~vbEmails) sBody];
end

if any(vbEmails)
	csCC = csCC(vbEmails);
else
	csCC = {UserEmail};
end

csCC = CellFun(@dquote, CellFun(@UserEmail, csCC));

csTo = regexp(sTo, ' ', 'split');
vbEmails = CellFun(@isEmail, csTo);

if any(~vbEmails)
	csBody = [csTo(~vbEmails) sBody];
end

if any(vbEmails)
	csTo = csTo(vbEmails); 
else
	csTo = {UserEmail};
end

csTo = CellFun(@dquote, CellFun(@UserEmail, csTo));

if isequal(csCC(1), csTo(1)), csCC(1) = []; end

sBody = dquote(Str(csBody, varargin, {' '}));

%% Initialize
try
	sTitle = get(get(gca, 'Title'), 'String');
catch
	sTitle = Str('Figure', gcf);
end

sSubject = dquote(sTitle);

% File name = Title - spaces
sFile = regexprep(sTitle, '\W', '');
cpFiles{1} = ['/tmp/' sFile '.fig'];
% pFile2 = ['/tmp/' sFile '.png'];

%% Main
SaveFigure(cpFiles{1});

if ~isempty(csCC), csCC = ['-c', csCC]; end
sSubject = Str('-s', sSubject);
cpFiles2 = ['-a', CellFun(@dquote, cpFiles), '--'];

% ImgFrame = getframe(gcf);
% imwrite(ImgFrame.cdata, pFile2);

sCom=Str('echo', sBody, '| mutt', sSubject, csCC, cpFiles2, csTo, {' '});
%disp(regexprep(sCom, '-', [CarriageReturn '-']))
linux(sCom);


rm(cpFiles{:});

end %function


%% Note: type "doc hungarian" for variable prefix explanation.
