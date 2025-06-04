component {

    public function init() {
        return this;
    }

    public function authenticateAcess() {
        var accessToken = cookie.accessToken ?: '';
        if (not isEmpty(accessToken)) {
            try {
                var jwt = new core.helpers.Jwt();
                return jwt.decodeAccess(accessToken);
            } catch (any e) {
                return {message: 'Anauthorized', data: false};
            }
        } else {
            return {message: 'Anauthorized', data: false};
        }
    }

    public function authenticateRefresh() {
        var refreshToken = cookie.refreshToken ?: '';
        if (not isEmpty(refreshToken)) {
            try {
                var jwt = new core.helpers.Jwt();
                var auth = jwt.decodeRefresh(refreshToken);
                var newToken = jwt.encode(auth.DATA.content);
                return {message: 'success', token: newToken, data: auth.DATA.content}
            } catch (any e) {
                return {message: 'Anauthorized', token: '', data: false};
            }
        } else {
            return {message: 'Anauthorized', token: '', data: false};
        }
    }

}