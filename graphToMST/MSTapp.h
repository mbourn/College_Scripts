/*
 * MSTapp.h
 *
 *  Created on: Dec 7, 2013
 *      Author: Matthew Bourn
 */

#ifndef MSTAPP_H_
#define MSTAPP_H_

#include<iostream>
#include<string>
#include<vector>
#include<list>
#include"Graph.h"

using namespace std;

class Node{
public:
	Node();
	Node(int, string, string, vector<Edge>);

	// Setters
	void setKey(int);
	void setName(string);
	void setParent(string);
	void setAdj(vector<Edge>);

	// Getters
	int getKey();
	string getName();
	string getParent();
	vector<Edge> getAdj();
	void printAdj();

	vector<Edge> adjVerts;

private:
	int key;
	string name;
	string parent;


};

class MST{
public:
	unsigned int parent(unsigned int);
	unsigned int left(unsigned int);
	unsigned int right(unsigned int);
	unsigned int getMinQSize();
	Node* HeapExtractMin();
	void setTotalWeight(int);
	void addToTotalWeight(int);
	void printTotalWeight();
	void MinHeapify(unsigned int);
	void HeapDecreaseKey(unsigned int, int);
	void nodify(vector<list<Edge> >);
	void getNextVert();

private:
	vector<Node*> minQ;
	int totalWeight;
};


#endif /* MSTAPP_H_ */
