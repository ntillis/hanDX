"use client";
import Link from "next/link";
import './home.css';
import {signIn, signOut, useSession} from "next-auth/react";
import { usePathname } from "next/navigation";

const ACTIVE_ROUTE = "active";
const INACTIVE_ROUTE ="inactive";

//Nav menu for website
export default function NavMenu() {
    const pathname = usePathname();
    return (
      <div>
        <hr/>
        <ul>
        <Link href="/welcome">
            <li
              className={
                pathname === "/welcome" ? ACTIVE_ROUTE : INACTIVE_ROUTE
              }
            >
              <p>
              Home
              </p>
            </li>
          </Link>
          <Link href="/createNewTree">
            <li
              className={
                pathname === "/createNewTree" ? ACTIVE_ROUTE : INACTIVE_ROUTE
              }
            >
              <p>
              Create New Tree
              </p>
            </li>
          </Link>
          <Link href="/myTrees">
            <li
              className={
                pathname === "/myTrees" ? ACTIVE_ROUTE : INACTIVE_ROUTE
              }
            > <p>
              My Trees
              </p>
            </li>
          </Link>
        </ul>
      </div>
    );
  }