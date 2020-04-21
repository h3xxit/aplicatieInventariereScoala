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

window.addEventListener('load', async function () {
    var pathArray = window.location.href.split('/');
    var length = pathArray.length
    console.log(pathArray[length-2]+'/'+pathArray[length-1])
    await firebase.auth().signInWithEmailAndPassword('sorana.aurelia@gmail.com', 'abc1234').then(
        async function(user){
            console.log("user");

            const nameUI = document.getElementById("nameobj");
            const roomUI = document.getElementById("roomobj");
            nameUI.innerHTML = ""
            roomUI.innerHTML = ""

            return objectRef = await database.ref('Objects/' + pathArray[length-2] + '/' + pathArray[length-1]).once('value').then(function(snapshot) {
                console.log("am intrat in databse");
                console.log(pathArray[length-2]+ '/' + pathArray[length-1])
                
                if(snapshot==null) {
                    console.log("1");
                    window.location.replace(pathArray[length-2] + '/' + pathArray[length-1], 'notfound');
                }

                if(snapshot.val()==null) {
                    console.log("2");
                    window.location.replace(pathArray[length-2] + '/' + pathArray[length-1], 'notfound');
                }
                
                var name = snapshot.val().Name;
                var room = snapshot.val().Room;

                console.log(name + " " + room);
                
                nameUI.innerHTML = 'Obiect: ' + name;
                roomUI.innerHTML = 'Sala: ' + room;

                if(name==null || room==null) {
                    console.log("3");
                    window.location.replace(pathArray[length-2] + '/' + pathArray[length-1], 'notfound');
                }
            },
            function(err){
                console.log("4");
                window.location.replace(pathArray[length-2] + '/' + pathArray[length-1], 'notfound');
            }
        )
    
            
    });

});

