var express = require('express');
var app = express();

var https = require('https');
var http = require('http');

var customResponseString = process.env.CUSTOM_RESPONSE_STRING ? process.env.CUSTOM_RESPONSE_STRING : "default response";

var port = process.env.SERVER_PORT ? process.env.SERVER_PORT : 3000;

var redirectTargetURL = process.env.REDIRECT_TARGET_URL ? process.env.REDIRECT_TARGET_URL : "https://www.google.com/";

// process.env.HTTPMODE = 'http' or 'https'
var httpMode = process.env.HTTP_MODE ? process.env.HTTP_MODE : "http";
if(httpMode != "http" && httpMode != "https") {
    console.log("Unsupported HTTP_MODE. Only support http or https");
    process.exit(1);
}

var express = require('express');

var fs = require('fs');

// This line is from the Node.js HTTPS documentation.
var options = {
    key: fs.readFileSync('certs/server-key.pem'),
    cert: fs.readFileSync('certs/server.cert')
};

// Create a service (the app object is just a callback).
var app = express();

app.get('/', function (req, res) {

    var headers = JSON.stringify(req.headers);
    console.log(headers);

    var remoteAddress = req.connection.remoteAddress;
    console.log(remoteAddress);

    var remotePort = req.connection.remotePort;
    console.log(remotePort);

    var x_forwarded_for = req.headers['x-forwarded-for']
    console.log(remoteAddress);

    var response = "headers: "+ headers + "; remoteAddress: " + remoteAddress + "; remotePort: " + remotePort +
        "; x_forwarded_for:" + x_forwarded_for + "; customResponseString:" + customResponseString;

    res.send(response);
})

app.get('/redirect', function (req, res) {

    console.log("redirectTargetURL: " + redirectTargetURL);

    var headers = JSON.stringify(req.headers);
    console.log(headers);

    var remoteAddress = req.connection.remoteAddress;
    console.log(remoteAddress);

    var remotePort = req.connection.remotePort;
    console.log(remotePort);

    var x_forwarded_for = req.headers['x-forwarded-for']
    console.log(remoteAddress);

    var requestInfo = "headers: "+ headers + "; remoteAddress: " + remoteAddress + "; remotePort: " + remotePort +
        "; x_forwarded_for:" + x_forwarded_for + "; customResponseString:" + customResponseString;

    console.log(requestInfo);

    res.redirect(301, redirectTargetURL);

})

// Create an HTTP service.
if(httpMode === "http") {

    console.log('Mini server (http) starts at port: ' + port);

    http.createServer(app).listen(port);
}

// Create an HTTPS service identical to the HTTP service.
if(httpMode === "https") {
    console.log('Mini server (https) starts at port: ' + port);
    https.createServer(options, app).listen(port);
}
