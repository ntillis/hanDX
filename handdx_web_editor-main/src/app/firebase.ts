// Import the functions you need from the SDKs you need
import { getApp, getApps, initializeApp } from "firebase/app";
import { getAuth } from "firebase/auth";
import { getFirestore, } from 'firebase/firestore';

// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyAZmVZSD-hKdn7pTEg5EHCuaYEo3b2OkIw",
  authDomain: "handyapp-f6206.firebaseapp.com",
  databaseURL: "https://handyapp-f6206.firebaseio.com",
  projectId: "handyapp-f6206",
  storageBucket: "handyapp-f6206.appspot.com",
  messagingSenderId: "445247952089",
  appId: "1:445247952089:web:03235477950829e4109ac8",
  measurementId: "G-F39LEQNKDK"
};

// Initialize Firebase
const app = getApps().length ? getApp() : initializeApp(firebaseConfig);
const db = getFirestore(app);
const auth = getAuth(app);

export { app, db, auth }