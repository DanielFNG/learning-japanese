function [ english_set, hiragana_set ] = loadLanguageSets( string )
% Create map from sounds to Hiragana, based on the input argument 'string'
% which specifies which sounds are to be included.

% Load entire Hiragana library.
load('hiragana.mat')

% Prepare arrays to hold the Hiragana and corresponding English sounds.
hiragana_set = [];
english_set = [];

% Pass through the string, identifying which sets of characters/sounds to
% add.
if size(strfind(string,'a'),2) > 0 || size(strfind(string,'e'),2) > 0 ...
        || size(strfind(string,'i'),2) > 0 || size(strfind(string, 'o'),2) ...
        > 0 || size(strfind(string,'u'),2) > 0 || strcmp(string, 'ALL')
    vowels_hiragana = {ha(1), ha(2), ha(3), ha(4), ha(5)};
    vowels_english = {'a', 'i', 'u', 'e', 'o'};
    
    hiragana_set = [hiragana_set, vowels_hiragana];
    english_set = [english_set, vowels_english];
end

if size(strfind(string,'k'),2) > 0 || strcmp(string, 'ALL')
    k_hiragana = {ha(6), ha(7), ha(8), ha(9), ha(10)};
    k_english = {'ka', 'ki', 'ku', 'ke', 'ko'};

    hiragana_set = [hiragana_set, k_hiragana];
    english_set = [english_set, k_english];
end

if size(strfind(string,'k'),2) > 0 || strcmp(string, 'ALL')
    s_hiragana = {ha(11), ha(12), ha(13), ha(14), ha(15)};
    s_english = {'sa', 'shi', 'su', 'se', 'so'};
    
    hiragana_set = [hiragana_set, s_hiragana];
    english_set = [english_set, s_english];
end

if size(strfind(string,'t'),2) > 0 || strcmp(string, 'ALL')
    t_hiragana = {ha(16), ha(17), ha(18), ha(19), ha(20)};
    t_english = {'ta', 'chi', 'tsu', 'te', 'to'};
    
    hiragana_set = [hiragana_set, t_hiragana];
    english_set = [english_set, t_english];
end

if size(strfind(string,'n'),2) > 0 || strcmp(string, 'ALL')
    n_hiragana = {ha(21), ha(22), ha(23), ha(24), ha(25), ha(26)};
    n_english = {'na', 'ni', 'nu', 'ne', 'no', 'n'};
    
    hiragana_set = [hiragana_set, n_hiragana];
    english_set = [english_set, n_english];
end

if size(strfind(string,'h'),2) > 0 || strcmp(string, 'ALL')
    h_hiragana = {ha(27), ha(28), ha(29), ha(30), ha(31)};
    h_english = {'ha', 'hi', 'fu', 'he', 'ho'};
    
    hiragana_set = [hiragana_set, h_hiragana];
    english_set = [english_set, h_english];
end

if size(strfind(string,'m'),2) > 0 || strcmp(string, 'ALL')
    m_hiragana = {ha(32), ha(33), ha(34), ha(35), ha(36)};
    m_english = {'ma', 'mi', 'mu', 'me', 'mo'};
    
    hiragana_set = [hiragana_set, m_hiragana];
    english_set = [english_set, m_english];
end

if size(strfind(string,'y'),2) > 0 || strcmp(string, 'ALL')
    y_hiragana = {ha(37), ha(38), ha(39)};
    y_english = {'ya', 'yu', 'yo'};
    
    hiragana_set = [hiragana_set, y_hiragana];
    english_set = [english_set, y_english];
end

if size(strfind(string,'r'),2) > 0 || strcmp(string, 'ALL')
    r_hiragana = {ha(40), ha(41), ha(42), ha(43), ha(44)};
    r_english = {'ra', 'ri', 'ru', 're', 'ro'};
    
    hiragana_set = [hiragana_set, r_hiragana];
    english_set = [english_set, r_english];
end

if size(strfind(string,'w'),2) > 0 || strcmp(string, 'ALL')
    w_hiragana = {ha(45), ha(46), ha(47), ha(48)};
    w_english = {'wa', 'wi', 'we', 'wo'};
    
    hiragana_set = [hiragana_set, w_hiragana];
    english_set = [english_set, w_english];
end

if size(strfind(string,'g'),2) > 0 || strcmp(string, 'ALL')
    g_hiragana = {ha(49), ha(50), ha(51), ha(52), ha(53)};
    g_english = {'ga', 'gi', 'gu', 'ge', 'go'};
    
    hiragana_set = [hiragana_set, g_hiragana];
    english_set = [english_set, g_english];
end

if size(strfind(string,'z'),2) > 0 || strcmp(string, 'ALL')
    z_hiragana = {ha(54), ha(55), ha(56), ha(57), ha(58)};
    z_english = {'za', 'ji', 'zu', 'ze', 'zo'};
    
    hiragana_set = [hiragana_set, z_hiragana];
    english_set = [english_set, z_english];
end

if size(strfind(string,'d'),2) > 0 || strcmp(string, 'ALL')
    d_hiragana = {ha(59), ha(60), ha(61), ha(62), ha(63)};
    d_english = {'da', 'ji', 'zu', 'de', 'do'};
    
    hiragana_set = [hiragana_set, d_hiragana];
    english_set = [english_set, d_english];
end

if size(strfind(string,'b'),2) > 0 || strcmp(string, 'ALL')
    b_hiragana = {ha(64), ha(65), ha(66), ha(67), ha(68)};
    b_english = {'ba', 'bi', 'bu', 'be', 'bo'};
    
    hiragana_set = [hiragana_set, b_hiragana];
    english_set = [english_set, b_english];
end

if size(strfind(string,'p'),2) > 0 || strcmp(string, 'ALL')
    p_hiragana = {ha(69), ha(70), ha(71), ha(72), ha(73)};
    p_english = {'pa', 'pi', 'pu', 'pe', 'po'};
    
    hiragana_set = [hiragana_set, p_hiragana];
    english_set = [english_set, p_english];
end

if size(strfind(string,'v'),2) > 0 || strcmp(string, 'ALL')
    v_hiragana = {ha(74)};
    v_english = {'v'}';

    hiragana_set = [hiragana_set, v_hiragana];
    english_set = [english_set, v_english];
end

end

