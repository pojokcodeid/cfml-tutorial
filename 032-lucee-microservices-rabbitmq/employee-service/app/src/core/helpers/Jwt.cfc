component {

    variables.jwt = new modules.jwtcfml.models.jwt();

    function init() {
        var myEnv= createObject("core.helpers.EnvLoader");
        variables.acessKey = myEnv.getEnv("ACCESS_TOKEN");
        variables.refreshKey = myEnv.getEnv("REFRESH_TOKEN");
        variables.expiedMinute = myEnv.getEnv("EXPIRED_ACCESS_MINUTE");
        variables.refreshExpiredMinute = myEnv.getEnv("EXPIRED_REFRESH_MINUTE");
        return this;
    }

    public function encode(content = {}) {
        var expdt = dateAdd('n', expiedMinute, now());
        var expdtRefresh = dateAdd('n', refreshExpiredMinute, now());
        var utcDate = dateDiff('s', dateConvert('utc2Local', createDateTime(1970, 1, 1, 0, 0, 0)), expdt);
        var utcDateRefresh = dateDiff('s', dateConvert('utc2Local', createDateTime(1970, 1, 1, 0, 0, 0)), expdtRefresh);
        var payload = {'content': content, 'iat': now(), 'exp': utcDate}
        var payloadRefresh = {'content': content, 'iat': now(), 'exp': utcDateRefresh}
        return {
            accessToken: jwt.encode(payload, acessKey, 'HS256'),
            refreshToken: jwt.encode(payloadRefresh, refreshKey, 'HS256')
        }
    }

    public function decodeAccess(token) {
        try {
            return {data: jwt.decode(token, acessKey, 'HS256'), message: 'success'};
        } catch (any e) {
            return {data: false, message: e.message}
        }
    }

    public function decodeRefresh(token) {
        try {
            return {data: jwt.decode(token, refreshKey, 'HS256'), message: 'success'};
        } catch (any e) {
            return {data: false, message: e.message}
        }
    }

}

// cara acess
// var jwt = new core.helpers.Jwt();
// var token = jwt.encode({username: content.username});
// registeredUser.accessToken = token.accessToken;
// registeredUser.refreshToken = token.refreshToken;
