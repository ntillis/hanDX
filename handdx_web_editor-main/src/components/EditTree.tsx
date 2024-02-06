'use client'
import { db } from '@/app/firebase'
import { addDoc, collection, doc, updateDoc } from 'firebase/firestore'
import Link from 'next/link'
import * as React from 'react'
import { useRef, useState } from 'react'

//Edit pulls from decision tree and manually updates
//TODO: Change to update input form data only
type Props = {
  decisionTree: IDecisionTree
}

const EditTree: React.FC<Props> = ({ decisionTree }) => {
  const editTree = () => {
    const docRef = updateDoc(doc(db, "decisionTrees", decisionTree.id), {
        treeDescription: "Rash on hand, wrist, or arm area.",
    });
  }
  return (
    <>
        <Link href={`/posts/${decisionTree.id}`} passHref><button type="submit" className="edit" onClick={editTree}>Apply Changes</button></Link>
    </>
  )
}
export default EditTree