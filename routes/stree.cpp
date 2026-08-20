// File Name:           stree.cpp
// Coder:               Bourn, Matthew
// Username:            mbourn

#include <iostream>
#include <assert.h>
#include <string>
#include <vector>
using namespace std;
#include "stree.h"

/////////////////////////////////////////////////////////////////////////////////////
// C-tor
Stree::Stree()
{
    // Every tree starts at the root
    m_root = NULL;
}

/////////////////////////////////////////////////////////////////////////////////////
// D-tor
Stree::~Stree()
{
    // You must destroy the root
    delete m_root;
}

/////////////////////////////////////////////////////////////////////////////////////
// Insert a new city into the tree.  The city to be added is
// destination and the dist = distance bxn in miles
bool Stree::insert( string origin, string destination, int dist )
{
    // If the tree is empty, create the first two nodes
    if( !m_root )
    {
        // Just checking
        assert( !m_root );

        // If the tree is empty, set the origin as the root and the
        // destination a the left child
        m_root = new Node( origin, NULL, 0, NULL, NULL );
        Node *tmp = new Node( destination, m_root, dist, NULL, NULL );
        m_root->m_childLeft = tmp;
        
        return true;
    }
    // If it isn't empty but the destination already exists
    Node *ptr = m_root;
    if( findCity( m_root, destination, ptr ) == true)
        return false;
    // If the destination isn't in the tree
    ptr = m_root;
    if( findCity( m_root, origin, ptr ) == true )
    {
        // If the origin city is found but it already has 2 children
        if( ptr->m_childLeft != NULL && ptr->m_childRight != NULL)
            return false;
        else
        {
            // Else create the left child
            if( ptr->m_childLeft == NULL )
            {
                assert( ptr->m_childLeft == NULL );
                ptr->m_childLeft = new Node( destination, ptr, dist, NULL, NULL);
                return true;
            }
            // Else create the right child
            else
            {
                assert( ptr->m_childRight == NULL );
                ptr->m_childRight= new Node( destination, ptr, dist, NULL, NULL);
                return true;
            }
        }
    }
    // If it isn't empty but the origin city doesn't exist
    else
        return false;
}

/////////////////////////////////////////////////////////////////////////////////////
// Remove a node, and all of its cildren, from the tree
bool Stree::remove( string target )
{
    // Is the target node in the tree?
    if( !inTree( target ))
        return false;
    // Is the target node m_root?  If so, delete the whole tree, set m_root to NULL
    if( target == m_root->m_city )
    {   
        assert( target == m_root->m_city );
        delete m_root;
        m_root = NULL;
        return true;
    }
    
    // If the node is in the tree but it's not m_root, find it, delete it, discover
    // if the target was left or right, reset that to pointer to NULL
    else
    {
        Node *ptr;
        findCity( m_root, target, ptr );
        if( ptr->m_parent->m_childLeft == ptr )
            ptr->m_parent->m_childLeft = NULL;
        else
            ptr->m_parent->m_childRight = NULL;
        return true;
    }
}

/////////////////////////////////////////////////////////////////////////////////////
// Search for a given city name from a given starting point. If found ptr
// points to the found node with the given city and is PBR back to caller 
bool Stree::findCity( Node *root, string target, Node *&ptr )
{
    if( root == NULL )
    {
        return false;
    }
    else if(root->m_city == target)
    {
        assert(root != NULL);
        ptr = root;
        return true;
    }
    
    // Search down the left trowser leg
    bool city_found = false; 
    city_found = findCity(root->m_childLeft, target, ptr);
    
    // Continue searching down the right trowser leg
    if( city_found == false)
    {
        return findCity( root->m_childRight, target, ptr );
    }
    else
    {
        return true;
    }
}

