'use client';
import './globals.css'
import { signIn } from 'next-auth/react';
import Image from 'next/image';
import { useRouter } from 'next/navigation';
import React, { useState } from 'react';

//Home page to sign in 
export default function Login() {
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const router = useRouter();
    return (
        //TS for signin page
        <>
            <main className="main">
                {/* Title */}
                <svg width="700" height="82" viewBox="0 0 610 82">
                    <text x="25" y="70">HandDx Editor</text>
                </svg>
                {/* HandDx Logo */}
                <Image
                className="logo"
                src="/1024.png"
                alt="HandDx Logo"
                width={220}
                height={220}
                priority
                />
                {/* Sign in form */}
                <form method="post">
                    <div className="container">
                        <label ><b>Email</b></label>
                        <input type="text" placeholder="Enter Email" id="email" onChange={(e) => setEmail(e.target.value)} required/>

                        <label><b>Password</b></label>
                        <input type="password" placeholder="Enter Password" id="password" name="password" onChange={(e) => setPassword(e.target.value)} required/>

                        <button className="full-width" onClick={() => signIn('credentials', {email, password, redirect: true, callbackUrl: '/'})} disabled={!email || !password}>
                            Sign In
                        </button>
                    </div>  
                    <div className="container">
                        <button className="full-width" id="google" onClick={() => signIn('google')} formNoValidate>Google Sign In</button>
                    </div>
                </form>  
            </main>
        </>
    )
}
 