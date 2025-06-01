% Train and Save XGBoost Model
clc;
clear;

% Sample Training Data (Modify with real threat data)
% Features: [Word Count, Encryption Strength, Private Key, Avg Node Key]
X = [2 128 600 950;  % Normal
     10 192 800 970;  % Normal
     30 256 1300 980;  % Normal
     5 128 1200 965;  % Suspicious
     50 256 1400 990]; % Suspicious

% Labels (0 = Safe, 1 = Suspicious)
Y = [0; 0; 0; 1; 1];

% Train XGBoost Model
model = fitcensemble(X, Y, 'Method', 'Bag', 'NumLearningCycles', 50);

% Save Model
save('xgboost_model.mat', 'model');

disp('✅ XGBoost Model Trained & Saved as xgboost_model.mat');
