const admin = require("firebase-admin");
const serviceAccountCreds = require("./keys/serviceAccountCreds.json");

admin.initializeApp({
	credential: admin.credential.cert(serviceAccountCreds),
});

firestoreDB = admin.firestore();
storageDB = admin.storage();

module.exports = {firestoreDB, storageDB};