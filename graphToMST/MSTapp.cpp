/*Written  by: mbourn
  Written  on: 12/18/13
  Description: This program creates an undirected graph from user input
                and then creates a minimum spanning tree from it.  The 
                professor had a list of reqirements to make the program
                more challenging, but I can't find the instructions 
                anywhere and I don't remember the details.
*/

#include<iostream>
#include<vector>
#include<list>
#include<string>
#include<math.h>

#include"Graph.h"
#include"MSTapp.h"

using namespace std;

///////////////////////////////////////////////////
// class Node
///////////////////////////////////////////////////
// Constructors
Node::Node(){
	key=100;
	name=' ';
	parent="  ";
}
Node::Node(int k, string n, string p, vector<Edge> adj){
	key=k;
	name=n;
	parent=p;
	adjVerts=adj;
}

// Setters
void Node::setKey(int k){
	key=k;
}
void Node::setName(string n){
	name=n;
}
void Node::setAdj(vector<Edge> adj){
	adjVerts=adj;
}
void Node::setParent(string p){
	parent=p;
}

// Getters
int Node::getKey(){
	return key;
}
string Node::getName(){
	return name;
}
vector<Edge> Node::getAdj(){
	return adjVerts;
}
void Node::printAdj(){
	for(unsigned int i=0; i<adjVerts.size(); i++){
		adjVerts[i].printEdge();
	}
}
string Node::getParent(){
	return parent;
}

////////////////////////////////////////////////////
////////////////////////////////////////////////////

////////////////////////////////////////////////////
// class MST
////////////////////////////////////////////////////
// Calculates the index of a parent node in the minQ
unsigned int MST::parent(unsigned int i){
	return floor((i/2));
}

// Calculates a node's left child's index in the minQ
unsigned int MST::left(unsigned int i){
	return (2*i);
}

// Calculates a node's right child's index in the minQ
unsigned int MST::right(unsigned int i){
	return (2*i + 1);
}

// Returns the size of the minQ
unsigned int MST::getMinQSize(){
	return minQ.size();
}

// Returns a pointer to the first node in the minQ and
// Removes it from the minQ
Node* MST::HeapExtractMin(){
	Node* min = minQ[0];
	minQ.erase(minQ.begin());
	MinHeapify(0);
	return min;
}

// Set the variable totalWeight to the given value
void MST::setTotalWeight(int w ){
	totalWeight=w;
}

// Adds the passed value to the variable totalWeight
void MST::addToTotalWeight(int w){
	totalWeight+=w;
}

// Prints the value stored in the totalWeight variable
void MST::printTotalWeight(){
	cout<<totalWeight<<endl;
}

// Maintains the minimum heap property for minQ
void MST::MinHeapify(unsigned int i){
	// Declare and initialize vars
	unsigned int smallest = 0;
	unsigned int l=left(i);
	unsigned int r=right(i);
	vector<Node*>::iterator sItr = minQ.begin() + l;
	vector<Node*>::iterator cItr = minQ.begin() + i;
	if( l < minQ.size() && (*(sItr))->getKey() < (*(cItr))->getKey() ){
		smallest = l;
	}
	else
		smallest = i;

	// Reset the iterators
	sItr = minQ.begin() + r;
	cItr = minQ.begin() + smallest;

	if( r < minQ.size() && sItr < cItr){
		smallest = r;
	}
	if( smallest != i){
		// Swap minQ[i] and minQ[smallest]
		Node* n = minQ[i];
		vector<Node*>::iterator del=minQ.begin()+i;
		minQ.erase(del);
		minQ.insert( cItr, n);

		n = minQ[smallest];
		cItr = minQ.begin() + i;
		minQ.insert(cItr, n);

		MinHeapify(smallest);
	}
}

