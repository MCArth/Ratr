const functions = require('firebase-functions');
var crypto = require('crypto');

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

 exports.addHouse = functions.https.onRequest(async (req, res) => {
	// Grab the text parameter.
	// Push the new message into the Realtime Database using the Firebase Admin SDK.
	// Redirect with 303 SEE OTHER to the URL of the pushed object in the Firebase console.
	const housesMetaData = db.ref('/housesMetaData');
	const housesRef = db.ref('/houses');

	const houseInfo = req.query.text;
	const snapshot = await housesRef.push({original: houseInfo});
	console.log(snapshot);
	res.json("{'status': 200}");
});

exports.addUser = functions.https.onRequest(async (req, res) => {
	const userRef = db.ref('/users');
	const username = req.query.username;
	const password = req.query.password;
	const hashed_pw = crypto.createHash('md5').update(password).digest('hex');
	admin.database().ref('users').once('value', snap =>  {
		data = snap.val()
		console.log(data);
		if(!checkExistingUsername(data, username)) {
			const mySNappp = admin.database().ref('/users').push({username: username, password: hashed_pw});
			console.log(mySNappp);
			res.status(200)
			res.json({status: 200});
		} else {
			res.status(403)
			res.json({status: 403});
		}
		return data
	},
	).then((data) => {
		return data;
	}).catch((err) => {console.log(err); return null;})
});

function checkExistingUsername (usersList, username){
for(var user in usersList){
	userInfo = usersList[user];
	if(userInfo.username === username){
		return true
		}
	}
	return false
}

exports.updateHouse = functions.https.onRequest(async (req, res) => {
	const housesRef = db.ref('/houses');

	const newHouseInfo = req.query.text;
	console.log(newHouseInfo);
	// const newHouseJson = JSON.parse(newHouseInfo);
	const newHouseJson = JSON.parse(newHouseInfo);
	housesRef.once('value', snap =>  {
			json = snap.val();
			console.log(json);
			let allHouses = json;
			for(var databaseId in json) {
				houseInfo = JSON.parse(allHouses[databaseId]["original"]);
				console.log(houseInfo);
				if (houseInfo['lat'] === newHouseJson['lat'] && houseInfo['long'] === newHouseJson['long']) {
					db.ref("/houses/" + databaseId).set({"original": newHouseInfo});
				}
			}
			res.json("{'status': 200}");

			return json;
		},
		).then((json) => {
			// console.log(json);
			// let allHouses = json;
			// allHouses.array.forEach(databaseId => {
			// 	houseInfo = allHouses[databaseId];
			// 	if (houseInfo['lat'] === newHouseJson['lat'] && houseInfo['long'] === newHouseJson['long']) {
			// 		housesRef.child(databaseId).update(newHouseInfo);
			// 	}
			// });
			// res.json("{'status': 200}");
			return null;
		}).catch((err) => {console.log(err); return null;})
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
	const hashed_pw = crypto.createHash('md5').update(password).digest('hex');

	admin.database().ref('users').once('value', snap =>  {
				json = snap.val();
				res.status(loginCheck(json, username, hashed_pw));
				res.json(null);
				return null;
			},
		).then((json) => {
			return null;
	}).catch((err) => {console.log(err); return null;})
});

function loginCheck (usersList, username, password){
	for(var user in usersList){
		userInfo = usersList[user];
		if(userInfo.username === username){
			if (userInfo.password === password){
				return 200;
			} else {
				console.log("Wrong password");
				return 401;
			}
		}
	}

	// for (let i = 1; i < usersList.length; i++){
	// 	if (usersList[i].username === username){
	// 		if (usersList[i].password.toString() === password){
	// 			return 200;
	// 		} else {
	// 			return 401;
	// 		}
	// 	}
	// }
	console.log("User not found"); 
	return 401;
}

