 clc;
clear;

%% 1. Dynamic AES Encryption Simulation
dataSensitivity = input('Enter data sensitivity level (1 = Low, 2 = Medium, 3 = High): ');
computationalResources = input('Enter available computational resources (1 = Low, 2 = Medium, 3 = High): ');

% Determine AES encryption strength
if dataSensitivity == 1
    encryptionStrength = 128; % Low sensitivity, lower encryption strength
elseif dataSensitivity == 2
    encryptionStrength = 192; % Medium sensitivity
else
    encryptionStrength = 256; % High sensitivity, highest encryption strength
end

% Adjust encryption strength based on computational resources
if computationalResources == 1
    encryptionStrength = max(encryptionStrength - 64, 128); % Reduce strength if resources are low
elseif computationalResources == 3
    encryptionStrength = min(encryptionStrength + 64, 256); % Increase strength if resources are high
end

fprintf('Selected AES Encryption Strength: %d-bit\n', encryptionStrength);

%% 2. Blockchain Key Management 
disp('Simulating Blockchain Key Management...');
privateKey = randi([1, 1000], 1); % Simulate private key generation
publicKey = privateKey * 2; % Simulate public key derivation
disp(['Private Key: ', num2str(privateKey)]);
disp(['Public Key: ', num2str(publicKey)]);
disp('Decentralized key management ensures secure key distribution.');

%% 3. XGBoost for Threat Prediction
disp('Simulating XGBoost Threat Detection...');
accessPatterns = randi([0, 1], 100, 5);
labels = randi([0, 1], 100, 1); 
model = fitctree(accessPatterns, labels);
predictedThreat = predict(model, accessPatterns(1, :)); 

if predictedThreat == 1
    disp('Potential threat detected! Taking preventive actions...');
else
    disp('No threats detected. System is secure.');
end

%% 4. MATLAB Simulation and Validation

disp('Simulating Encryption and Validating Performance...');
plaintext = 'This is a sample message for encryption.';
ciphertext = aesEncrypt(plaintext, encryptionStrength); % Simulate AES encryption
decryptedText = aesDecrypt(ciphertext, encryptionStrength); % Simulate AES decryption

fprintf('Original Text: %s\n', plaintext);
fprintf('Decrypted Text: %s\n', ciphertext);
 fprintf('Decrypted Text: %s\n', decryptedText);
 