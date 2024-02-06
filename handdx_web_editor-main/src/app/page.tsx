'use client';
import { signOut, useSession } from 'next-auth/react';
import { redirect } from 'next/navigation';

//Home page after login
export default function Home() {
  const session = useSession({
    required: true,
    //Redirects to signin after signout
    onUnauthenticated() {
      redirect('/signin');
    }
  })

  // Redirect to page to create new decision trees
  const goToCreateNewTreePage = () =>{
    redirect('/signin');
  }

  return (
    //TS for logged in page
    <>
      <div className='logout-button'>
        <button onClick={() => signOut()}>Logout</button>
      </div>

      <div className="p-8">
        <div className='text-black center'> HandDx Decision Tree Editor</div>
        <div className='text-black welcome'>Welcome {session?.data?.user?.name}!</div>
      </div>
    </>
  )
}

Home.requireAuth = true