function getUser() {
	// Grab the text parameter.
	// const original = req.query.text;
	// var json;
	admin.database().ref('users').once('value', snap =>  {
				data = snap.val()
				list = data;
				return data
			},
		).then((data) => {
			return data;
		}).catch((err) => {console.log(err); return null;})

 }

exports.checkUser2 = functions.https.onRequest(async (req, res) => {
	const userRef = db.ref('/users');
	const username = req.query.username;
	const password = req.query.password;
	var ref = admin.database().ref("users");
	ref.orderByChild("username").equalTo(username).on("child_added", function(snapshot) {
  console.log(snapshot.key);
	});
	
});




exports.updateLandlord = functions.https.onRequest(async (req, res) => {
	const landlordRef = db.ref('/landlords');
	const newLLInfo = req.query.text;
	const newLLJson = JSON.parse(newLLInfo);
	landlordRef.once('value', snap =>  {
			json = snap.val();
			console.log(json);
			let allLL = json;
			for(var databaseId in json) {
				landlordInfo = JSON.parse(allLL[databaseId]["original"]);
				console.log(databaseId + " " + landlordInfo['name'] + " " + newLLJson['name'])
				if (landlordInfo['name'] === newLLJson['name']) {
					db.ref("/landlords/" + databaseId).set({"original": newLLInfo});
				}
			}
			res.json("{'status': 200}");

			return json;
		},
		).then((json) => {
			return null;
		}).catch((err) => {console.log(err); return null;})
});

exports.addLandlord = functions.https.onRequest(async (req, res) => {
	// Grab the text parameter.
	// Push the new message into the Realtime Database using the Firebase Admin SDK.
	// Redirect with 303 SEE OTHER to the URL of the pushed object in the Firebase console.
	const landlordRef = db.ref('/landlords');

	const landlordInfo = req.query.text;
	const snapshot = await landlordRef.push({original: landlordInfo});
	res.json("{'status': 200}");
});

exports.getLandlords = functions.https.onRequest((req, res) => {
	// Grab the text parameter.
	// const original = req.query.text;
	// var json;
	admin.database().ref('landlords').once('value', snap =>  {
				json = snap.val()
				res.json(json)
				return json
			},
		).then((json) => {
			console.log(json);
			return null;
		}).catch((err) => {console.log(err); return null;})
 });


exports.getPropertyStats = functions.https.onRequest((req, res) => {
	admin.database().ref('landlords').once('value', snap =>  {
			json = snap.val()
			result = {};
			houses = [];

			let allHouses = json;
			for(var databaseId in json) {
				houseInfo = JSON.parse(allHouses[databaseId]["original"]);
				houses.push(houseInfo);
			}
			if(house.length === 0) {
				res.json({})
				return {}
			}
			let totalppa = totalRating = 0;
			houses.sort(function(a, b){return a["pricePerAnnum"]-b["pricePerAnnum"]});
			for(var house in houses) {
				totalppa += house["pricePerAnnum"];
				totalRating += house[avgRating];
			}
			result["priceInfo"] = {}
			result["priceInfo"]["meanPrice"] = totalppa/houses.length
			result["priceInfo"]["medianPrice"] = houses[Math.floor(houses.length/2)]["pricePerAnnum"];
			let percentile25 = houses[Math.floor(houses.length/4)]["pricePerAnnum"];
			let percentile75 = houses[Math.floor(3*houses.length/4)]["pricePerAnnum"];
			let percentile90 = houses[Math.floor(9*houses.length/10)]["pricePerAnnum"];
			result["priceInfo"]["25thPercentilePrice"] = percentile25;
			result["priceInfo"]["75thPercentilePrice"] = percentile75;
			result["priceInfo"]["90thPercentilePrice"] = percentile90;

			result["meanHouseRating"] = totalRating/houses.length;

			res.json(result)
			return result
		},
		).then((json) => {
			console.log(json);
			return null;
		}).catch((err) => {console.log(err); return null;})
});