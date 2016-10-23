// This is a nodeunit test example 
var testerInitializer = require('nodeunit-express/tester');
var app = require('../server');
 
var globalOptions = {
    prepare: function (res) {
        if (res.body != null) {
            res.body = JSON.parse(res.body);
        }
 
        return res;
    }
};
 
var tester = testerInitializer(globalOptions);
 
module.exports['test test'] = tester(app, {
    method: 'GET',
    uri: '/user/123/',
 
    expect: {
        // any response property what you need check 
 
        // statusCode 
        statusCode: 400
 
        // expect body as object. By default all specified expected properties compare deeply by test.deepEqual 
        body: {
            error: {
                name: "ValidationError",
                rule: "required"
            }
        }
 
        // expect body as function if you need check not all property 
        body: function (body, response, options, args) {
            // args: tester returns a function. args is called function arguments. for example for nodeunit first argument is "test" 
            // response: response object 
            // options: compiled options 
            var test = args[0];
 
            test.strictEqual(body.error.name, 'ValidationError');
        }
    }
});