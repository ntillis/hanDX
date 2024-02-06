'use client'
import { db } from '@/app/firebase'
import { doc, addDoc, collection, deleteDoc } from 'firebase/firestore'
import Link from 'next/link'
import * as React from 'react'
import { useRef, useState } from 'react'


//Deletes tree, but not nodes, please look through Firestore documentation on deleting subcollections
//TODO: Implement subcollection deletion
type Props = {
  decisionTree: IDecisionTree
}

const DeleteTree: React.FC<Props> = ({ decisionTree }) => {
  const deleteTree = () => {
      const docRef = deleteDoc(doc(db, "decisionTrees", decisionTree.id));
    }

    return (
      <>
        <Link href={`/myTrees`} passHref><button type="submit" className="delete" onClick={deleteTree}>Delete</button></Link>
      </>
    )
  }
  export default DeleteTree