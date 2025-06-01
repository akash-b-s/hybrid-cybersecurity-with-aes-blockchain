function Hash = DataHash(Data, Opt)
% DataHash: Computes a hash for numerical arrays, strings, structs, or cells.
% Uses SHA-256 by default.

if nargin < 2
    Opt.Method = 'SHA-256';  % Default method
end

if ischar(Data)
    Data = uint8(Data);  % Convert string to uint8
elseif isnumeric(Data)
    Data = typecast(Data(:), 'uint8');  % Convert numbers to uint8
elseif isstruct(Data) || iscell(Data)
    Data = getByteStreamFromArray(Data); % Serialize structs/cells
else
    error('Unsupported data type for hashing.');
end

% Use Java's MessageDigest for SHA-256 Hashing
md = java.security.MessageDigest.getInstance(Opt.Method);
md.update(Data);
Hash = sprintf('%02x', typecast(md.digest(), 'uint8'));
end
