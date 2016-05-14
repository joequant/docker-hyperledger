#!/bin/node

// fabric-rest.js method args

var fs = require('fs')
var async = require('async')
var jsonfile = require('jsonfile')
var argv = require('minimist')(process.argv.slice(2))
var Client = require('node-rest-client').Client;
var client = new Client();
var local = "http://localhost:5000";

var filename = argv["_"][0]

var args = {
};
function run_data(method, args) {
    client.registerMethod("method", local + method.method, method.action);
    client.methods.method(args, function(data, response) {
	console.log(data);
    });
}    

jsonfile.readFile(argv["_"][0], function(err, method) {
    if (err != null) {
	console.log(err);
    } else {
	if (argv["_"][1] != undefined) {
	    jsonfile.readFile(argv['_'][1], function(err, args) {
		if (err != null) {
		    console.log(err);
		} else {
		    console.log(args);
		    run_data(method, args);
		}
	    });
	} else {
	    run_data(method, {});
	}
    }
});
