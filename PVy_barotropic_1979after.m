%%  计算正压PVy 用NCEP月平均资料，1979年1月开始

% Calculate the barotropic of PVy
% Version 1.0
% Revision on Aug 31, 2025.
% Copyright by Jiaqi Shi, Aug 31, 2025.

clear; clc; close all;
% -------------500hPa u------------
filename='F:\Data\NCEP\uwnd.mon.mean.nc';
lat=ncread(filename,'lat');
lon=ncread(filename,'lon');
domain=[0 357.5 0 90];
lonk1=find(lon==domain(1));
lonk2=find(lon==domain(2));
latk1=find(lat==domain(4));
latk2=find(lat==domain(3));
u=ncread(filename,'uwnd',...
       [lonk1 latk1 6 373],[lonk2-lonk1+1 latk2-latk1+1 1 inf]);%lon lat lev time
% 373 :1979.1
% inf : 2024.6
u=double(u);
u=squeeze(u);
lat=0:2.5:90;
lon=0:2.5:357.5;
u=fliplr(u);
%% 计算 无量纲 PVy
beta=10^(12)*2*7.292*10^(-5)*cos(55/180*pi)/10/6371000; %omega=7.292*10^(-5)/s, R=6371km , 参考纬度选55N, 结果无量纲化 
dy=2.5*pi/180*6.371*10^6;%有量纲
U=u/10;%无量纲化
t_num=size(u,3);
for t=1:t_num
    for i=1:144
        Uyy(i,1,t)=0;
        Uyy(i,37,t)=0;
        PVy(i,1,t)=0;
        PVy(i,37,t)=0;
        for j=2:36
            du=u(i,j+1,t)-2*u(i,j,t)+u(i,j-1,t);%有量纲
            Uyy(i,j,t)=du/(dy^2)*(10^11);%无量纲
            PVy(i,j,t)=beta+1*U(i,j,t)-Uyy(i,j,t); % 无量纲
        end
    end
end
 
%% 冬季平均
i=1;
for t=12:12:size(PVy,3)-2
    PVy_djf(:,:,i)=mean(PVy(:,:,t:t+2),3); % 1979.12 --- 2021.2 DJF-mean
    i=i+1;
end
variable=mean(PVy_djf(:,:,32:35),3);
close all;
set(0,'defaultfigurecolor','w');
fig1 = figure(1);
ax = axes('Parent',fig1,'Units','normalized','position',[0.05 0.2 0.8 0.6]);
m_proj('stereographic','lat',90,'long',0,'radius',60);
m_coast('linewidth',1,'color','k');
m_coast('patch',[0.8 0.8 0.8]);
hold on
variable(find(variable==0))=NaN;
[C,h]=m_contourf(lon,lat,variable',20,'linestyle','none'); 
m_coast('linewidth',1,'color','k');
hb = colorbar('location','eastoutside');
set(hb,'Units','normalized','position',[0.72 0.2 0.02 0.6]);  %colorbar
m_grid('linestyle','--','xtick',12,'ytick',6,'yticklabel',[],...
    'tickdir','in','fontsize',10)   
if abs(min(min(variable)))<=max(max(variable))
    c_val=max(max(variable));
else
    c_val=-min(min(variable));
end
caxis([-10 10]);
load('D:\matlab\colorbar\colorbar\MPL_bwr.mat');
colormap(MPL_bwr)
hb1 = title('Barotropic PVy (500hPa, DJF, 1979-2013)');
set(hb1,'Units','normalized','position',[0.55 1.1])

