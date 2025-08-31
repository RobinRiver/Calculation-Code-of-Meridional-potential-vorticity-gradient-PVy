%%  计算斜压PVy 用NCEP月平均资料，1979年1月开始

% Calculate the baroclinic of PVy
% Version 1.0
% Revision on Aug 31, 2025.
% Copyright by Jiaqi Shi, Aug 31, 2025.

clear; clc; close all;
% --------------read 600、500、400hPa u------------------------
filename='F:\Data\NCEP\uwnd.mon.mean.nc';
lat=ncread(filename,'lat');
lon=ncread(filename,'lon');
domain=[0 357.5 0 90];
lonk1=find(lon==domain(1));
lonk2=find(lon==domain(2));
latk1=find(lat==domain(4));
latk2=find(lat==domain(3));
u=ncread(filename,'uwnd',...
       [lonk1 latk1 5 373],[lonk2-lonk1+1 latk2-latk1+1 3 inf]);%lon lat lev time
% 373 :1979.1
% inf : 2024.6
u=double(u);
u=squeeze(u);
u=fliplr(u); % 从0度到90度
% -----------------------read 600、500、400hPa v-------------------------
filename='F:\Data\NCEP\vwnd.mon.mean.nc';
lat=ncread(filename,'lat');
lon=ncread(filename,'lon');
lev=ncread(filename,'level');
domain=[0 357.5 0 90];
lonk1=find(lon==domain(1));
lonk2=find(lon==domain(2));
latk1=find(lat==domain(4));
latk2=find(lat==domain(3));
v=ncread(filename,'vwnd',...
       [lonk1 latk1 5 373],[lonk2-lonk1+1 latk2-latk1+1 3 inf]);%lon lat lev time
v=double(v);
v=squeeze(v);
v=fliplr(v);  %从0度到90度

lon=0:2.5:357.5;  lon=lon';
lat=0:2.5:90;   lat=lat';
lev=double(lev);
lev=lev(5:7); % 600; 500 400 hPa

%% 计算斜压PVy
beta=10^(12)*2*7.292*10^(-5)*cos(55/180*pi)/10/6371000; %omega=7.292*10^(-5)/s, R=6371km ,无量纲beta
Fr=0.72;
[Lat,Lon] = meshgrid(lat,lon);
dx_distance=dx_atmos(Lon, Lat);
dy_distance=dy_atmos(Lat);
dz_distance=1500;
t_num=size(u,4);
PVy=zeros(length(lon),length(lat),length(lev),t_num); %经度 纬度 高度 时间
% 向前差分计算微分
for t=1:t_num
    for i=2:length(lon)-1
        for j=2:length(lat)-1
            for k=2:length(lev)-1
                dx=dx_distance(i,j);
                dy=dy_distance(i,j);
                dz=dz_distance;
                
                dvxy=v(i+1,j+1,k,t)-v(i+1,j,k,t)-v(i,j+1,k,t)+v(i,j,k,t); 
                duyy=u(i,j+1,k,t)-2*u(i,j,k,t)+u(i,j-1,k,t);%有量纲             
           
                duz=u(i,j,k+1,t)-u(i,j,k,t);
                duzz=u(i,j,k+1,t)-2*u(i,j,k,t)+u(i,j,k-1,t);
                
                Vxy=dvxy/(dx*dy)*(10^11); %无量纲
                Uyy=duyy/(dy*dy)*(10^11); %无量纲
                Uz=duz/(dz)/10*10000; %无量纲
                Uzz=duzz/(dz*dz)/10*100000000; % 无量纲
                
                PVy(i,j,k,t)=beta+Vxy-Uyy+Fr*Uz-Fr*Uzz; % 无量纲
            end
        end
    end
end
%% 冬季平均气候态
i=1;
for t=12:12:size(PVy,4)-3
    PVy_djf(:,:,i)=mean(PVy(:,:,2,t:t+2),4);
    i=i+1;
    
end
% ------- 气候态  -------------------
variable = mean(PVy_djf,3);
% variable = trend*10;
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
m_grid('linestyle','--','xtick',12,'ytick',3,...
    'tickdir','in','fontsize',10)   
if abs(min(min(variable)))<=max(max(variable))
    c_val=max(max(variable));
else
    c_val=-min(min(variable));
end
caxis([-10 10]);
load('D:\matlab\colorbar\colorbar\MPL_bwr.mat');
colormap(MPL_bwr)
