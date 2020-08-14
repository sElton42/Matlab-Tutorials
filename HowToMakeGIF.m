% Cleans Workspace, Closes opened windows and Cleans Command Window
clear, close all, clc
%% Creating our Electromagnetic Wave points

% Defines the number of points used to construct our wave
numberPoints = 500;

% Creates our time vector
t = linspace(0, 3*pi, numberPoints); % t is given in seconds (s)

% Calculates the field value on each time point
E = sin(2*pi*t/3); % A*sin(2*pi*f*t) with A = 1 and f = 1/3 Hz
B = sin(2*pi*t/3);

% Starts to count the time used to construct our animated Plot
tic

% Builds our graph, point-a-point, and saves in our Current Folder
% each frame of the graph
for k = 1:length(t)

%   For the first point, initiates all graph config.
    if k == 1
        figure(); % opens a figure window
        hold on   % holds current graph
        grid on   % Activates the grid

%       Sets axes limits, ticks, Font Size and Line Width of current graph
        xlim([-1 1]);
        ylim([0 3*pi]);
        zlim([-1 1]);
        set(gca, 'xtick', -1:0.5:1, 'ytick', 0:1:3*pi, 'ztick', -1:0.5:1, 'FontSize', 10, 'lineWidth',2);

%       Plots the first point of each curve, configuring color, format,
%       Line Width and Marker Size
        plot3(0, t(k), E(k), 'r.', 'LineWidth', 2, 'MarkerSize', 12); 
        plot3(B(k), t(k), 0, 'b.','LineWidth', 2, 'MarkerSize', 12);

%       Defines axes labels and graph title
        xlabel('X');
        ylabel('Y');
        zlabel('Z');
        title('Electromagnetic Wave')
        
%       Sets graph viewpoint
        view([50 40])
        
%       Continues plotting the curves
    else
        plot3(0, t(k), E(k), 'r.', 'LineWidth', 2, 'MarkerSize', 12); 
        plot3(B(k), t(k), 0, 'b.','LineWidth', 2, 'MarkerSize', 12);
    end

%   Creates legends for each curve
    legend('Electric Field', 'Magnetic Field');

%   drawnow permit us to see the plotting occurring point-a-point
    drawnow
%   Shows iteration number and time lapsed
    k
    toc
    
%   Saves every frame from the plot as Frame (Iteration N°)
%   in PNG with 150 PPI
    print(['Frame ' num2str(k)], '-dpng', '-r150');
end

%% Creating our GIF

% Gives name to our GIF
GifName = 'EMWave.gif';

% Sets delay between frames (s)
delay = 0.05;

% Constructs our GIF
for kk = 1:length(t)
    
%   Reads our generated PNGs previously
    [A, ~] = imread(['Frame ' num2str(kk) '.png']);
    
%   Stores image data in X and color scale in map after convert from
%   RGB to indexed image
%   Obs.: GIFs only accepts 8 bit images
    [X, map] = rgb2ind(A, 256);
    
%   Starts to construct GIF file frame by frame
%   imwrite receives image data, color scale, file name, delay between frames
%   and constructs a the GIF
%   LoopCount inf causes the animation to continuously loop
    if kk == 1
        imwrite(X, map, GifName, 'gif', 'LoopCount', inf, 'DelayTime', delay)
    else
%   WriteMode append causes to add a single frame to an existing file
        imwrite(X, map, GifName, 'gif', 'WriteMode', 'append', 'DelayTime', delay)
    end
end

% Prints a message telling us the GIF is concluded!
disp('End!')