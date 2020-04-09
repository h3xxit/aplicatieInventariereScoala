import Firebase from 'firebase'
 let config = {
    apiKey: "AIzaSyBJEEW6b1RStTBt8tbcs9WAmX4O418SBf0",
    authDomain: "inventarierescoala.firebaseapp.com",
    databaseURL: "https://inventarierescoala.firebaseio.com",
    projectId: "inventarierescoala",
    storageBucket: "inventarierescoala.appspot.com",
    messagingSenderId: "627746644272",
    appId: "1:627746644272:web:2c6523eb30105e5f29a8f5",
    measurementId: "G-577CXRM5ZF"
  };
let app = Firebase.initializeApp(config)
export const db = app.database()