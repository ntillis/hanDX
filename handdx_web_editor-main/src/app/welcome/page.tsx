import { getServerSession } from "next-auth";
import { redirect } from 'next/navigation';

//Welcome page
export default async function Welcome() {
    const session = await getServerSession();
    if (!session || !session.user) {
        redirect('/signin');
    }

    return (
        <div className='text-black'> 
            Welcome to the HandDx Decision Tree Editor
            
        </div>
    )
}