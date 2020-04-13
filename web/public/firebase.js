// Your web app's Firebase configuration
var firebaseConfig = {
    apiKey: "AIzaSyBJEEW6b1RStTBt8tbcs9WAmX4O418SBf0",
    authDomain: "inventarierescoala.firebaseapp.com",
    databaseURL: "https://inventarierescoala.firebaseio.com",
    projectId: "inventarierescoala",
    storageBucket: "inventarierescoala.appspot.com",
    messagingSenderId: "627746644272",
    appId: "1:627746644272:web:2c6523eb30105e5f29a8f5",
    measurementId: "G-577CXRM5ZF"
};
// Initialize Firebase
firebase.initializeApp(firebaseConfig);

const database = firebase.database();

window.addEventListener('load', function () {

    const nameUI = document.getElementById("nameobj");
    const roomUI = document.getElementById("roomobj");
    nameUI.innerHTML = ""
    roomUI.innerHTML = ""

    var pathArray = window.location.href.split('/');
    var length = pathArray.length

    return objectRef = database.ref('Objects/' + pathArray[length-2] + '/' + pathArray[length-1]).once('value').then(function(snapshot) {
        if(snapshot==null) {
            window.location.replace(pathArray[length-2] + '/' + pathArray[length-1], 'notfound');
        }

        if(snapshot.val()==null) {
            window.location.replace(pathArray[length-2] + '/' + pathArray[length-1], 'notfound');
        }
        
        var name = snapshot.val().Name;
        var room = snapshot.val().Room;
        
        nameUI.innerHTML = 'Obiect: ' + name;
        roomUI.innerHTML = 'Sala: ' + room;

        if(name==null || room==null) {
            window.location.replace(pathArray[length-2] + '/' + pathArray[length-1], 'notfound');
        }
            
    });

});