/////////////////////////////////////////////////////////////////////////////////////
// In the middle of the night
// I go walking in my sleep
// Through the jungle of doubt
// To the river so deep
// I know I'm searching for something
bool Stree::lookup( string target, string &parent, int &parent_dist,
                    string &childLeft, int &childLeft_dist,
                    string &childRight, int &childRight_dist )
{
    // If there is no tree it will make a sound when it fall in the 
    // forest regardless of if there is anyone there to hear it because 
    // the statement is vacuously true. And we shouldn't look any more
    if( !m_root )
        return false;

    Node *ptr = m_root;
    if( m_root->m_city == target )
    {
        parent = "none";
        parent_dist = 0;
        
        // You check your left edge here
        if( !m_root->m_childLeft )
        {
            assert( !m_root->m_childLeft );
            childLeft = "none";
            childLeft_dist = 0;
        }
        else
        {
            childLeft = m_root->m_childLeft->m_city;
            childLeft_dist = m_root->m_childLeft->m_dist;
        }
        
        // You check your right edge there
        if( !m_root->m_childRight )
        {   
            assert( !m_root->m_childRight );
            childRight = "none";
            childRight_dist = 0;
        }
        else
        {
            childRight = m_root->m_childRight->m_city;
            childRight_dist = m_root->m_childRight->m_dist;
        }
        return true;
    }
    
    else if( findCity(m_root, target, ptr) == true )
    {
        assert( ptr != NULL );
        // PBR your parent (Pass By Ref)
        parent = ptr->m_parent->m_city;
        parent_dist = ptr->m_dist;
                
        // You check your left edge here
        if( !ptr->m_childLeft )
        {
            childLeft = "none";
            childLeft_dist = 0;
        }
        else
        {
            childLeft = ptr->m_childLeft->m_city;
            childLeft_dist = ptr->m_childLeft->m_dist;
        }
        
        // You check your right edge there
        if( !ptr->m_childRight )
        {
            childRight = "none";
            childRight_dist = 0;
        }
        else
        {
            childRight = ptr->m_childRight->m_city;
            childRight_dist = ptr->m_childRight->m_dist;
        }
        return true;
    }

    // If you got here something went wrong
    return false;
}

////////////////////////////////////////////////////////////////////////////////////
// Find the path bxn two cities. Must be direct, parent->child
bool Stree::path( string origin, string destination )
{
    if( !inTree( origin ))
        return false;
    if( !inTree( destination ))
        return false;
    Node* destPtr = NULL;
    findCity( m_root, destination, destPtr );
    assert( destPtr != NULL );
    if( findPath_city( origin, destPtr ) == false)
        return false;
    else
        return true;
}

////////////////////////////////////////////////////////////////////////////////////
// Find the distance between two cities from main()
bool Stree::distance( string origin, string destination, int &dist )
{
    // Check to make sure the origin and destination are in the tree
    if( !inTree( origin ))
        return false;
    if( !inTree( destination))
        return false;
    // Set ptr to the destination Node
    Node* destPtr = NULL;
    findCity( m_root, destination, destPtr );
    assert(destPtr != NULL );
    if( findPath_dist( origin, destPtr, dist ) == false )
        return false;
    else
        return true;
}

////////////////////////////////////////////////////////////////////////////////////
// Find a direct, parent -> child path between two Nodes using private vars
// Passes back both the accumulated distance and the vector of cities
bool Stree::findPath_dist( string origin, Node* destPtr, int &dist ) 
{
    // Base case
    if( destPtr->m_parent == NULL)
        return false;
    // Incrament dist    
    dist += destPtr->m_dist;
    // Catch when parent is found
    if( destPtr->m_parent->m_city == origin )
        return true;
    // Find the parent
    return findPath_dist( origin, destPtr->m_parent, dist );
}
   
/////////////////////////////////////////////////////////////////////////////////////
// Find a direct, parent->child path bxn two Nodes recursively using private vars
// If successful, the path bxn the two point will be intered into the vector
bool Stree::findPath_city( string origin, Node* destPtr )
{
    // Base case
    if( destPtr->m_parent == NULL )
        return false;
    // Enter city name into vector
    cityVector.push_back( destPtr->m_city );
    // Catch when parent is found
    if( destPtr->m_parent->m_city == origin )
        return true;
    // Find the parent
    return findPath_city( origin, destPtr->m_parent );
}

/////////////////////////////////////////////////////////////////////////////////////
// Check if a given city is in the tree from main
bool Stree::inTree( string city )
{
    Node *ptr = m_root;
    Node *tmp = NULL;
    return findCity( ptr, city, tmp );
}
