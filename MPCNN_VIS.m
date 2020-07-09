function [ result1,source1 ] = MPCNN_VIS( img,a1,a2,b1,b2,c1,c2 )
%% MPCNN Fusion for all bands
img=Normalization(img);
gimg=MPCNN_fusion(img);
gimg=Normalization(gimg);
%% Exact visible bands falling RGB wavelength
R=img(:,:,a1:a2);
G=img(:,:,b1:b2);
B=img(:,:,c1:c2);
[ R] = average_fusion( R,1);
[ G] = average_fusion( G,1);
[ B] = average_fusion( B,1);
R=Normalization(R);
G=Normalization(G);
B=Normalization(B);
source=cat(3,R,G,B);
source1=imadjust(source,stretchlim(source,[0.01 0.99]),[]);
%%%%%%%%%%%%%%% Color mapping method %%%%%%%
w1=R./(R+G+B);
w2=G./(R+G+B);
w3=B./(R+G+B);
result(:,:,1)=w1.*gimg;
result(:,:,2)=w2.*gimg;
result(:,:,3)=w3.*gimg;
result1=imadjust(result,stretchlim(result,[0.01 0.99]),[]);

end

function re_img = Normalization( img )

[nu_lines,nu_rows,nu_bands]=size(img);
re_img=reshape(img,nu_lines*nu_rows,nu_bands);
re_img=scale_new(re_img);
re_img=reshape(re_img,[nu_lines nu_rows,nu_bands]);
end
function [data M m] =scale_new(data,M,m)
[Nb_s Nb_b]=size(data);
if nargin==1
    M=max(data,[],1);
    m=min(data,[],1);
end

data = (data-repmat(m,Nb_s,1))./(repmat(M-m,Nb_s,1));

end

function [ R ] = average_fusion( img,n )
%PCA_FUSION Summary of this function goes here
%   Detailed explanation goes here
no_bands=size(img,3);
for i=1:n
R(:,:,i)= mean(img(:,:,1+floor(no_bands/n)*(i-1):floor(no_bands/n)*i),3);
if (floor(no_bands/n)*i~=no_bands)&(i==n)
    R(:,:,i+1)=mean(img(:,:,0+floor(no_bands/n)*i:no_bands),3);
end    
end
end

