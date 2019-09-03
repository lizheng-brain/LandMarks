clear all;clc

basedir='/extra/lizheng/Aging_project/behavdata';
outfile='/extra/lizheng/Aging_project';
cd(basedir);
% sub_data structure
MID=1; % All ID;
TID=2;% trail id in each run;
KeyResponsecorr=3;% correct = 1; incorrect = 0;
KeyResponseRT=4;% RT for each trail;
MAonset=5; % actual onset time;
RunID=6;%RUN id;
City=7;
raw_rep=8;
pic1=9;
pic2=10;
pic3=11;
rep = 12;
RT_new = 13;
%%%%%%%%%%%%next for the RT is nan;
% sub_datafile=dir(sprintf('%s/sub*.mat', basedir));
% for sub = 1:(length(sub_datafile))
%     subid=str2num(sub_datafile(sub).name(4:6));
%     file=dir(sprintf('sub%03d.mat',subid));
%     load(file.name);
%     sub_data = table2array(sub_data);
%     n = size(sub_data,2);
%     sub_data(:,n+1) = sub_data(:,4);
%     filename = sprintf('sub%03d.mat',subid);
%     eval(sprintf('save %s sub_data', filename));
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ans(isnan(ans))=12;   
%%%%%%%%%%%%%relpace nan = nanmean within the run;
% sub_datafile=dir(sprintf('%s/sub*.mat', basedir));
% for sub = 1:(length(sub_datafile))
%     subid=str2num(sub_datafile(sub).name(4:6));
%     file=dir(sprintf('sub%03d.mat',subid));
%     load(file.name);
%     sub_data(isnan(sub_data(:,end)),end)=12;
%     for run = 1:length(unique(sub_data(:,RunID)))
%        pos = find(sub_data(:,end)==12 & sub_data(:,RunID)==run);
%        repvalue = nanmean(sub_data(find(sub_data(:,end)~=12 & sub_data(:,RunID)==run),end));        
%        sub_data(pos,end)=repvalue;        
%     end    
%     filename = sprintf('sub%03d_new.mat',subid);
%     eval(sprintf('save %s sub_data', filename));
% end


sub_datafile=dir(sprintf('%s/sub*_new.mat', basedir));
for sub = 1:(length(sub_datafile))
    subid=str2num(sub_datafile(sub).name(4:6));
    file=dir(sprintf('sub%03d_new.mat',subid));
    load(file.name);

    %%%get each trial's ev
    for run = 1:length(unique(subdata(:,RunID)))
        for i = 1:length(unique(subdata(:,TID)))
            aa = find(subdata(:,TID)==i & subdata(:,RunID)==run);
            tmp = subdata(aa,MAonset);
            RT = subdata(aa,end);
            tmp1=[tmp  RT ones(length(tmp),1)];
            outputfile=sprintf('%s/sub%03d/behav/trial%02d_run%01d.txt',outfile,subid,i,run);
            eval(sprintf('save %s tmp1 -tabs -ascii', outputfile));
        end
    end
    
    %%% get other trails's ev for each trial
    for run = 1:length(unique(subdata(:,RunID)))
        for i = 1:length(unique(subdata(:,TID)))
            aa = find((subdata(:,TID)~=i & subdata(:,RunID)==run));
            tmp = subdata(aa,MAonset);
            RT = subdata(aa,end);
            tmp1=[tmp RT ones(length(tmp),1)];
            outputfile=sprintf('%s/sub%03d/behav/othertrials%02d_run%01d.txt',outfile,subid,i,run);
            eval(sprintf('save %s tmp1 -tabs -ascii', outputfile));
        end
    end
    
 

    %%%get all trial's ev
    for run = 1:length(unique(subdata(:,RunID)))
         % for i = 1:length(unique(sub_data(:,TID)))
             aa=find(subdata(:,RunID)==run);
             tmp = subdata(aa,MAonset);
             rest_time = 12 - subdata(aa,end);
           
             tmp1=[tmp rest_time ones(length(tmp),1)];
            outputfile=sprintf('%s/sub%03d/behav/Rest_time_run%01d.txt',outfile,subid,run);
            eval(sprintf('save %s tmp1 -tabs -ascii', outputfile));
        end
    
end
    

    
    
    
    
    
    


    