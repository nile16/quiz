const http   = require('http');
var   fs     = require('fs');
var   mysql  = require('mysql');
const para   = require('./mysqlPara.js');
const crypto = require('crypto');

const secret = 'abcdefg';


// Takes http request headers as argument and returns an object where each cookie is an attribute
function cookieParser(headers){

	if (headers['cookie'])
		var cookieArray = headers['cookie'].split(';');
	else
		return(0);

	var cookies={};

	for (i=0;i<cookieArray.length;i++){
		keyvalue = cookieArray[i].split('=');
		cookies[keyvalue[0].trim()]=keyvalue[1].trim();
	}

	return(cookies);

}

// Takes user ID and name as arguments and returns a token used for a session cookie
function tokenMaker(id,name){

	var tokenData   = {};

	tokenData.id    = id;
	tokenData.name  = name;

	tokenDataString = JSON.stringify(tokenData);

	return(tokenDataString+"."+crypto.createHmac('sha256', secret).update(tokenDataString).digest('hex'));

}

// Takes a token made by tokenMaker() as argument and returns user info as an object
function tokenCheck(token){

	if (!token)
		return(0);

	data=token.slice(0,token.indexOf('.'));
	hash=token.slice(token.indexOf('.')+1);

	if (hash==crypto.createHmac('sha256', secret).update(data).digest('hex'))
		return(JSON.parse(data));
	else
		return(0);
}

