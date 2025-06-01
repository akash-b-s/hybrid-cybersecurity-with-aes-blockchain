function decrypt_and_validate()
    clc;
    clear;

    %% Email Configuration
    emailSender = 'akash190504@gmail.com';  
    emailPassword = getenv('EMAIL_PASSWORD');  
    emailRecipient = 'akash190504@gmail.com';  

    setpref('Internet', 'SMTP_Server', 'smtp.gmail.com');
    setpref('Internet', 'E_mail', emailSender);
    setpref('Internet', 'SMTP_Username', emailSender);
    setpref('Internet', 'SMTP_Password', emailPassword);
    props = java.lang.System.getProperties;
    props.setProperty('mail.smtp.auth', 'true');
    props.setProperty('mail.smtp.port', '587');
    props.setProperty('mail.smtp.starttls.enable', 'true');

    %% Select Encrypted File
    logDir = 'G:\My Drive\Encryption';
    keyDir = 'G:\My Drive\Private keys';

    [filename, pathname] = uigetfile(fullfile(logDir, '*.txt'), 'Select Encrypted File');
    if isequal(filename, 0)
        disp('❌ No file selected. Exiting...');
        return;
    end
    logFile = fullfile(pathname, filename);
    keyFile = fullfile(keyDir, filename);  

    %% Validate Private Key
    if ~exist(keyFile, 'file')
        disp(['❌ Private key file not found at: ', keyFile]);
        return;
    end

    prompt = {'Enter Private Key to decrypt:'};
    dlgtitle = 'Private Key Required';
    dims = [1 50];
    userKey = inputdlg(prompt, dlgtitle, dims);

    if isempty(userKey)
        disp('❌ No key entered. Exiting...');
        return;
    end
    userKey = str2double(userKey{1});

    % ✅ Read and extract only the private key
    fileContent = fileread(keyFile);
    storedKey = sscanf(fileContent, 'Private Key: %d');

    % Debug output
    fprintf('🔍 Entered Key: %d\n', userKey);
    fprintf('🔍 Stored Key: %d\n', storedKey);

    if userKey ~= storedKey
        disp('❌ Incorrect Private Key! Access Denied.');

        % 🔴 Send Unauthorized Access Alert Email
        subject = '⚠️ Unauthorized Access Attempt!';
        message = sprintf('Somebody tried to access "%s" with an incorrect private key!', filename);
        sendmail(emailRecipient, subject, message);
        
        disp('⚠️ Email Alert Sent: Unauthorized Access Attempt.');
        return;
    end

    %% Decrypt and Display File
    disp('✅ Private Key Matched! Decrypting file...');

    encryptedTextBase64 = fileread(logFile);
    encryptedText = matlab.net.base64decode(encryptedTextBase64);

    decryptedText = char(bitxor(uint8(encryptedText), mod(userKey, 256)));

    disp('=== Decrypted Content ===');
    disp(decryptedText);

    % ✅ Send Success Email Notification
    subject = '✅ File Decryption Successful';
    message = sprintf('The file "%s" was successfully decrypted.', filename);
    sendmail(emailRecipient, subject, message);

    disp('📩 Email Notification Sent: File Successfully Decrypted.');

    % Open the decrypted content in Notepad
    tempFile = fullfile(tempdir, 'decrypted_text.txt');
    fid = fopen(tempFile, 'w');
    fprintf(fid, '%s', decryptedText);
    fclose(fid);

    if exist(tempFile, 'file')
        winopen(tempFile);
    else
        disp('❌ Decrypted file not found!');
    end
end
