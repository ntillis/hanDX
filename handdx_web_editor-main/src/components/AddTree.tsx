'use client'
import { db } from '@/app/firebase'
import { addDoc, collection } from 'firebase/firestore'
import * as React from 'react'
import { useRef, useState } from 'react'

//Manually adds tree
export default function AddTree() {
  const addTree = () => {
    const docRef = addDoc(collection(db, "decisionTrees"), {
        longTreeName: "Hand Rash",
        pictureURL: "https://na.com",
        rootNode: "i12902430j3ffwj",
        shortTreeName: "Rash",
        treeDescription: "Rash on hand or arm area.",
    });
  }
  return (
    <div>
        <button type="submit" className="edit" onClick={addTree}>Submit</button>
    </div>
  );
}