// Decreases the key value of a node in the minQ
// The index number and value are passed to the alg
void MST::HeapDecreaseKey(unsigned int i, int k){
	if(minQ[i]->getKey() > k){
		minQ[i]->setKey(k);
		while( i>1 && minQ[parent(i)]->getKey() > minQ[i]->getKey() ){
			Node* temp = minQ[i];
			minQ[i] = minQ[parent(i)];
			minQ[parent(i)] = temp;
			i=parent(i);
		}
	}
}

// Takes the adjacency list as an arg and turns it
// Into node objects which are then inserted into
// The minQ
void MST::nodify(vector<list<Edge> > g){
	// Declare vars
	vector<list<Edge> >::iterator vItr = g.begin();
	list<Edge>::iterator lItr = vItr->begin();
	vector<Edge> edgeVect;
	string name;
	string parent = "NIL";

	// Create root node and push into queue
	name = lItr->pred;
	lItr++;
	while( lItr != vItr->end()){
		edgeVect.push_back(*(lItr));
		lItr++;
	}
	minQ.push_back(new Node(0, name, parent, edgeVect));
	edgeVect.clear();
	vItr++;

	// Create all other nodes and push into queue
	for(unsigned int i =1; i<g.size(); i++){
		lItr=g[i].begin();
		name=lItr->pred;
		lItr++;
		while( lItr != vItr->end()){
			edgeVect.push_back(*(lItr));
			lItr++;
		}
		minQ.push_back(new Node(100, name, parent, edgeVect));
		edgeVect.clear();
		vItr++;
		lItr=vItr->begin();
	}
}

// Takes the first node from minQ, searches its
// Internal adjacency list and sets the edge weight
// Of all the nodes to which it is connected.  It then
// Calculates the minimum spanning tree using Prim's
// Algorithm.
void MST::getNextVert(){
	Node* current = HeapExtractMin();
	addToTotalWeight(current->getKey());
	if(current->getKey()==0){
		cout << current->getName() << " NIL 0" << endl;
	}
	else{
		cout << current->getName() << ' ' << current->getParent() << ' ';
		cout << current->getKey();
		cout << endl;
	}
	for(unsigned int i=0; i<current->adjVerts.size(); i++){
		unsigned int j=0;
		while(j<minQ.size() && current->adjVerts[i].pred != minQ[j]->getName()){
			j++;
		}
		if(j<minQ.size() && minQ[j]->getKey() > current->adjVerts[i].weight){

			minQ[j]->setParent( current->getName());
			HeapDecreaseKey(j, current->adjVerts[i].weight);

			int k = 1;
			int l = 0;
			int sizeQ=minQ.size();
			Node* ptr;
			for( k=1; k < sizeQ; k++){
				ptr=minQ[k];
				l=k-1;
				while(l>=0 && minQ[l]->getKey()>ptr->getKey()){
					minQ[l+1] = minQ[l];
					l-=1;
				}
				minQ[l+1]=ptr;
			}
		}
	}
}

////////////////////////////////////////////////////
////////////////////////////////////////////////////

int main(){
	// Declare vars
	Graph g;
	MST q;
	q.setTotalWeight(0);
	vector<string> cmd;
	string input;

//////////////// Stage 1 //////////////////////////
//////// Create the graph adjacency list///////////
	// Get first line of input
	getline(cin, input);

	// Break string into vector of strings
	cmd = g.parse(input);

	// Fill the first row of the graph.
	g.firstLine(cmd);

	// Fill the rest of the adjacency list
	g.fillGraph(cmd);

/////////////////// Stage 2 ////////////////////////
////////////// Create the min priority queue ///////
	// Nodify the vertices and insert them into the
	// Min priority queue following the min heap properties
	vector<list<Edge> >graph=g.getGraph();
	q.nodify(graph);

	// Calls getNextVert() on each node in the minQ
	// Until the queue is empty
	unsigned int qSize=q.getMinQSize();
	for(unsigned int i=0; i<qSize; i++){
	q.getNextVert();
	}

	// Prints the accumulated weight of all edges
	// In the minimum spanning tree.
	q.printTotalWeight();
	return 0;
}



