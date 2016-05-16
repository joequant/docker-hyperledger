#!/usr/bin/node
global.rootRequire = function(name) {
    return require(__dirname + '/' + name);
}

var logger = {log: console.log, error: console.error, debug: console.log, warn: console.log};
var Ibc1 = rootRequire('hyperledger-fabric-js');
	var ibc = new Ibc1(/*logger*/);             //you can pass a logger such as winston here - optional
	var chaincode = {};

	// ==================================
	// configure ibc-js sdk
	// ==================================
	var options = 	{
		network:{
			peers:   [{
				"api_host": "172.17.0.2",
				"api_port": "5000",
			    "id": "vp1",

			}],
		    options: {							//this is optional
			tls: false,
			timeout: 6000000,
			quiet: false
			}
		},
		chaincode:{
			zip_url: 'https://github.com/joequant/marbles-chaincode/archive/master.zip',
			unzip_dir: 'marbles-chaincode-master/part2',
			git_url: 'https://github.com/joequant/marbles-chaincode/part2'
		}
	};
	
	// Step 2 ==================================
	ibc.load(options, cb_ready);

	// Step 3 ==================================
	function cb_ready(err, cc){								//response has chaincode functions
	    chaincode = cc;
	    logger.log('deployed_name ', cc);
	// Step 4 ==================================
	    if(!cc.details.deployed_name || cc.details.deployed_name === ""){				//decide if I need to deploy or not
		cc.deploy('init', ['99'], null, null, cb_deployed);
		}
		else{
			logger.log('chaincode summary file indicates chaincode has been previously deployed');
			cb_deployed();
		}
	}

	// Step 5 ==================================
function cb_deployed(err){
    logger.log(err);
		console.log('sdk has deployed code and waited');
		chaincode.query.read(['a']);
	}
