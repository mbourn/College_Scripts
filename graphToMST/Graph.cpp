/*
 * Graph.cpp
 *
 *  Created on: Dec 7, 2013
 *      Author: Matthew Bourn
 */

#include<iostream>
#include<vector>
#include<list>
#include<string>
#include<cstdlib>

#include"Graph.h"

using namespace std;

// Takes a string as input and converts it to an int
// Which it then returns
int Graph::strToInt(string str){
	const char* cNum;
	cNum=str.c_str();
	return (atoi(cNum));
}

// A diagnostic algorithm that prints off the content
// Of the graph object
void Graph::printGraph(){
// Diagnostics
vector<list<Edge> >::iterator vItr=adjList.begin();
list<Edge>::iterator lItr=vItr->begin();
unsigned int i = 0;
while( vItr!=adjList.end() ){
	lItr=adjList[i].begin();
		while( lItr!=adjList[i].end() ){
			lItr->printEdge();
			lItr++;
		}
	vItr++;
	i++;
	}
}

// A getter to copy the graph and make it usable
vector<list<Edge> > Graph::getGraph(){
	return adjList;
}

// This takes the a string and breaks it up
// Using white space as a delimiter.  Each
// Substring is pushed into a vector of strings
// Which is returned
vector<string> Graph::parse( string str ){
	unsigned i = 0;
	string sub;
	vector<string> vect;
	// Break up the string into smaller sub strings
	// Save each of those substrings in order in a vector
	while( str.find(' ') != string::npos ){
		// Walk through the string until until white space
		// Each char is added to the string 'sub'
		i = 0;
		while( str[i] != ' '){
			sub = sub+str[i];
			i++;
		}
		// Push the substring into the vector
		// Clear the string 'sub'
		// Truncate off the first word in the input string
		vect.push_back(sub);
		sub.clear();
		str = str.substr(str.find(' ')+1, str.size());
		}
	// Loop through once more to get last word in string
	// Push it on to the vector are return the vector
	i = 0;
	while( i < str.size()){
		sub = sub+str[i];
		i++;
	}
	vect.push_back(sub);

	return vect;
}

// This takes an input vector of strings
// and uses the contents to fill the first line
// of the graph
void Graph::firstLine( vector<string> cmd ){
	// Declare vars
	vector<string>::iterator vitr;
	Edge edge;
	int weight=0;
	list<Edge> vList;

	// Takes each vertex name and turns it into a Edge struct
	// Then pushes those edges into the first element of each
	// Nested list.  These act as indexes for when the graph
	// Is filled later
	vitr = cmd.begin();
	unsigned int i = 0;
	while( i < cmd.size() ){
		edge.pred=cmd[i];
		edge.weight=weight;
		vList.push_back(edge);
		adjList.push_back(vList);
		vList.clear();
		vitr++;
		i++;
		}
}

// This takes a vector of strings and uses them
// To fill in the rest of the adjacency list
void Graph::fillGraph( vector<string> cmd ){
	// Declare vars
	vector<list<Edge> >::iterator vItr;
	list<Edge>::iterator lItr;
	Edge edge;
	Edge otherEdge;
	string input;
	int weight;

	// Get input, turn it into a Edge, insert it into its
	// Proper place in the proper nested list
	while( getline(cin, input)){

		// Break the input string into a vector of strings
		cmd=parse(input);

		// Convert the weight string into an int
		weight=(strToInt(cmd[2]));

		// Place the values in the Edge structs
		edge.pred=cmd[1];
		edge.weight=weight;
		otherEdge.pred=cmd[0];
		otherEdge.weight=weight;

		// Find the correct list for the edge by looking at
		// the first/index Edge of each list. In this, lItr->pred
		// points at the name of the vertex, not its predecessor
		vItr = adjList.begin();
		lItr = vItr->begin();
		for(unsigned int i=0; i<adjList.size() && cmd[0] != lItr->pred; i++){
			vItr++;
			lItr=vItr->begin();
		}
		// Insert in alphabetical order
		while(lItr != vItr->end() && cmd[1]>lItr->pred){
			lItr++;
		}

		// Insert the Edge into the correct element in the correct list
		if(lItr==vItr->begin()){
					vItr->push_back(edge);
				}
				else{
					vItr->insert(lItr, edge);
				}

	    // Insert the opposite end of the edge
		vItr = adjList.begin();
		lItr = vItr->begin();
		for(unsigned int i=0; i<adjList.size() && edge.pred != lItr->pred; i++){
			vItr++;
			lItr=vItr->begin();
		}

		// Increment past index edge, then walk down list looking
		// For proper place to insert
		lItr++;
		while(lItr != vItr->end() && otherEdge.pred > lItr->pred){
			lItr++;
		}

		// Insert the Edge into the correct element in the correct list
		vItr->insert(lItr, otherEdge);
	}
	return;
}

