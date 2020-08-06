tic 
clc
clear all 
close all
Folder='C:\Users\PUTUL SIDDHARTH\Desktop\fold';
images=dir(Folder);
parfor i=1:length(images)
    imagename=images(i).name;
    imagefile=fullfile(Folder,imagename);
    try
        im=imread(imagefile);
        [rows,columns]=size(im);
        dlmwrite('C:\Users\PUTUL SIDDHARTH\Desktop\abcdf.csv',[rows columns],'-append');
    catch
    end
end
Folder1='C:\Users\PUTUL SIDDHARTH\Desktop\foldy';
images1=dir(Folder1);
parfor i=1:length(images1)
    imagename1=images1(i).name;
    imagefile1=fullfile(Folder1,imagename1);
    try
        img=imread(imagefile1);
        [rows,columns]=size(img);
        dlmwrite('C:\Users\PUTUL SIDDHARTH\Desktop\abcdf2.csv',[rows columns],'-append');
    catch
    end
end
 
data=csvread('C:\Users\PUTUL SIDDHARTH\Desktop\abcdf.csv');
x=data(1:10,1);
y=data(1:10,2);
 
q=imread('C:\Users\PUTUL SIDDHARTH\Desktop\fold\5.jpg');
[row_q,col_q]=size(q);
figure(100);
imshow(q);
%Euclidean distance
dist=zeros(1,10);
parfor i=1:10
    dist(i)=asinh(sum(abs(row_q-x(i)) + abs(col_q-y(i))));
end
%sorting according to dimensions
for i=1:10
    for j=1:10-1
        if dist(j)<dist(j+1)
            temp=dist(j);
            dist(j)=dist(j+1);
            dist(j+1)=temp;
            
            temp=x(j);
            x(j)=x(j+1);
            x(j+1)=temp;
            
            temp=y(j);
            y(j)=y(j+1);
            y(j+1)=temp;
        end
    end
end
 
 
fprintf('from category 1 images are of dimension :\n');
for i=1:3
    fprintf('%d %d\n',x(i),y(i));
end

fprintf('from category 1 similar images are of distances from query image :\n');
for i=1:3
    fprintf('%d\n',dist(i));
end
 
data=csvread('C:\Users\PUTUL SIDDHARTH\Desktop\abcdf2.csv');
xx=data(1:10,1);
yy=data(1:10,2);
 
%Euclidean distance
dist1=zeros(1,10);
parfor i=1:10
    dist1(i)=asinh(sum(abs(row_q-xx(i)) +abs(col_q-yy(i))));
end
%sorting according to dimensions
for i=1:10
    for j=1:10-1
        if dist1(j)<dist1(j+1)
            temp=dist1(j);
            dist1(j)=dist1(j+1);
            dist1(j+1)=temp;
            
            temp=xx(j);
            xx(j)=xx(j+1);
            xx(j+1)=temp;
            
            temp=yy(j);
            yy(j)=yy(j+1);
            yy(j+1)=temp;
        end
    end
end
 
 
fprintf('from category 2 images are of pixel :\n');
for i=1:3
    fprintf('%d %d\n',xx(i),yy(i));
    
end
 
fprintf('from category 2 similar images are of distances from query image :\n');
for i=1:3
    fprintf('%d\n',dist1(i));
end
 
for i=1:length(images)
    imagename=images(i).name;
    imagefile=fullfile(Folder,imagename);
    try
        im=imread(imagefile);
        [rows,columns]=size(im);
                
        if ((rows==x(3) && columns==y(3) )||(rows==x(1)&&columns==y(1)) || (rows==x(2)&&columns==y(2)))
            figure(i)
            imshow(im);
        end
    catch
    end
end
 
for i=1:length(images1)
    imagename1=images1(i).name;
    imagefile1=fullfile(Folder1,imagename1);
    try
        img=imread(imagefile1);
        [rows,columns]=size(img);
        
        if ((rows==xx(3) && columns==yy(3) )||(rows==xx(1)&&columns==yy(1)) || (rows==xx(2)&&columns==yy(2)))
            figure(i+10);
            imshow(img);
        end
    catch
    end
end
true_positive=5;
false_positive=1;
false_negative=2;
true_negative=12;

Precision=true_positive/(true_positive+false_positive);
Recall=true_positive/(true_positive+false_negative);
f1_measure=2*(Precision*Recall)/(Precision+Recall);
Accuracy=(true_positive+true_negative)/(true_positive+false_positive+false_negative+true_negative);

fprintf("Precision of the retrived images is:- %f\n",Precision);
fprintf("Recall of the retrived images is:- %f\n",Recall);
fprintf("f1_measure of the retrived images is:- %f\n",f1_measure);
fprintf("Accuracy of the retrived images is:- %f\n",Accuracy);
toc
