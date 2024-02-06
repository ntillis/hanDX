import { randomBytes, randomFill } from "crypto";
import { addDoc, collection } from "firebase/firestore";
import { getServerSession } from "next-auth";
import { redirect } from 'next/navigation';
import { Props } from "next/script";
import React from "react";
import { db } from "../firebase";
import AddTree from "@/components/AddTree";


//TODO: Implement creating a decision tree which will
//pass info form form to decision tree

export default async function CreateNewTree() {
    const session = await getServerSession();
    if (!session || !session.user) {
        redirect('/signin');
    }
    
    return  (
        <div className='container'>
          <div>
              <h1>Add Decision Tree</h1>
              <form className="text">
              <div>
                  <label className="Card--body-text">Decision Tree Name</label>
                  <input
                  type="text"
                  id='name'
                  placeholder="Type here"
                  />
              </div>

              <div>
                  <label className="Card--body-text">Tree Short Name</label>
                  <input
                  id='shortName'
                  type="text"
                  placeholder="Type here"
                  />
              </div>

              <div>
                  <label className="Card--body-text">Tree Description</label>
                  <input
                  id='description'
                  type="text"
                  placeholder="Type here"
                  />
              </div>
              <AddTree/>
              </form>
          </div>
      </div>
    );
}