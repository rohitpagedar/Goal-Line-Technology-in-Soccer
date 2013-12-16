clear blobs;

% Function call for Line Detection. Extract the end points of the goal line
[x1 y1 x2 y2]=line1();

%calculate slope of the line
if x2-x1==0
    m=999;
else
m=y2-y1/x2-x1;
end


%set(0,'DefaultFigureWindowStyle','docked') %dock the figures..just a personal preference you don't need this.
                                                                                                                                                                                                                                                                                                            
base_dir = 'C:\Program Files\MATLAB\R2012a\bin\dagasirr';


 cd(base_dir);
% Retrive list of all images in the base directory.

f_list =  dir('*jpg');

alt_dir = 'C:\Program Files\MATLAB\R2012a\bin\dagasirr\images';

%Browse through each image separately.

 for i = 1:length(f_list)
     
     %load in the image and convert to double too allow for computations on the image
      img_real = f_list(i).name; 
     if strcmp(img_real,'img11.jpg')
         continue;
     end
     



% Optimal call for each frame.
im_in = read_image(img_real);
im_show=imread(img_real);
blobs = detect_blobs(im_in, 0.2, 2.5:0.5:3.0);
blobs_trimmed = prune_blobs(blobs, 0.25);




len=length(blobs_trimmed);
index=1;
if(len>1)
    xmin=1000;
    for j=1:len
        b=blobs_trimmed{j};
        xcoo=b(2);
        ycoo=b(1);
        if xcoo<xmin && ycoo>100
            xmin=xcoo;
            index=j;
        end
    end
    blob_info=blobs_trimmed{index};
else


    
    blob_info = blobs_trimmed{1};
end
    disp(blob_info(1));
    disp(blob_info(2));
    disp(blob_info(3));
    
%Extract X-coordinate, Y-coordinate and Radius of the blob for computations.    
xc=blob_info(2);
yc=blob_info(1);
rc=1.5*blob_info(3);

%Calculate distance of the ball from the goal line to predict whether it is
%a goal or not. (using distance formula from co-ordinate geometry).
if m==999
dist=abs(xc-x2);
else

dist=abs((m*xc-yc+y1-m*x1)/(sqrt(1+m*m)));
end
disp(dist);

%Calculate X-coordinate of the point of intersection the goal line with
%line passing through center perpendicular to goal line.
xcood=x1+(yc-y1)/m;
    hold on
  imshow(uint8(im_show));    


%Compare X-coordinates of center and point of intersection with distance in
%determining if it is a goal or not.

if((xc<xcood)||((xc>xcood)&&(dist<rc))) % Condition for not a GOAL.
    disp('no goal');
     [circx circy] = create_circle(yc,xc,rc);
     plot(circy, circx, '-r', 'linewidth', 2);
mkdir('images');
cd(alt_dir);
saveas(gcf,img_real,'jpg');
cd(base_dir);
    
%GOAL condition
else
    disp('goal');
    [circx circy] = create_circle(yc,xc,rc);
     plot(circy, circx, '-r', 'linewidth', 2,'Color','green');

     cd(alt_dir);
saveas(gcf,img_real,'jpg');


saveas(gcf,'s','jpg');

saveas(gcf,'ss','jpg');

saveas(gcf,'sss','jpg');

cd(base_dir);
[y,Fs] = wavread('goalsound');
      sound(y,Fs);
    break
end


    %fprintf('x: %f \t y: %f \t value: %f\n', blob_info(1), blob_info(2), blob_info(4)); 
    
    


 end
 
 writerObj = VideoWriter('goal.avi','Motion JPEG AVI');

writerObj.FrameRate=3;
open(writerObj);
 



cd(alt_dir);

f_list1 =  dir('*jpg');




for i = 1:length(f_list1)
%    disp(f_list(i).name);
    image = (imread(f_list1(i).name));
    writeVideo(writerObj,image);
  

end

%// close the file handle.

close(writerObj);

cd(base_dir);
% implay('goal.avi');
%      [y,Fs] = wavread('goalsound');
%      sound(y,Fs); 
 
 disp('end');
 
 