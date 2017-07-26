%% This function is for practicising Japanese scripts.
% It takes three arguments, a string which should be 'hiragana' or
% 'katakana'. A second argument should specify 'english' or 'japanese'. The
% third argument is a string of Romanji letters, which determines what is
% to be tested. For example, if 't' is present in the string, all Japanese
% consonant-vowel sounds starting with 't' are included. For vowels, any of
% 'aeiou' will do. For everything, the string should be 'ALL' in all caps. 
%
% If 'japanese' is specified, a Japanese symbol is shown.
% The function will prompt for user input. If the correct
% vowel/consonant/consonant-vowel sound is given (in Romanji), the user
% will be told so and a new symbol will be generated. If not, the user will
% be asked to guess again. Returning 'exit' will instead stop the function.
%
% If 'english' specified, a Japanese sound will be display
% in Romanji. Then, the function will prompt the user to draw the symbol
% correpsonding to the sound, and write 'r' or 'ready' when done. Then, the
% function will show the correct symbol, and move on to the next. 

function practiceJapanese(script, mode, string)

% Parse the script type and the mode. 
if nargin < 2 || nargin > 3
    error('Require at least 2 and no more than 3 arguments.');
else
    if ~(strcmp(script, 'hiragana') || strcmp(script, 'katakana'))
        error('First argument should specify hiragana or katakana.');
    end
    if ~(strcmp(mode, 'english') || strcmp(script, 'japanese'))
        error('Only English or Japanese are accepted modes.');
    end
end

% Parse the 'string' input argument to decide which characters to include.
[english_set, hiragana_set] = loadLanguageSets(string); % for now Hiragana only

% Change which is the 'key' and which is the 'value' depending on the
% specified mode. 
if strcmp(mode, 'english')
    keySet = english_set;
    valueSet = hiragana_set;
else
    valueSet = english_set;
    keySet = hiragana_set;
end

% Save the number of characters we've ended up with.
n_letters = size(keySet,2);

% This code is supposed to make the graphs occupy the top/right and
% bottom/right quadrants of the screen, regardless of resolution.
% Unfortunately it doesn't really work and I expect it is resolution
% dependent, but as I'll just be running this on my laptop anyway I don't
% really want to invest a lot of time here. 
ss = get(0,'screensize');
b = 7; % border around figures is 7 pixels wide
p = 0; % extra padding pixels from left edge of screen

if ispc
    win = feature('getos');
    i = (1:2) + regexp(win,'Windows ','end');
    switch win(i)
        case '10'
            p = 10;
        otherwise
            % other cases will be added in the future
    end
end

fwp = ss(3)/2-2*b-p; % figure width in pixels
n = 5;

bottom = [ss(3)/2+p/2, ss(4)*1/20, fwp, ss(4)*(1-3/n)-(ss(4)/20)/2];
top = [ss(3)/2+p/2, ss(4)/2+(ss(4)*1/20)/2, fwp, ss(4)*(1-3/n)-(ss(4)/20)/2];

% Draw a figure for input. If the mode is 'english', also draw a window for
% drawing Hiragana. 
figure('Name','Display window','NumberTitle','off', 'Units', 'pixels', 'Position', top)
dwin = uicontrol('Style', 'text', 'FontSize', 150, 'ForegroundColor', 'b', 'Units','normalized','Position', [0 0 1 0.95]);

if strcmp(mode, 'english')
    draw = figure('Name','Draw window','NumberTitle','off', 'Units', 'pixels', 'Position', bottom, 'Resize', 'off');
    axis([0 1 0 1]);
end

% Draw the figures.
drawnow 

% Take us back to the command window for plotting.
commandwindow 

% Shuffle random seed.
rng('shuffle');

% Start learning Japanese. 
while true
    fprintf('You are trying to learn Japanese!\nYou have selected %s mode.\nYou will be tested on %i Japanese sounds.\n', mode, n_letters);
    order = randperm(n_letters);
    if strcmp(mode, 'english')
        for i=1:n_letters
            fprintf('\nPlease draw the %s for the sound: \n\n', script);
            
            set(dwin, 'String', [keySet{order(i)} '?'])
            fprintf('%s\n\n', keySet{order(i)}); 
            if i > 1
                for j=1:size(h_array,2)
                    h_array(1,j).delete();
                end
            end
         
            h_array = [];
            figure(draw);
            while true
                h = imfreehand('Closed',false);
                h_array = [h_array h];
                waitforbuttonpress
                if strcmp(get(gcf,'Selectiontype'), 'alt');
                    break
                end
            end
            fprintf('The correct answer was: \n\n'); 
            
            fprintf('%s\n\n', valueSet{order(i)});
            set(dwin, 'String', [keySet{order(i)} ' = ' valueSet{order(i)}])
            
            fprintf('Did you get it right?\n');
            fprintf('Right click to move on.\n');
            while true
                waitforbuttonpress;
                if strcmp(get(gcf,'Selectiontype'), 'alt');
                    break
                end
            end
        end
    else
        display('hi');
    end
    fprintf('\nNo more letters in dictionary!\n');
    restart = 0;
    while ~(strcmp(restart, 'y') || strcmp(restart, 'e'))
        commandwindow
        restart = input('Type y to restart, or e to exit.\n', 's');
        if strcmp(restart, 'e')
            fprintf('\nBye!\n')
            delete(gcf)
            return
        end
    end
end

end