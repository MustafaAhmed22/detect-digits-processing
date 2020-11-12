% function [ Digits ] = RecognizePlate_last( image )

image = imread ('License1.jpg');
input_directory = 'C:\MY FILES\task morphology\Digits';
filenames = dir(fullfile(input_directory, '*.bmp'));
num_images = length(filenames);


% 
imgray = rgb2gray (image) ;
imbin = imbinarize(imgray, 'global');
    imcom = ~(imbin) ;
    figure , imshow (imcom);
imfil = imfill (imbin, 'holes');
imconcom = bwconncomp (imfil); 
numPixels = cellfun(@numel,imconcom.PixelIdxList);
figure , imshow(numPixels);

[biggest,idx] = max(numPixels);

Image2 = zeros(size(imfil));
Image2(imconcom.PixelIdxList{idx}) = 1;
figure , imshow (Image2);
res = Image2 & imcom;
filt = medfilt2 (res);
% filt1 = medfilt2 (filt);
% filt2 = medfilt2 (filt1);

filter1 = bwmorph (filt ,'clean');
filtr2 = bwmorph (filter1 , 'open') ;

% filter2 = bwmorph (filtr2 , 'close') ;


% se  = strel ('disk' ,2);
% filtr2 = imerode (filtr2 , se);

%  filter3  =imfill (filtr2 , 'holes');
 w = bwareaopen (filtr2 ,1700);
 figure , imshow (w);
[labelled jml] = bwlabel(w);
    lisincenumbers = [];

 Iprops=regionprops(w,'BoundingBox','Image');
 for i=1:3
      percentf=9999;
     index =0;
     count =[];
    gambar{i}= Iprops(i).Image;
    figure , imshow (gambar{i}); 
%      resi = imresize (gambar{i} ,[200,200]);
%      figure ,imshow(gambar{i});
  
    for j =1 : num_images
   filename = fullfile(input_directory, filenames(j).name);
     imag = imread (filename) ;
     
     img2 = rgb2gray (imag);
           bw2 = medfilt2  (img2);

     bw2 = imbinarize(bw2, 'global');

%      bw2 =  imbinarize (img2 ,0.2);
 
    
%      bw2 = medfilt2  (bw2);
%      bw2 = medfilt2  (bw2);
%       se = strel('disk',0);
%  bw2 = imerode(bw2,se);
%         bw2 = bwmorph(bw2,'close');

v2 = ~ (bw2);

 v2 = bwmorph (v2 , 'fill');
   v2 = bwmorph (v2 , 'open');

 v2 = imfill(v2,'holes');
% [h,w] =size (v2);
% vr = imresize (image , [h,w]);

%  resi2 = imresize (v2 , [200,200]);
%   figure , imshow(v2);
v2 = imresize (v2 , [100,100]); %msh dynamic
newsize = imresize (gambar{i} ,[100,100]); %msh dynamic
% newsize = imresize (gambar{i},size(v2));  %dynamic
final = v2 - newsize;
%     figure , imshow (final);
c=0;
[m , n ] = size (final);

for z = 1 : m 
   for  f = 1 : n 
    if (final (z,f)==1)
    c=c+1;
    end 
   end
end 
count (j)= c ;
percent = (c / (m*n))*100;
if (percent <percentf)
    percentf =percent;
    index = j;
end

    end
    
%     mincount = min (count);
%     for s=1: num_images
%         if (count (i)== mincount)
%             index = i;
%         end
%         
%     end
   
    if (index ==1)
       lisincenumbers(i)=1; 
    end
     if (index ==2)
       lisincenumbers(i)=3; 
     end
     if (index ==3)
       lisincenumbers(i)=4;
     end
     if (index ==4)
       lisincenumbers(i)=6;
     end
     if (index ==5)
       lisincenumbers(i)=7;
     end
     if (index ==6)
       lisincenumbers(i)=8;
     end
     if (index ==7)
       lisincenumbers(i)=9;
    end
 end
 
 
%  figure , imshow (w);

Digits = lisincenumbers;
% end
