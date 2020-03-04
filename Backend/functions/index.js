const functions = require('firebase-functions');

const admin = require('firebase-admin');
admin.initializeApp();

var db = admin.database()
var messagesRef = db.ref('/messages')

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });

// Take the text parameter passed to this HTTP endpoint and insert it into the
// Realtime Database under the path /messages/:pushId/original
exports.addMessage = functions.https.onRequest(async (req, res) => {
	// Grab the text parameter.
	const original = req.query.text;
	// Push the new message into the Realtime Database using the Firebase Admin SDK.
	const snapshot = await messagesRef.push({original: original});
	// Redirect with 303 SEE OTHER to the URL of the pushed object in the Firebase console.
	res.redirect(303, snapshot.ref.toString());
});

// Listens for new messages added to /messages/:pushId/original and creates an
// uppercase version of the message to /messages/:pushId/uppercase
exports.makeUppercase = functions.database.ref('/messages/{pushId}/original')
	.onCreate((snapshot, context) => {
		// Grab the current value of what was written to the Realtime Database.
		const original = snapshot.val();
		console.log('Uppercasing', context.params.pushId, original);
		const uppercase = original.toUpperCase();
		// You must return a Promise when performing asynchronous tasks inside a Functions such as
		// writing to the Firebase Realtime Database.
		// Setting an "uppercase" sibling in the Realtime Database returns a Promise.
		return snapshot.ref.parent.child('uppercase').set(uppercase);
	});


exports.readMesages = functions.https.onRequest((req, res) => {
	// Grab the text parameter.
	// const original = req.query.text;
	// var json;
	admin.database().ref('messages').once('value', snap =>  {
				json = snap.val()
				res.json(json)
				return json
			},
		).then((json) => {
			console.log(json);
			return null;
		}).catch((err) => {console.log(err); return null;})
	console.log("test")
 });

 exports.getHouses = functions.https.onRequest((req, res) => {
	// Grab the text parameter.
	// const original = req.query.text;
	// var json;
	admin.database().ref('houses').once('value', snap =>  {
				json = snap.val()
				res.json(json)
				return json
			},
		).then((json) => {
			console.log(json);
			return null;
		}).catch((err) => {console.log(err); return null;})
 });

 exports.login = functions.https.onRequest(async (req, res) => {
	// Grab the text parameter.
	const username = req.query.username;
	const password = req.query.password;

	admin.database().ref('users').once('value', snap =>  {
				json = snap.val();
				res.status(loginCheck(json, username, password));
				res.json(json);
				return null;
			},
		).then((json) => {
			return null;
	}).catch((err) => {console.log(err); return null;})
});

function loginCheck (usersList, username, password){
	console.log(usersList);
	for (let i = 1; i < usersList.length; i++){
		if (usersList[i].username === username){
			if (usersList[i].password.toString() === password){
				return 200;
			} else {
				return 401;
			}
		}
	}
	console.log("User not found"); 
	return 401;
}

exports.getUser = functions.https.onRequest((req, res) => {
	// Grab the text parameter.
	// const original = req.query.text;
	// var json;
	admin.database().ref('users').once('value', snap =>  {
				data = snap.val()
				res.json(data)
				return data
			},
		).then((data) => {
			console.log(data);
			return null;
		}).catch((err) => {console.log(err); return null;})
 });