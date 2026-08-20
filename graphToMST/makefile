mst : Graph.o MSTapp.o
	g++ -o mst -W -Wall -Werror -pedantic -g Graph.o MSTapp.o

Graph.o : Graph.h Graph.cpp
	g++ -c -W -Wall -Werror -pedantic -g Graph.h Graph.cpp

MSTapp.o : MSTapp.h MSTapp.cpp
	g++ -c -W -Wall -Werror -pedantic -g MSTapp.h MSTapp.cpp

clean :
	rm *.o; rm *.gch; clear; ls
	
	
