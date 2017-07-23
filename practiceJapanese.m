%% This function is for practicising Japanese scripts.
% It takes two arguments, a string which should be 'hiragana' or
% 'katakana'. A second argument should specify 'english' or 'japanese'.
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

function practiceJapanese(script, mode)

if nargin < 0 || nargin > 2
    error('Require at least 1 and no more than 2 arguments.');
else
    if ~(strcmp(script, 'hiragana') || strcmp(script, 'katakana'))
        error('First argument should specify hiragana or katakana.');
    end
    if nargin == 2
        if ~strcmp(mode, 'english')
            error('Optional argument not recognised.')
        end
    else
        mode = 'japanese';
    end
end

% Create map from sounds to Hiragana.
load('hiragana.mat')

vowels_hiragana = {ha(1), ha(2), ha(3), ha(4), ha(5)};
vowels_english = {'a', 'i', 'u', 'e', 'o'};

k_hiragana = {ha(6), ha(7), ha(8), ha(9), ha(10)};
k_english = {'ka', 'ki', 'ku', 'ke', 'ko'};

s_hiragana = {ha(11), ha(12), ha(13), ha(14), ha(15)};
s_english = {'sa', 'shi', 'su', 'se', 'so'};

if strcmp(mode, 'english')
    keySet = [vowels_english, k_english, s_english];
    valueSet = [vowels_hiragana, k_hiragana, s_hiragana];
else
    valueSet = [vowels_english, k_english, s_english];
    keySet = [vowels_hiragana, k_hiragana, s_hiragana];
end
n_letters = size(keySet,2);


ss = get(0,'screensize');
b = 7; % border around figures is 7 pixels wide
%TODO different for various operating systems and possibly configurations.
p = 0; % extra padding pixels from left edge of screen

if ispc
    win = feature('getos');
    i = (1:2) + regexp(win,'Windows ','end');
    switch win(i)
        case '10'
            b = 0;
            p = 10;
        otherwise
            % other cases will be added in the future
    end
end

fwp = ss(3)/2-2*b-p; % figure width in pixels
b = b+p;
n = 5;
%set(0,'defaultfigureposition',[b ss(4)/n, fwp, ss(4)*(1-2/n)])
%clear



rng('shuffle');

bottom = [ss(3)/2+p/2, ss(4)*1/20, fwp, ss(4)*(1-3/n)-(ss(4)/20)/2];
top = [ss(3)/2+p/2, ss(4)/2+(ss(4)*1/20)/2, fwp, ss(4)*(1-3/n)-(ss(4)/20)/2];

figure('Name','Display window','NumberTitle','off', 'Units', 'pixels', 'Position', top)
dwin = uicontrol('Style', 'text', 'FontSize', 150, 'ForegroundColor', 'b', 'Units','normalized','Position', [0 0 1 0.95]);

draw = figure('Name','Draw window','NumberTitle','off', 'Units', 'pixels', 'Position', bottom, 'Resize', 'off');
axis([0 1 0 1]);

drawnow
commandwindow

while true
    fprintf('You are trying to learn Japanese!\nYou have selected %s mode.\n', mode);
    order = randperm(n_letters);
    if strcmp(mode, 'english')
        for i=1:n_letters
            fprintf('Please draw the %s for the sound: \n\n', script);
            
            set(dwin, 'String', [keySet{order(i)} '?'])
            fprintf('%s\n\n', keySet{order(i)});
            %draw = uicontrol('Style', 'text', 'FontSize', 150, 'ForegroundColor', 'b', 'Units','normalized','Position', [0 0 1 0.95]); 
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
                data=get(h); 
                xydata=get(data.Children(4));
                k = waitforbuttonpress;
                if strcmp(get(gcf,'Selectiontype'), 'alt');
                    break
                end
            end
            fprintf('The correct answer was: \n\n'); 
            
            fprintf('%s\n\n', valueSet{order(i)});
            set(dwin, 'String', [keySet{order(i)} ' = ' valueSet{order(i)}])
            
            fprintf('Did you get it right?\n');
            next = 0;
            while ~(strcmp(next, 'n'))
                commandwindow
                next = input('Type n to move on.\n', 's');
            end
        end
    else
        display('hi');
    end
    fprintf('No more letters in dictionary!\n');
    restart = 0;
    while ~(strcmp(restart, 'y') || strcmp(restart, 'e'))
        restart = input('Type y to restart, or e to exit.\n', 's');
        if strcmp(restart, 'e')
            display('Bye!')
            delete(gcf)
            return
        end
    end
end

end