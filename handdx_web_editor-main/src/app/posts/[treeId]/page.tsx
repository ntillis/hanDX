import { getServerSession } from "next-auth";
import { redirect } from 'next/navigation';
import { db } from '@/app/firebase'
import { collection, doc, getDoc, getDocs, query, where } from "firebase/firestore";
import React from "react";
import DecisionTree from "@/components/PostTree";
import Link from "next/link";
import Image from 'next/image'
import DeleteTree from "@/components/DeleteTree";
import TreeNode from "@/components/PostNode";

export default async function TreePost({ params }: { params: { treeId: string } }) {
    const session = await getServerSession();
    if (!session || !session.user) {
        redirect('/signin');
    }

    const docRef = doc(db, "decisionTrees", params.treeId);
    const treeSnap = await getDoc(docRef);

    const treeData = treeSnap.data() as {
        longTreeName: string;
        pictureURL: string;
        rootNode: string;
        shortTreeName: string;
        treeDescription: string;
    };

    const tree: IDecisionTree = {
        id: treeSnap.id,
        longTreeName: treeData.longTreeName,
        pictureURL: treeData.pictureURL,
        rootNode: treeData.rootNode,
        shortTreeName: treeData.shortTreeName,
        treeDescription: treeData.treeDescription,
    }

    const nodesSnapshot = await getDocs(collection(db, "decisionTrees", treeSnap.id, "nodes"));

    const nodes: INode[] = nodesSnapshot.docs.map((doc) => {
        const nodeData = doc.data() as {
            isResult: boolean
            nextSteps: string
            pictureURL: string
            question: string
            result: string
            statement: string
        };
        return { id: doc.id, ...nodeData } as INode;
    });
    
    //Displays individual tree and its nodes
    return  <>
                <div className="container">
                <h1 className='h1'>Decision Tree</h1>
                <h2 className='h2'>ID: {params.treeId}</h2>
                <h2 className='h2'>Tree Name: {treeData.longTreeName}</h2>
                <h2 className='h2'>Short Tree Name: {treeData.shortTreeName}</h2>
                <h2 className='h2'>Tree Description: {treeData.treeDescription}</h2>
                </div>
                <div className="bcontainer">
                <button type="submit" className="edit"><Link className="edit-ch" href={`/posts/${params.treeId}/edit`} passHref>Edit</Link></button>
                <DeleteTree
                key={params.treeId}
                decisionTree={tree}
                />
                </div>
                <div>
                <h2 className='nodes'>Tree Nodes</h2>
                    {nodes.map((post) => (
                        <div key={post.id}>
                            <TreeNode
                            key={post.id}
                            node={post}
                            />
                        </div>
                    ))}
                </div>
            </>
            ;
   } 