#!/bin/node
var fs = require('fs')
var async = require('async')
var minimist = require('minimist')
var argv = require('minimist')(process.argv.slice(2))
var Client = require('node-rest-client').Client;
var client = new Client();
var local = "http://localhost:5000";

var method = {
    "action" : "GET",
    "method" : "/chain"
};

var args = {
};
console.dir(argv);

client.registerMethod("method", local + method.method, method.action);
client.methods.method(args, function(data, response) {
    console.log(data);
});
