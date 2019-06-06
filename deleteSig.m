fid = fopen('q_gt.txt');
aa = fgetl(fid);
writeString = {};
ii = 0;
while ischar(aa)
    ii = ii + 1;
    writeString{ii,1} = aa(2 : end - 1);
    aa = fgetl(fid);
end

fclose(fid);

fid = fopen('q_gt.txt','w');
for ii = 1 : length(writeString)
    fprintf(fid,[writeString{ii,1},'\n']);
end
fclose(fid);