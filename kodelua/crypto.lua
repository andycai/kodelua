local crypto
crypto = {}

function crypto.EncryptAES256(plaintext, key)
	return CCCrypto:encryptAES256Lua(plaintext, string.len(plaintext), key, string.len(key))
end

function crypto.DecryptAES256(ciphertext, key)
	return CCCrypto:decryptAES256Lua(ciphertext, string.len(ciphertext), key, string.len(key))
end

function crypto.EncodeBase64(plaintext)
	return CCCrypto:encodeBase64Lua(plaintext, string.len(plaintext))
end

function crypto.DecodeBase64(ciphertext)
	return CCCrypto:decodeBase64Lua(ciphertext)
end

function crypto.Md5(input, isRawOutput)
	if type(isRawOutput) ~= "boolean" then isRawOutput = false end
	return CCCrypto:MD5Lua(input, string.len(input), isRawOutput)
end