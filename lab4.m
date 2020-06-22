D = 'D:\study\cbivr\lab record\da2 lab\images';%GETTING THE PATH TO THE DIRECTORY%
S = dir(fullfile(D,'*.png'));%READING IMAGE NAMES%
qim=imread('D:\study\cbivr\lab record\da2 lab\images\bricks.png');
R =qim(:,:,1); % Red channel
G= qim(:,:,2); % Green channel
B= qim(:,:,3); % Blue channel
    Rm=mean2(R);
    Rstd=std2(R);
    Rvar=var(var(double(R)));
    Rskew=skewness(skewness(double(R)));
    Rkurtosis=kurtosis(kurtosis(double(R)));
    
    Gm=mean2(G);
    Gstd=std2(G);
    Gvar=var(var(double(G)));
    Gskew=skewness(skewness(double(G)));
    Gkurtosis=kurtosis(kurtosis(double(G)));
    Bm=mean2(B);
    Bstd=std2(B);
    Bvar=var(var(double(B)));
    Bskew=skewness(skewness(double(B)));
    Bkurtosis=kurtosis(kurtosis(double(B)));
    
%Creating table to store Feature Vectors%
info_table = cell2table(cell(0,17),'VariableNames',{'Imagename' 'RedMean' 'RedVariance' 'RedStd' 'RedSkewness' 'RedKurtosis' 'GreenMean' 'GreenVariance' 'GreenStd' 'GreenSkewness' 'GreenKurtosis' 'BlueMean' 'BlueVariance' 'BlueStd' 'BlueSkewness' 'BlueKurtosis' 'ed'});
for k = 1:numel(S)
   clear F;
   clear I;
   F= fullfile(D,S(k).name);
    I= imread(F);
    
    r =I(:,:,1); % Red channel
    g= I(:,:,2); % Green channel
    b= I(:,:,3); % Blue channel%CALCULATING COLOR FEATURES[COLOR PALNE SEPARATION]%
    rm=mean2(r);
    rstd=std2(r);
    rvar=var(var(double(r)));
    rskew=skewness(skewness(double(r)));
    rkurtosis=kurtosis(kurtosis(double(r)));
    gm=mean2(g);
    gstd=std2(g);
    gvar=var(var(double(g)));
    gskew=skewness(skewness(double(g)));
    gkurtosis=kurtosis(kurtosis(double(g)));
    bm=mean2(b);
    bstd=std2(b);
    bvar=var(var(double(b)));
    bskew=skewness(skewness(double(b)));
    bkurtosis=kurtosis(kurtosis(double(b)));
    
    ed=sqrt(((Rm-rm)^2)+((Rstd-rstd)^2)+((Rvar-rvar)^2)+((Rskew-rskew)^2)+((Rkurtosis-rkurtosis)^2)+((Gm-gm)^2)+((Gstd-gstd)^2)+((Gvar-gvar)^2)+((Gskew-gskew)^2)+((Gkurtosis-gkurtosis)^2)+((Bm-bm)^2)+((Bstd-bstd)^2)+((Bvar-bvar)^2)+((Bskew-bskew)^2)+((Bkurtosis-bkurtosis)^2));%CALCULATING EUCLIDEAN DISTANCE%
    new_row={S(k).name,rm,rstd,rvar,rskew,rkurtosis,gm,gstd,gvar,gskew,gkurtosis,bm,bstd,bvar,bskew,bkurtosis,ed};
    info_table=[info_table;new_row];
end
%SORTING THE TABLE ACCORDING TO ED%
 
info_table=sortrows(info_table,'ed');
writetable(info_table,'COLOR-DB.csv');
subplot(3,3,2);
imshow(qim);
title('Query Image');
file_names=info_table(:,'Imagename').Imagename;
%DISPLAYING THE TOP 6 IMAGES%
for k=1:5
    F=fullfile(D,char(file_names(k)));
    I=imread(F);
    subplot(3,3,k+3);
    imshow(I);
end
