function [] = PositionGenerator()
data_pos = dlmread('trajectory.txt');
data_arm = dlmread('arm.txt');
n_times = data_pos(1,1);
place_pos = data_arm(1,1);
n = 1;
for i = 2:n_times+1
    pos(n,1) = data_pos(i,1)/1000;
    pos(n,2) = data_pos(i,2)/1000;
    pos(n,3) = data_pos(i,3)/1000;
    n = n + 1; 
end

for i = 1:n_times
    P11(i,:) = [pos(i,1)-0.01, pos(i,2)-0.009, pos(i,3)-0.01];
    P12(i,:) = [pos(i,1)+0.01, pos(i,2)-0.009, pos(i,3)-0.01];
    P13(i,:) = [pos(i,1)+0.01, pos(i,2)-0.009, pos(i,3)+0.01];
    P14(i,:) = [pos(i,1)-0.01, pos(i,2)-0.009, pos(i,3)+0.01];
    P1(i,:) = [P11(i,:), P12(i,:), P13(i,:), P14(i,:)];
end

for i = 1:n_times
    P21(i,:) = [pos(i,1)+2.99, pos(i,2)-0.009, pos(i,3)-0.01];
    P22(i,:) = [pos(i,1)+3.01, pos(i,2)-0.009, pos(i,3)-0.01];
    P23(i,:) = [pos(i,1)+3.01, pos(i,2)-0.009, pos(i,3)+0.01];
    P24(i,:) = [pos(i,1)+2.99, pos(i,2)-0.009, pos(i,3)+0.01];
    P2(i,:) = [P21(i,:), P22(i,:), P23(i,:), P24(i,:)];
end

fileID = fopen('sqrposition.wrl','wt');
formatSpec = '#VRML V2.0 utf8\nTransform {\ntranslation 0 0 0\nchildren [';
fprintf(fileID,formatSpec);
if place_pos == 3
    for i = 1:n_times   
    formatSpec = '\nShape {\nappearance Appearance {\nmaterial Material {\nambientIntensity 0.444444444444444\ndiffuseColor 1 1 0\nemissiveColor 1 1 0\nspecularColor 1 1 0\n}\n}\ngeometry IndexedFaceSet {'
    fprintf(fileID,formatSpec);       
    formatSpec = '\ncoord Coordinate { point [ %4.2f %4.2f %4.2f %4.2f %4.2f %4.2f %4.2f %4.2f %4.2f %4.2f %4.2f %4.2f ] }\ncoordIndex [ 0 1 3 -1 3 1 2 -1 ]\n}\n}';
    fprintf(fileID,formatSpec,P1(i,:));
    end
end
if place_pos == 4
    for i = 1:n_times   
    formatSpec = '\nShape {\nappearance Appearance {\nmaterial Material {\nambientIntensity 0.444444444444444\ndiffuseColor 1 1 0\nemissiveColor 1 1 0\nspecularColor 1 1 0\n}\n}\ngeometry IndexedFaceSet {'
    fprintf(fileID,formatSpec);       
    formatSpec = '\ncoord Coordinate { point [ %4.2f %4.2f %4.2f %4.2f %4.2f %4.2f %4.2f %4.2f %4.2f %4.2f %4.2f %4.2f ] }\ncoordIndex [ 0 1 3 -1 3 1 2 -1 ]\n}\n}';
    fprintf(fileID,formatSpec,P2(i,:));
    end
end
formatSpec = '\n]\n}';
fprintf(fileID,formatSpec);   
fclose(fileID);
type sqrposition.wrl;
end