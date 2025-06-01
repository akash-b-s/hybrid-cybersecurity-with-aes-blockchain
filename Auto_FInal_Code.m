function encrypt_and_store()
    clc;
    clear;

    %% Load XGBoost Model for Threat Analysis
    model = load('xgboost_model.mat');  % 🔹 Load pre-trained XGBoost model
    model = model.model;  % Extract model from struct

    disp('=== Dynamic AES Encryption Simulation ===');
    plaintext = input('Enter the text message: ', 's');

    % Count number of words in plaintext
    numWords = numel(strsplit(strtrim(plaintext)));

    % Determine AES Encryption Strength
    if numWords <= 2  
        encryptionStrength = 128;
    elseif numWords < 20
        encryptionStrength = 192;
    else
        encryptionStrength = 256;
    end
    fprintf('AES Encryption Strength: %d-bit\n', encryptionStrength);

    %% Blockchain Key Management
    disp('=== Blockchain Key Management ===');
    
    % Generate a unique private key per file
    privateKey = randi([500, 1500]); 
    publicKey = privateKey * 2; 

    % Generate 5 random node keys (Simulating decentralized security)
    nodes = 5;
    nodeKeys = randi([900, 1000], 1, nodes);

    fprintf('Private Key: %d\n', privateKey);
    fprintf('Public Key: %d\n', publicKey);
    fprintf('Node Keys: %s\n', num2str(nodeKeys));

    %% XGBoost Threat Analysis
    disp('=== Running XGBoost Threat Analysis ===');
    
    % Feature Vector for Threat Analysis
    features = [numWords, encryptionStrength, privateKey, mean(nodeKeys)];
    
    % Predict threat level (0: Safe, 1: Suspicious)
    threatLevel = predict(model, features);

    if threatLevel == 1
        disp('⚠️ Potential Threat Detected! Encryption Aborted.');
        return;
    end
    disp('✅ No Threat Detected. Proceeding with Encryption.');

    %% AES Encryption Process with Blockchain Hashing
    disp('=== Encrypting Text & Creating Blockchain Transaction ===');

    % Encrypt text using simple XOR-based AES simulation
    encryptedText = char(bitxor(uint8(plaintext), mod(privateKey, 256)));
    encryptedTextBase64 = matlab.net.base64encode(encryptedText);

    % Blockchain Transaction (SHA-256 Hash)
    blockchainHash = DataHash(plaintext, struct('Method', 'SHA-256'));

    disp(['📜 Blockchain Hash: ', blockchainHash]);

    %% Store Encrypted Data & Private Key in Google Drive
    disp('=== Storing Encrypted File & Blockchain Data ===');

    logDir = 'G:\My Drive\Encryption';
    keyDir = 'G:\My Drive\Private keys';

    if ~exist(logDir, 'dir')
        mkdir(logDir);
    end
    if ~exist(keyDir, 'dir')
        mkdir(keyDir);
    end

    % Generate log filename
    timestamp = datestr(now, 'yyyy-mm-dd_HH-MM-SS');
    logFile = fullfile(logDir, sprintf('encrypted_log_%s.txt', timestamp));
    keyFile = fullfile(keyDir, sprintf('encrypted_log_%s.txt', timestamp));

    % Save encrypted text
    fileID = fopen(logFile, 'w');
    fprintf(fileID, '%s', encryptedTextBase64);
    fclose(fileID);

    % Save private key and blockchain hash
    fileID = fopen(keyFile, 'w');
    fprintf(fileID, 'Private Key: %d\nBlockchain Hash: %s', privateKey, blockchainHash);
    fclose(fileID);

    disp(['✅ Encrypted log stored at: ', logFile]);
    disp(['✅ Private Key saved at: ', keyFile]);

end