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
function run_data(method, data) {
    client.registerMethod("method", local + method.method, method.action);
    client.methods.method({data: data,
			   headers:
			   {"Content-Type": "application/json"}},
			  function(data, response) {
			      console.log(data);
			  });
}    

jsonfile.readFile(argv["_"][0], function(err, method) {
    if (err != null) {
	console.log(err);
    } else {
	if (argv["_"][1] != undefined) {
	    jsonfile.readFile(argv['_'][1], function(err, data) {
		if (err != null) {
		    console.log(err);
		} else {
		    run_data(method, data);
		}
	    });
	} else {
	    run_data(method, {});
	}
    }
});
