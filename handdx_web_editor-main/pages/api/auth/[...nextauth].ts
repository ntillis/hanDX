import NextAuth, { AuthOptions, NextAuthOptions } from "next-auth";
import GoogleProvider from "next-auth/providers/google";
import CredentialsProvider from "next-auth/providers/credentials";
import { signInWithEmailAndPassword } from "firebase/auth";
import { auth } from "@/app/firebase";

export const authOptions: NextAuthOptions = {
  // Configure authentication providers and adapters
  pages: {
    signIn: '/signin'
  },
  providers: [
    // Google provider
    GoogleProvider({
      clientId: process.env.GOOGLE_CLIENT_ID!,
      clientSecret: process.env.GOOGLE_CLIENT_SECRET!
    }),
    // Email and password provider
    CredentialsProvider({
      name: 'Credentials',
      credentials: {},
      async authorize(credentials): Promise<any> {
        return await signInWithEmailAndPassword(auth, (credentials as any).email || '', (credentials as any).password || '')
          .then(userCredential => {
            if (userCredential.user) {
              return userCredential.user;
            }
              return null;
          })
          .catch(error => (console.log(error)))
      }
    })
  ]
}

export default NextAuth(authOptions)
