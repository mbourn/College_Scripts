/*
 * Graph.h
 *
 *  Created on: Dec 7, 2013
 *      Author: Matthew Bourn
 */

#ifndef GRAPH_H_
#define GRAPH_H_

#include<iostream>
#include<string>
#include<vector>
#include<list>

using namespace std;

struct Edge{
	string pred;
	int weight;
	void printEdge(){	cout << pred << " " << weight << endl; }
};

class Graph{
public:
	vector<string> parse(string);
	int strToInt(string);
	void firstLine( vector<string> );
	void fillGraph( vector<string>);
	void printGraph();

	// Getters
	vector<list<Edge> > getGraph();

private:
	vector< list<Edge> > adjList;
};
#endif /* GRAPH_H_ */
