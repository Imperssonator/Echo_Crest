
layers=struct()
Path1 = '~/Dropbox/Experiments/Chris Layers/Layer 1/Electrical/Transfer/';
Path2 = '~/Dropbox/Experiments/Chris Layers/Layer 2/Electrical/Transfer/';
Path3 = '~/Dropbox/Experiments/Chris Layers/Layer 3/Electrical/Transfer/';

% Layer 1 - TCB + Annealing Temp
[d1,a1]=do_the_mob(Path1);

Data1 = [...
    0 120;
    0 25;
    0 60;
    20 120;
    20 25;
    20 60;
    10 120;
    10 25;
    10 60   ];

% Get vertical channels
v1_inds=cellfun(@(x) strcmp(x(end),'V'),{a1(:).name},'UniformOutput',false);
v1_inds=cell2mat(v1_inds);
vert1=a1(v1_inds);

layers(1).data=Data1;
layers(1).results = vert1;

% Calculate Objective Function Values
for i = 1:length(layers(1).results);
    layers(1).results(i).obj_val = obj_fun(layers(1).results(i).mean_vt,layers(1).results(i).mean_mob,...
        max([layers(1).results(:).mean_mob]));
end

% Build models - first and second order
layers(1).reg_mob(1) = MultiPolyRegress(Data1,[vert1(:).mean_mob]',1);
layers(1).reg_mob(2) = MultiPolyRegress(Data1,[vert1(:).mean_mob]',2);
layers(1).reg_vt(1) = MultiPolyRegress(Data1,[vert1(:).mean_vt]',1);
layers(1).reg_vt(2) = MultiPolyRegress(Data1,[vert1(:).mean_vt]',2);
layers(1).reg_obj(1) = MultiPolyRegress(Data1,[layers(1).results(:).obj_val]',1);
layers(1).reg_obj(2) = MultiPolyRegress(Data1,[layers(1).results(:).obj_val]',2);

[~,best_fit1] = min([layers(1).reg_obj(:).CVMAE]);
modelSurf(layers(1).data,[layers(1).results(:).obj_val]',layers(1).reg_obj(best_fit1));
ax1=gca;
ax1.FontSize=16;
ax1.XLabel.String='TCB vol%';
ax1.YLabel.String='Annealing Temperature';
ax1.ZLabel.String='Objective Function';
ax1.Title.String='Layer 1';

%__________________________________________________________________________


% Layer 2 - Annealing Temp / Time
[d2,a2]=do_the_mob(Path2);

Data2 = [...
    100 10;
    100 15;
    100 5;
    120 10;
    120 15;
    120 5;
    140 10;
    140 15;
    140 5  ];

% Get vertical channels
v2_inds=cellfun(@(x) strcmp(x(end),'V'),{a2(:).name},'UniformOutput',false);
v2_inds=cell2mat(v2_inds);
vert2=a2(v2_inds);

vert2_0=vert2(end);
vert2=vert2(1:end-1);

layers(2).data=Data2;
layers(2).results = vert2;

% Calculate Objective Function Values
for i = 1:length(layers(2).results);
    layers(2).results(i).obj_val = obj_fun(layers(2).results(i).mean_vt,layers(2).results(i).mean_mob,...
        max([vert2_0(:).mean_mob]));
end

% Build models - first and second order
layers(2).reg_mob(1) = MultiPolyRegress(Data2,[vert2(:).mean_mob]',1);
layers(2).reg_mob(2) = MultiPolyRegress(Data2,[vert2(:).mean_mob]',2);
layers(2).reg_vt(1) = MultiPolyRegress(Data2,[vert2(:).mean_vt]',1);
layers(2).reg_vt(2) = MultiPolyRegress(Data2,[vert2(:).mean_vt]',2);
layers(2).reg_obj(1) = MultiPolyRegress(Data2,[layers(2).results(:).obj_val]',1);
layers(2).reg_obj(2) = MultiPolyRegress(Data2,[layers(2).results(:).obj_val]',2);

% Plot Results
[~,best_fit2] = min([layers(2).reg_obj(:).CVMAE]);
modelSurf(layers(2).data,[layers(2).results(:).obj_val]',layers(2).reg_obj(best_fit2));
ax2=gca;
ax2.FontSize=16;
ax2.XLabel.String='Annealing Temp.';
ax2.YLabel.String='Annealing Time';
ax2.ZLabel.String='Objective Function';
ax2.Title.String='Layer 2';

%__________________________________________________________________________


% Layer 2 - Annealing Temp / Time
[d3,a3]=do_the_mob(Path3);

Data3 = [...
    100 12.5;
    100 20;
    100 5;
    120 12.5;
    120 20;
    120 5;
    80 12.5;
    80 20;
    80 5  ];

% Get vertical channels
v3_inds=cellfun(@(x) strcmp(x(end),'V'),{a3(:).name},'UniformOutput',false);
v3_inds=cell2mat(v3_inds);
vert3=a3(v3_inds);

vert3_0=vert3(9);
vert3=vert3([1 3 4 5 6 7 10 11 12]);

layers(3).data=Data3;
layers(3).results = vert3;

% Calculate Objective Function Values
for i = 1:length(layers(3).results);
    layers(3).results(i).obj_val = obj_fun(layers(3).results(i).mean_vt,layers(3).results(i).mean_mob,...
        max([vert3_0(:).mean_mob]));
end

% Build models - first and second order
layers(3).reg_mob(1) = MultiPolyRegress(Data3,[vert3(:).mean_mob]',1);
layers(3).reg_mob(2) = MultiPolyRegress(Data3,[vert3(:).mean_mob]',2);
layers(3).reg_vt(1) = MultiPolyRegress(Data3,[vert3(:).mean_vt]',1);
layers(3).reg_vt(2) = MultiPolyRegress(Data3,[vert3(:).mean_vt]',2);
layers(3).reg_obj(1) = MultiPolyRegress(Data3,[layers(3).results(:).obj_val]',1);
layers(3).reg_obj(2) = MultiPolyRegress(Data3,[layers(3).results(:).obj_val]',2);

% Plot Results
[~,best_fit3] = min([layers(3).reg_obj(:).CVMAE]);
modelSurf(layers(3).data,[layers(3).results(:).obj_val]',layers(3).reg_obj(best_fit3));
ax3=gca;
ax3.FontSize=16;
ax3.XLabel.String='Annealing Temp.';
ax3.YLabel.String='Annealing Time';
ax3.ZLabel.String='Objective Function';
ax3.Title.String='Layer 3';