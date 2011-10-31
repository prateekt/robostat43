function str = toArff(TBL, file)

%set up
str = sprintf('%s\n\n','@relation stepDir');

%attr strings
for i=1:(size(TBL,2)-1)
    str = sprintf('%s%s%i',str,'@attribute f',i,' real');    
    str = sprintf('%s\n',str);
end

%last attr
str = sprintf('%s%s',str,'@attribute classif {DUMMY, ');
uniqueLabels = unique(TBL(:,end));
for i=1:length(uniqueLabels)
    str = sprintf('%s%i',str,uniqueLabels(i));
    if(i~=length(uniqueLabels))
         str = [str, ','];
    end
end
str = sprintf('%s%s',str,'}');
str = sprintf('%s\n\n',str);

%set up data area
str = sprintf('%s\n', [str,'@data']);
for i=1:size(TBL,1)
    for j=1:size(TBL,2)
        str = [str, num2str(TBL(i,j))];
        if(j~=size(TBL,2))
             str = [str, ','];
        end
    end
    str = sprintf('%s\n',str);
end

% open the file with write permission
fid = fopen(file, 'w');
fprintf(fid, '%s', str);
fclose(fid);