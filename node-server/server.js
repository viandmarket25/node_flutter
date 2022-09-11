let baseUrl='m'
let formidable = require('formidable');
let fs = require ("fs");
const cors = require('cors');
const formData = formidable({ multiples: true });
let http = require('http'); // Import Node.js core module
let routeFunctions={
    routes:{
        "GET":[
            // ::::::::::: get products
            {
                "url":"/products",
                "method":async (serviceParams) => {
                     console.log('get product:',serviceParams.request)
                     let resultData
                         return new Promise(async(resolve) => {
                             resultData = await  routeFunctions.readJsonFile("json-db.json").catch((error)=>{
                               // :::::::::::::::::::::::::::::
                             }).then((resultData) =>{
                                resultData=resultData['products']
                                let update=[]
                                for(let i=0; i<resultData.length; i++){
                                    let p={
                                        "title":resultData[i].title,
                                        "picture":resultData[i].images['large'],
                                        "description":resultData[i].description[0],
                                        "publisher":resultData[i].publisher,
                                    }
                                    update.push(p)
                                }
                                resultData=update
                                console.log("response timeout over, send result");
                                resultData = JSON.stringify(resultData)
                                console.log("result data:",resultData,"length: ",resultData.length)
                                serviceParams.result.write(resultData);
                                serviceParams.result.end();
                                resolve(resultData);
                             }).catch((error)=>{
                             })
                         });
                }
             },
             {
                "url":"/",
                "method":async (serviceParams) => {
                // :::::::::::::; test api
                    let resultData
                     return new Promise(async(resolve) => {
                        serviceParams.result.write("test hello world!");
                        serviceParams.result.end()
                        console.log("test hello world!")
                        resolve("test hello world!");

                     })
                }
            },
        ],
        "POST":[

        ],
        "PUT":[

        ],
        "DELETE":[

        ],
    },
    readJsonFile:(file)=>{
       return new Promise(async(resolve) => {
            fs.readFile( __dirname + "/" +file, 'utf8', function (err, data) {
              data = JSON.parse( data );
              resolve( data )
            })
       });
    },

}
let requestHandler={
    // :::::::::::::::: iterate all routes related to a request method
    // :::::::::::::::: and then call related function
    handle:(serviceParams,requestMethod)=>{
    // :::::::::::::: example if request method == GET
        let validRoute=false;
        for(let i=0; i<routeFunctions.routes[requestMethod].length; i++){
          if(serviceParams.request.url===routeFunctions.routes[requestMethod][i]['url'] ){
            validRoute=true
            routeFunctions.routes[requestMethod][i]['method'](serviceParams);
          }
        }
        validRoute==false?routeFunctions.routes["NOT_FOUND"](serviceParams):false;
    }
}
try {
    let server = http.createServer(async(request, result) => {
        // :::::::: create web server
        result.setHeader('Access-Control-Allow-Origin', '*');
        result.setHeader('Access-Control-Allow-Methods', 'OPTIONS, GET, POST, DELETE, PUT');
        result.setHeader('Access-Control-Max-Age', 259208800); // 30 days
        result.setHeader('Pragma', 'no-cache');
        result.setHeader('Access-Control-Allow-Headers', "Access-Control-Allow-Headers, Origin,Accept, X-Requested-With, Content-Type,Authorization, Access-Control-Request-Method, Access-Control-Request-Headers, Pragma");
        // ::::::::: handle post requests
        let serviceParams={"request":request,"result":result}
        if(request.method === "POST"){
           requestHandler.handle(serviceParams,"POST")
        }
        // ::::::::: handle get requests
        if(request.method === "GET"){
           requestHandler.handle(serviceParams,"GET")
        }
        // :::::::::: handle put requests
        if(request.method === "PUT"){
           requestHandler.handle(serviceParams,"PUT")
        }
        if(request.method === "DELETE"){
           requestHandler.handle(serviceParams,"DELETE")
        }
        //result.end(request.url);

    });
    server.listen(3000); //6 - listen for any incoming requests
    console.log('Node.js web server at port 3000 is running..')
} catch (error) {
    console.log("error: ", error)
}
