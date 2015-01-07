function ElmNativeModule(name, values) {
    Elm.Native[name] = {};
    Elm.Native[name].make = function(elm) {
        elm.Native = elm.Native || {};
        elm.Native[name] = elm.Native[name] || {};
        if (elm.Native[name].values) return elm.Native[name].values;
        return elm.Native[name].values = values;
    };
}

ElmNativeModule('Encode', {
    base64Encode: function (x) {
        // Needs wrapping to avoid "Illegal invocation" errors
        return btoa(x);
    },
    base64Decode: function (x) {
        return atob(x);
    }
});
