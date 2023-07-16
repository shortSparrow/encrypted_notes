class WebAuthnError {
  constructor(message, reason) {
    this.message = message;
    this.reason = reason;
  }
}

const ERROR_REASONS = {
  BIO_NOT_SUPPORTED: "BIO_NOT_SUPPORTED",
  FAILED_CREATE_WEBAUTH: "FAILED_CREATE_WEBAUTH",
  FAILED_LOGIN: "FAILED_LOGIN",
};

const isAvailable = () => {
  return !!window.PublicKeyCredential;
};

const isLocalAuthenticator = () => {
  return PublicKeyCredential.isUserVerifyingPlatformAuthenticatorAvailable();
};

const register = async (randomStringFromServer, userIdArray, userName) => {
  if (
    navigator.credentials &&
    typeof navigator.credentials.create === "function"
  ) {
    try {
      const publicKeyCredentialOptions = {
        challenge: Uint8Array.from(randomStringFromServer, (c) =>
          c.charCodeAt(0)
        ),
        rp: { name: "Your Web App", id: "localhost" },
        user: {
          id: Uint8Array.from(userIdArray),
          name: userName,
          displayName: userName,
        },
        pubKeyCredParams: [{ type: "public-key", alg: -7 }],
        timeout: 60000,
        authenticatorSelection: {
          authenticatorAttachment: "platform",
        },
      };

      const result = await navigator.credentials.create({
        publicKey: publicKeyCredentialOptions,
      });

      const arr = new Uint8Array(result["rawId"]);
      let savedArr = [];
      arr.forEach((num) => savedArr.push(num));

      return savedArr;
    } catch (e) {
      throw JSON.stringify(
        new WebAuthnError(
          "Something went wrong during webauth .create request",
          ERROR_REASONS.FAILED_CREATE_WEBAUTH
        )
      );
    }
  } else {
    // Biometric authentication not supported
    throw JSON.stringify(
      new WebAuthnError(
        "Biometric authentication not supported",
        ERROR_REASONS.BIO_NOT_SUPPORTED
      )
    );
  }
};

const login = (randomStringFromServer, rawIdArray) => {
  try {
    const convertedArr = new Uint8Array(rawIdArray);
    const rawId = convertedArr.buffer;

    let publicKeyCredentialRequestOptions = {
      challenge: Uint8Array.from(randomStringFromServer, (c) =>
        c.charCodeAt(0)
      ),
      rpId: "localhost",
      authenticatorAttachment: "platform",
      allowCredentials: [
        {
          id: rawId,
          type: "public-key",
          transports: ["internal"],
        },
      ],
      timeout: 60000,
    };

    return navigator.credentials.get({
      publicKey: publicKeyCredentialRequestOptions,
    });
  } catch (e) {
    throw JSON.stringify(
      new WebAuthnError("failed login", ERROR_REASONS.FAILED_LOGIN)
    );
  }
};

window.webauth = {
  register,
  login,
  isAvailable,
  isLocalAuthenticator,
};
