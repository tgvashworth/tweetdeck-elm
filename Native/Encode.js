ElmNativeModule('Encode', {
    base64Encode: function (x) {
        // Needs wrapping to avoid "Illegal invocation" errors
        return btoa(x);
    },
    base64Decode: function (x) {
        return atob(x);
    }
});
