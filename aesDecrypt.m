
function plaintext = aesDecrypt(ciphertext, keySize)
    % Simulate AES decryption by extracting the original plaintext
    prefix = ['Encrypted(', '', ') with ', num2str(keySize), '-bit key'];
    plaintext = strrep(ciphertext, prefix, '');
end