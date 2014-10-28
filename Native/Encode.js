Elm.Native.Encode = {};
Elm.Native.Encode.make = function(elm) {

    elm.Native = elm.Native || {};
    elm.Native.Encode = elm.Native.Encode || {};
    if (elm.Native.Encode.values) return elm.Native.Encode.values;

    return elm.Native.Encode.values = {
        base64Encode: function (x) {
            // Needs wrapping to avoid "Illegal invocation" errors
            return btoa(x);
        }
    };
};
