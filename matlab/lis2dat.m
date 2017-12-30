% -------------------------------------------------------------------------
%  General License and Warranty:
%  ------------------------------------------------------------------------
%  This is free open source piece of code; you can redistribute it and/or
%  modify it. This program is distributed in the hope that it will be
%  useful, but WITHOUT any warranty; WITHOUT even the implied warranty of
%  merchantability or fitness for A particular purpose.
%
%  My students:
%  *************
%  If you have questions or comments or bug reports, feel free to contact 
%  me and I will try to respond in a timely manner.
%--------------------------------------------------------------------------
function lis2dat(varargin)
% This extract the simulation results data from *.lis file and save it in
% a text file,'H.dat'. This text file can be loaded into Matlab to plot
% the graphs/further process the result.
%
% Syntax:
%  (1)   lis2dat('your-netlist-file-name.lis')
%  (2)   Or it will automatically consider the input file name as
%        'netlist.lis'
%  (3)   You also can enter 'your-netlist-file-name.lis' in this script as:
%        LisFN = 'your-netlist-file-name.lis'
%
%  (4) To read the 'H.dat' into Matlab you can use:
%      HData = load('H.dat');
%
%  (5) You need to copy it to the directory where 'your-netlist-file-name.lis'
%      is located.
%
%  By: Dr. Behzad NOURI
%  Last Update:2017/07/02
%--------------------------------------------------------------------------

LisFN = '../netlist.lis';
DatFN = '../!DO/Y';
%------------------------------------------
narginchk(0,2);
if nargin >=1
    LisFN  = strcat(varargin{1},'.lis');
end
if nargin >=2
    DatFN  = strcat(varargin{1},'.dat');
end

fid=fopen(LisFN);
if fid < 0
    error('*.lis file was not found!');
end
n=1;
Nsec=1;
Xflag=0;
Yflag=0;
while feof(fid) == 0  %Reading *.lis file line by line untill EOF
    tline = fgetl(fid);
    
    Temp = sscanf(tline, '%s');
    if length(Temp)==1
        if strcmpi(Temp,'X')
            FN=strcat(DatFN,num2str(Nsec),'.dat');
            Hfid=fopen(FN,'w');
            Nsec=Nsec+1;
            Xflag=1;
            Yflag=0;
            nn=1;
        elseif strncmpi(Temp,'Y',1)
            Xflag=0;
            Yflag=1;
            
        end
    end
    if isempty(tline); continue; end;
    
    if Xflag
        if nn<=4
            tline =strcat('%',tline);
            nn=nn+1;
        end
    end
    
    if Xflag==1 && Yflag==0
        fprintf(Hfid,'%s\n',tline);
        n=n+1;
    end
    
    if Xflag==0 && Yflag==1
        if n<10
            fprintf(Hfid,'\n%s\n','There is somthing wrong with *.lis file');
        else
            fprintf(Hfid,'%s\n','%y');
            Xflag=0;
            Yflag=0;
        end
        fclose(Hfid);
        fprintf('\n\n%s file was saved.\n\n', FN);
    end
end
fclose all;
end




