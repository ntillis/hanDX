import { getServerSession } from "next-auth";
import { redirect } from 'next/navigation';
import { db } from '@/app/firebase'
import { collection, getDocs } from "firebase/firestore";
import React from "react";
import DecisionTree from "@/components/PostTree";
import Link from "next/link";

export default async function MyTrees() {
  const session = await getServerSession();
  if (!session || !session.user) {
    redirect('/signin');
  }

  // Fetch decision tree data from Firestore
  const treesSnapshot = await getDocs(collection(db, "decisionTrees"));

  const trees: IDecisionTree[] = treesSnapshot.docs.map((doc) => {
    const treeData = doc.data() as {
      longTreeName: string;
      pictureURL: string;
      rootNode: string;
      shortTreeName: string;
      treeDescription: string;
    };
    return { id: doc.id, ...treeData } as IDecisionTree;
  });

  if (!trees.length) return <h1>Loading...</h1>;

  //Maps tree data to trees and posts all trees
  return (
    <>
      <h1 className='h1'>Decision Trees</h1>
      {trees.map((post) => (
        <div key={post.id}>
          <Link href={`/posts/${post.id}`} passHref>
            <DecisionTree
              key={post.id}
              decisionTree={post}
            />
          </Link>
        </div>
      ))}
    </>
  );
}
