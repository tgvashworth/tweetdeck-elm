/**
 * Super hacky proxy server for talking to the TweetDeck API
 *
 * $ node proxy.js 1234
 */

var https = require('https');
var http = require('http');
var url = require('url');
var TD = {
    host: 'tweetdeck.twitter.com',
    port: 443
};

http.createServer(function (req, res) {
    var data = {
        method: req.method,
        host: TD.host,
        port: TD.port,
        path: req.url,
        headers: req.headers
    };
    delete data.headers.host;

    console.log('== req ========================');
    console.log(data);

    var headers = {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Headers': data.headers['access-control-request-headers']
    };
    if (data.method === 'OPTIONS') {
        res.writeHead(200, headers);
        return res.end();
    }

    https.request(data, function(twres) {
        Object.keys(twres.headers).forEach(function (k) {
            headers[k] = twres.headers[k];
        });
        res.writeHead(twres.statusCode, headers);
        twres.pipe(res);
    }).end();
}).listen(process.argv[2], function () {
    console.log('Proxy up at //%s:%s', this.address().address, this.address().port);
});
