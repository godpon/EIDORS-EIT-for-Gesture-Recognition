%% Import data from spreadsheet
% Script for importing data from the following spreadsheet:
%
%    Workbook: C:\Users\godpo\Documents\MATLAB\Machine Learning\Gesture Classification\Gesture_dataset.xlsx
%    Worksheet: Fist, Left, Right, Up, Down
%
% Auto-generated by MATLAB on 27-May-2020 10:05:50

%% Setup the Import Options and import the data
file_loc = "C:\Users\godpo\Documents\MATLAB\Machine Learning\Gesture Classification\Gesture_dataset.xlsx";

opts = spreadsheetImportOptions("NumVariables", 65);
opts_array = {opts opts opts opts opts};

% Specify sheet and range
opts_array{1}.Sheet = "Fist";
opts_array{2}.Sheet = "Left";
opts_array{3}.Sheet = "Right";
opts_array{4}.Sheet = "Up";
opts_array{5}.Sheet = "Down";

for i = 1:5
    opts_array{i}.DataRange = "A4:BM435";
    % Specify column names and types
    opts_array{i}.VariableNames = ["VarName1", "VarName2", "VarName3", "VarName4",...
        "VarName5", "VarName6", "VarName7", "VarName8", "VarName9", "VarName10",...
        "VarName11", "VarName12", "VarName13", "VarName14", "VarName15", "VarName16",...
        "VarName17", "VarName18", "VarName19", "VarName20", "VarName21", "VarName22",...
        "VarName23", "VarName24", "VarName25", "VarName26", "VarName27", "VarName28",...
        "VarName29", "VarName30", "VarName31", "VarName32", "VarName33", "VarName34",...
        "VarName35", "VarName36", "VarName37", "VarName38", "VarName39", "VarName40",...
        "VarName41", "VarName42", "VarName43", "VarName44", "VarName45", "VarName46",...
        "VarName47", "VarName48", "VarName49", "VarName50", "VarName51", "VarName52",...
        "VarName53", "VarName54", "VarName55", "VarName56", "VarName57", "VarName58",...
        "VarName59", "VarName60", "VarName61", "VarName62", "VarName63", "VarName64", "VarName65"];
    opts_array{i}.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];
end

% Import the data
Fist = readtable(file_loc, opts_array{1}, "UseExcel", false);
Left = readtable(file_loc, opts_array{2}, "UseExcel", false);
Right = readtable(file_loc, opts_array{3}, "UseExcel", false);
Up = readtable(file_loc, opts_array{4}, "UseExcel", false);
Down = readtable(file_loc, opts_array{5}, "UseExcel", false);


%% Clear Temporary Variables:
vars = {'opts','file_loc','i','opts_array'};
clear(vars{:});
clear vars;