const server = http.createServer((req, res) => {

	//Inform the web browser that it is okay to connect from any host (allow CORS) Only used for testing.
	//res.setHeader('Access-Control-Allow-Origin',   '*');
	//res.setHeader('Access-Control-Request-Method', '*');
	//res.setHeader('Access-Control-Allow-Methods',  'POST, GET');
	//res.setHeader('Access-Control-Allow-Headers',  '*');

	if (req.url=="/"){
		fs.readFile("./index.html", function(error, content) {
			res.writeHead(200, { 'Content-Type': 'text/html' });
			res.end(content, 'utf-8');
		})
	}

	//Checks if the user is logged in by reading the token sent by the web browser.
	//The user's name is extracted from the token and sent back together with
	//results for the last quizes the user has taken. 
	//If the token is invalid or missing an empty string is sent
	if (req.url=="/check"){
		res.setHeader('Content-Type', 'text/plain');
		res.statusCode = 200;
		var name=tokenCheck(cookieParser(req.headers).quiz_token).name;
		if (!name)
			res.end("");
		else {
			var connection = mysql.createConnection(para.db);

			connection.connect();

			connection.query("SELECT stats FROM users WHERE name='"+name+"' ;", (error, rows, fields) => {
				if (rows[0])
					res.end(JSON.stringify({'name':name,'stats':JSON.parse(rows[0].stats)}));
				else
					res.end("");
			})
		}
	}

	//Log the user out by asking the web browser to overwrite our token with an expired and empty token
	if (req.url=="/logout"){
		res.setHeader('Content-Type', 'text/plain');
		res.setHeader('Set-Cookie', 'quiz_token=; httponly; expires=Thu, 01 Jan 1970 00:00:00 GMT;');
		res.statusCode = 200;
		res.end("ok");
	}

	//Creates a new user in the database
	//First the desired user name provided by the new user is checked against the database to see if 
	//it is taken, if not it is inserted in the database together with a hash of the desired password. 
	//A cookie with a token is created and sent to the browser in a header.
	if (req.url=="/signup"){

		var body = '';

		req.on('data', (data) => {
			body += data;
		});

		req.on('end', () => {

			var post=JSON.parse(body);

			var connection = mysql.createConnection(para.db);

			connection.connect();

			connection.query("SELECT * FROM users WHERE name='"+post.user+"' ;", (error, rows, fields) => {

				if (error) console.log(error);

				//Inform the web browser of the type of content to be sent
				res.setHeader('Content-Type', 'text/plain');


				if (!rows[0]){

					connection.query("INSERT INTO `users` ( name, password, stats )  VALUES ( '"+post.user+"',SHA('"+post.password+"little salt'),'[]' );SELECT LAST_INSERT_ID();", (error, rows, fields) => {

						//Ask web browser to save cookie with token
						res.setHeader('Set-Cookie', 'quiz_token='+tokenMaker(rows[1][0]['LAST_INSERT_ID()'],post.user)+'; httponly;');

						//Inform the web browser the status code is 200, no errors
						res.statusCode = 200;

						//Send response
						res.end("ok");
					})
				}
				else
				{
					//Inform the web browser the status code is 200, no errors
					res.statusCode = 200;

					//Send response
					res.end("username taken");

				}

				connection.end();

			})
		});
	}

	//Checks if login credentials match data in users table, if so create a token and send it back in a http header
	if (req.url=="/login"){

		var body = '';

		req.on('data', (data) => {
			body += data;
		});

		req.on('end', () => {

			var post=JSON.parse(body);

			var connection = mysql.createConnection(para.db);

			connection.connect();

			connection.query("SELECT * FROM users WHERE name='"+post.user+"' AND password=SHA('"+post.password+"little salt');", (error, rows, fields) => {

				if (error) console.log(error);

				//Inform the web browser of the type of content to be sent
				res.setHeader('Content-Type', 'text/plain');

				if (rows[0]){

					//Ask web browser to save cookie with token
					res.setHeader('Set-Cookie', 'quiz_token='+tokenMaker(rows[0].user_id,rows[0].name)+'; httponly;');

					//Inform the web browser the status code is 200, no errors
					res.statusCode = 200;

					//Send response
					res.end("ok");
				}
				else
				{
					//Inform the web browser the status code is 200, no errors
					res.statusCode = 200;

					//Send response
					res.end("error");
				}

				//Kill the MySQL connection
				connection.end();

			})
		});
	}

	//If the user is not logged in a list of the two first quizes are sent, if the user is logged in all are sent
	if (req.url=="/listquiz"){

		var connection = mysql.createConnection(para.db);

		connection.connect();

		//Check if the user is logged in
		if (tokenCheck(cookieParser(req.headers).quiz_token)==0)
			var query="SELECT * FROM quiz WHERE quiz_id in (1,2);";
		else
			var query="SELECT * FROM quiz;";
		
		connection.query(query, (error, rows, fields) => {

			if (error) console.log(error);

			//Inform the web browser of the type of content to be sent
			res.setHeader('Content-Type', 'application/json; charset=utf-8');

			var result=[];
			for (i=0;i<rows.length;i++){
				result[i]=rows[i];
				result[i].questions=JSON.parse(rows[i].questions).length;}

			//Inform the web browser the status code is 200, no errors
			res.statusCode = 200;

			//Send response
			res.end(JSON.stringify(result));

			//Kill the MySQL connection
			connection.end();

		})
	}

	//Grades answers to a quiz supplied by a user
	if (req.url=="/grade"){

		var body = '';

		req.on('data', function (data) {
			body += data;
		});

		req.on('end', function () {

			var post=JSON.parse(body);
			var query="";
			var grades=[];
			var x=0;
			var right_answers=0;
			
			Object.keys(post).forEach( (key) => {
				if (post[key])
					table="right"
				else
					table="wrong";
				query+="SELECT * FROM `"+table+"` WHERE question_id="+key.split('_')[0]+" AND answer_id="+key.split('_')[1]+";";
				grades[x]=[key,''];
				x++;
			});

			//Create a MySQL database connection
			var connection = mysql.createConnection(para.db);

			//Connect to MySQL database
			connection.connect();

			//Inform the web browser of the type of content to be sent
			res.setHeader('Content-Type', 'application/json; charset=utf-8');

			connection.query(query, (error, rows, fields) => {

				if (error) console.log(error);

				for (x=0;x<rows.length;x++){
					if (rows[x][0])
						grades[x][1]=true;
					else
						grades[x][1]=false;
				}
				
				for (x=0;x<grades.length;x=x+3)
					if (grades[x][1]&&grades[x+1][1]&&grades[x+2][1]) right_answers++;

				var percentage = Math.round(300*right_answers/grades.length);

				//Inform the web browser the status code is 200, no errors
				res.statusCode = 200;

				//Send response
				res.end(JSON.stringify(grades));

				var name = tokenCheck(cookieParser(req.headers).quiz_token).name;
				if (name){
					connection.query("SELECT stats FROM users WHERE name='"+name+"' ;", (error, rows, fields) => {
						var stats=JSON.parse(rows[0].stats);
						stats.push(percentage);
						stats=stats.slice(-10);
						connection.query("UPDATE `users` SET stats='"+JSON.stringify(stats)+"' WHERE name='"+name+"' ;", (error, rows, fields) => {
						if (error) console.log(error);
						})
					})
				}
				else
					//Kill the MySQL connection
					connection.end();

			})
		})
	}

	//Sends data for a single quiz
	if (req.url=="/getquiz"){

		var body = '';

		req.on('data', function (data) {
			body += data;
		});

		req.on('end', function () {

			//Create a MySQL database connection
			var connection = mysql.createConnection(para.db);

			//Connect to MySQL database
			connection.connect();

			connection.query("SELECT questions FROM quiz WHERE quiz_id="+body+";", (error, rows, fields) => {

				if (error) console.log(error);

				var questions=JSON.parse(rows[0].questions);

				//Sort the question list in a random order
				questions.sort(function(a, b){return 0.5 - Math.random()});

				var query="";

				for (x=0;x<questions.length;x++){
				query+="SELECT question_text,question_id FROM question WHERE question_id="+questions[x]+";";
				query+="(SELECT answer_text,answer_id \
						FROM `question` JOIN `right` USING (question_id) JOIN `answer` USING (answer_id)\
						WHERE question_id="+questions[x]+")\
						UNION\
						(SELECT answer_text,answer_id\
						FROM `question` JOIN `wrong` USING (question_id) JOIN `answer` USING (answer_id)\
						WHERE question_id="+questions[x]+") ORDER BY RAND() LIMIT 3;";}


				//Run SQL query and specify a function to be run when the answer from the database arrives
				connection.query(query, (error, rows, fields) => {

					if (error) console.log(error);

					//Inform the web browser of the type of content to be sent
					res.setHeader('Content-Type', 'application/json; charset=utf-8');

					var result=[];
					for (i=0;i<rows.length;i=i+2){
						var question=[];
						var answer=[]
						question=[rows[i][0].question_id,rows[i][0].question_text];
						for (z=0;z<rows[i+1].length;z++)
							answer[z]=[rows[i+1][z].answer_id,rows[i+1][z].answer_text];
						result[i/2]=[question,answer];
					}

					//Inform the web browser the status code is 200, no errors
					res.statusCode = 200;

					//Send response
					res.end(JSON.stringify(result));

					//Kill the MySQL connection
					connection.end();

				});

			});
		});
	}

}).listen(1206);
