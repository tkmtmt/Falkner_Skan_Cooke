% 無次元圧力勾配mを変化させたときの壁面勾配s、排除厚さdelta、運動量厚さtheta、
% 形状係数hを求めて、保存しておくプログラム
% 初めにmが正の領域について計算し、後にmが負の領域について計算する
% 加速境界層の時は壁面勾配誤差に注意

clear all
close all
clc
addpath('functions');

%% grid
jn = 400;
YL = 40;
yTH = 5;
eta = NonUniformSpacing(jn,YL,yTH);

MC = cell(1,2); SC = MC;
FC = MC; DFC = FC; DDFC = FC; DELTAC = FC; THETAC = FC; HC = FC;

%% Positive
MC{1} = linspace(0,2,1010);    % 無次元圧力勾配

count = 1;
for k = 1:length(MC{1})
    fprintf('Positive side : count = %d/%d\n',count,length(MC{1}));
    m = MC{1}(k);
    % 3次後退差分で壁面勾配値s0を予測
    if k >= 4
        s0 = SC{1}(k-1) + (3*SC{1}(k-1)-4*SC{1}(k-2)+SC{1}(k-3))/2;
    elseif k == 1
        s0 = 0.5;       % j = 1の時だけ
    else
        s0 = SC{1}(k-1);    % 前の壁面勾配値を使用
    end
        
    [~,FC{1}(k,:),DFC{1}(k,:),DDFC{1}(k,:),DELTAC{1}(k),THETAC{1}(k),HC{1}(k),SC{1}(k)] = FS_Pos(eta,s0,m);
    count = count+1;
end

%% Negative
SC{2} = linspace(0.331,-0.0982,505);
count = 1;
for k = 1:length(SC{2})
    fprintf('Negative side : count = %d/%d\n',count,length(SC{2}));
    % 3次後退差分で圧力勾配mを予測
    if k >= 4
        m0 = MC{2}(k-1) + (3*MC{2}(k-1)-4*MC{2}(k-2)+MC{2}(k-3))/2;
    elseif k == 1
        m0 = 0;       % j = 1の時だけ
    else
        m0 = MC{2}(k-1);    % 前の壁面勾配値を使用
    end
    
    [~,FC{2}(k,:),DFC{2}(k,:),DDFC{2}(k,:),DELTAC{2}(k),THETAC{2}(k),HC{2}(k),MC{2}(k)] = FS_Neg(eta,SC{2}(k),m0);
    count = count+1;
end

%% plot
for i = 1:2
    figure(1)
    plot(MC{i},SC{i},'.-');
    xlabel('m');
    ylabel('s');
    hold on

    figure(2)
    plot(MC{i},HC{i},'.-');
    xlabel('m');
    ylabel('h');
    hold on
end

%% save mを昇順に,列がetaに対応
ETA = eta;
M = [fliplr(MC{2}),MC{1}];
S = [fliplr(SC{2}),SC{1}];
DELTA = [fliplr(DELTAC{2}),DELTAC{1}];
THETA = [fliplr(THETAC{2}),THETAC{1}];
H = [fliplr(HC{2}),HC{1}];

F = [flipud(FC{2});FC{1}];
DF = [flipud(DFC{2});DFC{1}];
DDF = [flipud(DDFC{2});DDFC{1}];

save Falkner_Skan_Flow.mat ETA M S DELTA THETA H F DF DDF
% save Falkner_Skan_Flow.mat ETA MC SC DELTAC THETAC HC FC DFC DDFC