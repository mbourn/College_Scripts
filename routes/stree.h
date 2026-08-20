// File Name:           stree.h
// Coder:               Bourn, Matthew
// Username:            mbourn

#ifndef STREE_H
#define STREE_H

#include <iostream>
using namespace std;

#include <string>
#include <vector>

class Stree
{
    public:
        // C-tor
        Stree();

        // D-tor
        ~Stree();

        // We need tha func()
        bool insert( string origin, string destination, int dist );
        bool remove( string city );
        bool lookup( string target, string &parent, int &parent_dist,
                     string &childLeft, int &childLeft_dist,
                     string &childRight, int &childRigh_dist);
        bool path( string origin, string destination );        
        bool distance( string origin, string destination, int &dist );
        bool inTree( string city );

        // And a vector because they're awesome!! and to hold the names
        // of the cities in the path
        vector<string> cityVector;

    private:
        // the Nodes
        class Node
        {
            public:
                // C-tor
                Node( string city, Node *parent, int dist, Node *childLeft,
                      Node *childRight )
                {
                    m_city = city;
                    m_parent = parent;
                    m_dist = dist;
                    m_childLeft = childLeft;
                    m_childRight = childRight;
                }
                // D-tor
                ~Node()
                {  delete m_childLeft; delete m_childRight;  }


                // Node m_vars
                string m_city;
                Node *m_parent, *m_childLeft, *m_childRight;
                int m_dist;
        };

        // Private func() even better than public func()
        bool findCity( Node *root, string target, Node *&ptr );
        bool findPath_dist( string origin, Node* destPtr, int &dist );
        bool findPath_city( string origin, Node* destPtr );
        // Stree m_vars
        Node *m_root;
};
#endif
