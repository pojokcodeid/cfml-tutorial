component accessors="true" {

    property name="clientId";
    property name="clientSecret";
    property name="redirectUri";
    globalConfig = expandPath('/configs/global.json');
    variables.config = deserializeJSON(fileRead(globalConfig));

    function init() {
        variables.clientId = variables.config.oauth2.google.clientId;
        variables.clientSecret = variables.config.oauth2.google.clientSecret;
        variables.redirectUri = variables.config.oauth2.google.redirectUri;
        return this;
    }

    function getAuthUrl() {
        var oGoogle = new modules.oauth2providers.google(
                client_id = variables.clientId,
                client_secret = variables.clientSecret,
                redirect_uri = variables.redirectUri
            );
        var strState = createUUID();
        var aScope = variables.config.oauth2.google.scope;
        var strURL = oGoogle.buildRedirectToAuthURL(
            scope = aScope,
            state = strState
        );
        return strURL;
    }

    function getUserInfo(code) {
        oOauth2 = new modules.oauth2providers.google(
            client_id = variables.clientId,
            client_secret = variables.clientSecret,
            redirect_uri = variables.redirectUri
        );
        var sData = oOauth2.makeAccessTokenRequest( code = url.code );
        return sData;
    }
}