local CCCrypto, type, string = CCCrypto, type, string

module(...)

function EncryptAES256(plaintext, key)
	return CCCrypto:encryptAES256Lua(plaintext, string.len(plaintext), key, string.len(key))
end

function DecryptAES256(ciphertext, key)
	return CCCrypto:decryptAES256Lua(ciphertext, string.len(ciphertext), key, string.len(key))
end

function EncodeBase64(plaintext)
	return CCCrypto:encodeBase64Lua(plaintext, string.len(plaintext))
end

function DecodeBase64(ciphertext)
	return CCCrypto:decodeBase64Lua(ciphertext)
end

function Md5(input, isRawOutput)
	if type(isRawOutput) ~= "boolean" then isRawOutput = false end
	return CCCrypto:MD5Lua(input, string.len(input), isRawOutput)
end