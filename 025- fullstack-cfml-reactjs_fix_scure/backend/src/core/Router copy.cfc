component {

    function run() {
        // Ambil route dari query string
        var route = trim(url.page);
        var segments = listToArray(route, '/');

        var controllerName = arrayLen(segments) >= 1 ? segments[1] : 'home';
        var methodName = arrayLen(segments) >= 2 ? segments[2] : 'index';
        var params = arrayLen(segments) > 2 ? arraySlice(segments, 3, arrayLen(segments) - 2) : [];


        var controllerPath = '/controllers/#controllerName#.cfc';

        if (fileExists(expandPath(controllerPath))) {
            var controller = createObject('component', 'controllers.#controllerName#');

            if (structKeyExists(controller, methodName)) {
                return controller[methodName](argumentCollection = paramsToStruct(params));
            } else {
                return {success: false, message: 'Method `#methodName#` not found in controller `#controllerName#`.'};
            }
        } else {
            return {success: false, message: 'Controller `#controllerName#` not found.'}
        }
    }

    // Ubah array params menjadi struct dengan nama arg1, arg2, dst.
    private function paramsToStruct(array params) {
        var s = {};
        for (var i = 1; i <= arrayLen(params); i++) {
            s['arg' & i] = params[i];
        }
        return s;
    }

}
