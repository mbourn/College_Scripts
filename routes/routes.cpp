/*Written  by: mbourn
  Written  on: 12/5/12
  Description: This program creates a binary search tree of basic nodes.  Each
               contains three pointers (left, right, and parent), a string
               (city name), and an int (the distance to the parent city).  The
               user can add cities, search for cities, find the direct path 
               between two cities, and find the distance between two cities.  I
               think I may have been a little sleep deprived when I wrote the 
               comments.
*/

#include <iostream>
#include <assert.h>
#include <vector>
using namespace std;
#include "stree.h"

// Where the magic happens ...
int main()
{
    // I am god to my variables. Worship me!!
    string str = "Zaphod_Beeblebrox";
    string origin = "x";
    string parent = "x";
    string target = "x";
    string childLeft = "x";
    string childRight = "x";
    string destination = "x";
    
    int dist = -1;
    int parent_dist = -1;
    int childLeft_dist = -1;
    int childRight_dist = -1;
    
    // With the water of my wisdom and the seed of 
    // my mind I cause the binary tree to grow
    // from the soil of the aether
    Stree tree;

    // Behold! My creation is good and now I shall
    // describe for you a realm in which you may 
    // interact with my creation for as long as
    // I deem you worthy.  Be hasty and do not dally
    // for my patience for mortals doth wane hastily.
    while( cin >> str )    
    {
        // The president of the galaxy is not welcome
        assert( str != "Zaphod_Beeblebrox");
       
        /////////////////////////////////////////////////////////////////////////////////
        // This will insert a new child/leaf into the tree.  The left child/leaf is
        // always created first. Only two leaves to a branch.
        if( str == "insert" )
        {
            assert( str == "insert" );

            cin >> origin;
            cin >> destination;
            cin >> dist;

            // If the insert fails for some reason, print error
            if( tree.insert( origin, destination, dist ) == false)
            {
                cerr << "Error: could not insert "<< origin 
                     << ", " << destination << endl;
            }
        }

        ////////////////////////////////////////////////////////////////////////////////
        // This will query the tree in search for a node in the tree. If the Node is 
        // found, its vital stats will be printed.
        if( str == "lookup" )
        {
            cin >> target;
            
            // If the city is in the tree then print stuff
            if( tree.lookup( target, parent, parent_dist, childLeft,
                     childLeft_dist,childRight, childRight_dist )==true)
            {
                // Print stuff
                cout << target << ": "; 

                if( parent == "none" )
                {
                    assert( parent == "none" );
                    cout << parent << ", ";
                }
                else
                    cout << parent << "(" << parent_dist << "), ";
                
                if( childLeft == "none" )
                {
                    assert( childLeft == "none" );
                    cout << childLeft << ", ";
                }
                else
                    cout << childLeft << "(" << childLeft_dist << "), ";
                
                if( childRight == "none" )
                {
                    assert( childRight == "none" );
                    cout << childRight << endl;
                }
                else
                    cout<< childRight<< "("<< childRight_dist<< ")"<< endl;
            }
            else  
            {
                assert( tree.lookup( target, parent, parent_dist, childLeft,
                    childLeft_dist,childRight, childRight_dist )==false);
                cerr << "Error: " << target << " not in tree" << endl;
            }
        }

        /////////////////////////////////////////////////////////////////////////////////
        // This will attempt to find a direct, parent->child path between two given Nodes
        // If the path exists, the total distance bxn the two is printed
        if( str == "distance" )
        {
            cin >> origin;
            cin >> destination;
            dist = 0;
    
            // If both are in the tree but there's no path bxn them
            if( tree.distance( origin, destination, dist ) == false )
            {
                cerr << "Error: no path between " << origin 
                     << " and " << destination << endl;
            }
            else
            {
                cout << origin << " to " << destination << " is " << dist;
                if( dist == 1 )
                    cout << " mile" << endl;
                else
                    cout << " miles" << endl;
            }
        }
        
        //////////////////////////////////////////////////////////////////////////////////
        // This will find a Node in the tree and, if it exists, remove it and all of its
        // children
        if( str == "remove" )
        {
            cin >> target;
            
            // If the remove was unsuccessful it will return false and 
            // print the error
            if( !tree.remove( target ))
                cerr << "Error: could not remove " << target << endl;
        }

        if( str == "path" )
        {
            // Get path endpoints
            cin >> origin;
            cin >> destination;

            // Clear vector from any previous path commands
            if( !tree.cityVector.empty())
                tree.cityVector.clear();
            
            // If there's no path bxn the endpoint print an error
            if( !tree.path( origin, destination ))
            {
                cerr << "Error: no path between " << origin << " and " 
                     << destination << endl;
            }
            // If tree.path() == true then the path has been entered into 
            // the vector.  Print the path.
            else
            {
                cout << origin;
                while( !tree.cityVector.empty())
                {
                    cout << " --> " << tree.cityVector.back();
                    tree.cityVector.pop_back();
                }
                cout << endl;
            }
        }
        
        //////////////////////////////////////////////////////////////////////////////////
        // If a command is given that is not handled by this program print and error
        // and remove all arguments from the buffer. CAUTION: this will only work if the 
        // input is properly formatted with each command and its arguments on a single 
        // line followed by endl.
        if( str != "insert" && str != "remove" && str != "distance" 
                            && str != "path" && str != "lookup" )
        {
            cerr << "Error: <" << str << "> is not a valid command" << endl;
            getline( cin, str );
        }
    }
}
