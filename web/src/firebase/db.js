import firebase from 'firebase/app'
import 'firebase/database'

export const db = firebase
  .initializeApp({ databaseURL: 'https://inventarierescoala.firebaseio.com/' })
  .database()