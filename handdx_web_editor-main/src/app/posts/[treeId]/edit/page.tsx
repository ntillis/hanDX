import { getServerSession } from "next-auth";
import { redirect } from 'next/navigation';
import { db } from '@/app/firebase'
import { collection, doc, getDoc, getDocs, query, where } from "firebase/firestore";
import React from "react";
import DecisionTree from "@/components/PostTree";
import Link from "next/link";
import Image from 'next/image'
import EditTree from "@/components/EditTree";


//TODO: Implement 
export default async function TreePost({ params }: { params: { treeId: string } }) {
    const session = await getServerSession();
    if (!session || !session.user) {
        redirect('/signin');
    }

    //Get tree data
    const docRef = doc(db, "decisionTrees", params.treeId);
    const treeSnap = await getDoc(docRef);

    //Set prevTree to data
    const prevTreeData = treeSnap.data() as {
        id: string;
        longTreeName: string;
        pictureURL: string;
        rootNode: string;
        shortTreeName: string;
        treeDescription: string;
    };

    const tree: IDecisionTree = {
        id: treeSnap.id,
        longTreeName: prevTreeData.longTreeName,
        pictureURL: prevTreeData.pictureURL,
        rootNode: prevTreeData.rootNode,
        shortTreeName: prevTreeData.shortTreeName,
        treeDescription: prevTreeData.treeDescription,
    }

    //TODO: Pass form to EditTree to be able to update tree
    return  ( <>
            <div className='container'>
                <div>
                    <h1>Edit Decision Tree</h1>
                    <form className="text">
                    <div>
                        <label className="Card--body-text">Decision Tree Name</label>
                        <input
                        type="text"
                        id='name'
                        placeholder={prevTreeData.longTreeName}
                        />
                    </div>

                    <div>
                        <label className="Card--body-text">Tree Short Name</label>
                        <input
                        id='shortName'
                        type="text"
                        placeholder={prevTreeData.shortTreeName}
                        />
                    </div>

                    <div>
                        <label className="Card--body-text">Tree Description</label>
                        <input
                        id='description'
                        type="text"
                        placeholder={prevTreeData.treeDescription}
                        />
                    </div>
                    <EditTree
                    key={treeSnap.id}
                    decisionTree={tree}
                    />
                    </form>
                </div>
            </div>
            </>  
          //TODO: Add picture URL editing
    );
} 