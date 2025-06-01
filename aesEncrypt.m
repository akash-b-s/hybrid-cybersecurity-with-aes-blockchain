 
function ciphertext = aesEncrypt(plaintext, keySize)
    % Simulate AES encryption by appending key size to the plaintext
    ciphertext = ['Encrypted(', plaintext, ') with ', num2str(keySize), '-bit key'];
end
