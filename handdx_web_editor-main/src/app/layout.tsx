import './globals.css'
import { Metadata } from 'next'
import { Inter } from 'next/font/google'
import { authOptions } from '../../pages/api/auth/[...nextauth]';
import { getServerSession } from 'next-auth';
import Login from './Login';
import Home from './page';
import Welcome from './welcome/page'
import NavMenu from './NavMenu';
import SessionProvider from './SessionProvider';



const inter = Inter({ subsets: ['latin'] })

/* Server routing, send to login if user is not signed into a session, otherwise send to logged in home page */
export const metadata: Metadata = {
  title: 'HandDx Editor',
  description: 'Web editor for HandDx iOS app'
}

export default async function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  const session = await getServerSession(authOptions);

  //General layout of website
  return (
    <html lang="en">
      <body className={inter.className}>
        <SessionProvider session={session}>
          <div>
            {!session ? (
              <Login />
            ) : (
              <div className='wrapper'>
                <Home/>
                <NavMenu />
                <div className=" p-8 text-1xl flex text-white child">
                
                </div>
                <div className='child pageContent'>{children}</div>
              </div>
            )}
          </div>
          <hr />
          
        </SessionProvider>
      </body>
    </html>
  );
}
