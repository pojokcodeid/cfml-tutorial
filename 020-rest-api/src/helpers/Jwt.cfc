 component output="false" {
	// jwt.cfc
	// DESCRIPTION: Component for encoding and decoding JSON Web Tokens.
	// Based on jwt-simple node.js library (https://github.com/hokaccha/node-jwt-simple)
	// PARAMETERS: key - HMAC key used for token signatures

	function init(required key, boolean ignoreExpiration=false, string issuer="", string audience="") {
		variables.key = key;
		variables.ignoreExpiration = ignoreExpiration;
		variables.issuer = issuer;
		variables.audience = audience;
		// Supported algorithms
		variables.algorithmMap = {
			"HS256": "HmacSHA256",
			"HS384": "HmacSHA384",
			"HS512": "HmacSHA512"
		};
		return this;
	}

	// decode(string) as struct
	// Description: Decode a JSON Web Token
	function decode(required token) {
		if (listLen(token, ".") != 3) {
			throw(type="Invalid Token", message="Token should contain 3 segments");
		}
		var header = deserializeJSON(base64UrlDecode(listGetAt(token, 1, ".")));
		var payload = deserializeJSON(base64UrlDecode(listGetAt(token, 2, ".")));
		var signiture = listGetAt(token, 3, ".");

		if (!listFindNoCase(structKeyList(algorithmMap), header.alg)) {
			throw(type="Invalid Token", message="Algorithm not supported");
		}

		if (StructKeyExists(payload, "exp") && !variables.ignoreExpiration && epochTimeToLocalDate(payload.exp) < now()) {
			throw(type="Invalid Token", message="Signature verification failed: Token expired");
		}
		if (StructKeyExists(payload, "nbf") && epochTimeToLocalDate(payload.nbf) > now()) {
			throw(type="Invalid Token", message="Signature verification failed: Token not yet active");
		}
		if (StructKeyExists(payload, "iss") && variables.issuer != "" && payload.iss != variables.issuer) {
			throw(type="Invalid Token", message="Signature verification failed: Issuer does not match");
		}
		if (StructKeyExists(payload, "aud") && variables.audience != "" && payload.aud != variables.audience) {
			throw(type="Invalid Token", message="Signature verification failed: Audience does not match");
		}

		var signInput = listGetAt(token, 1, ".") & "." & listGetAt(token, 2, ".");
		if (signiture != sign(signInput, algorithmMap[header.alg])) {
			throw(type="Invalid Token", message="Signature verification failed: Invalid key");
		}

		return payload;
	}

	// encode(struct,[string]) as String
	// Description: encode a data structure as a JSON Web Token
	function encode(required payload, string algorithm="HS256") {
		var hashAlgorithm = "HS256";
		var segments = "";

		if (listFindNoCase(structKeyList(algorithmMap), algorithm)) {
			hashAlgorithm = algorithm;
		}

		segments = listAppend(segments, base64UrlEscape(toBase64(serializeJSON({ "typ": "JWT", "alg": hashAlgorithm }))), ".");
		segments = listAppend(segments, base64UrlEscape(toBase64(serializeJSON(payload))), ".");
		segments = listAppend(segments, sign(segments, algorithmMap[hashAlgorithm]), ".");

		return segments;
	}

	// verify(token) as Boolean
	// Description: Verify the token signature
	function verify(required token) {
		var isValid = true;

		try {
			decode(token);
		} catch (any e) {
			isValid = false;
		}

		return isValid;
	}

	// sign(string,[string]) as String
	// Description: Create an MHAC of provided string using the secret key and algorithm
	private function sign(required string msg, string algorithm="HmacSHA256") {
		var key = createObject("java", "javax.crypto.spec.SecretKeySpec").init(variables.key.getBytes(), algorithm);
		var mac = createObject("java", "javax.crypto.Mac").getInstance(algorithm);
		mac.init(key);

		return base64UrlEscape(toBase64(mac.doFinal(msg.getBytes())));
	}

	// base64UrlEscape(String) as String
	// Description: Escapes unsafe url characters from a base64 string
	private function base64UrlEscape(required string str) {
		return reReplace(reReplace(reReplace(str, "\+", "-", "all"), "\/", "_", "all"), "=", "", "all");
	}

	// base64UrlUnescape(String) as String
	// Description: restore base64 characters from an url escaped string 
	private function base64UrlUnescape(required string str) {
		var base64String = reReplace(reReplace(str, "\-", "+", "all"), "\_", "/", "all");
		var padding = repeatstring("=", 4 - len(base64String) mod 4);

		return base64String & padding;
	}

	// base64UrlDecode(String) as String
	// Description: Decode a url encoded base64 string
	private function base64UrlDecode(required string str) {
		return toString(toBinary(base64UrlUnescape(str)));
	}

	// epochTimeToLocalDate(numeric) as Datetime
	// Description: Converts Epoch datetime to local date
	private function epochTimeToLocalDate(required numeric epoch) {
		return createObject("java", "java.util.Date").init(epoch * 1000);
	}
}
