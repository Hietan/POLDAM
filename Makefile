METAFILE_DIR = MetafileParser
METAFILE_INCLUDE_DIR = MetafileParser/include
METAFILE_SRC_DIR = MetaFileParser/src

INTERPRETER_DIR = Interpreter
INTERPRETER_SRC_DIR = Interpreter/src

GRAPH_DIR = Graph
GRAPH_SRC_DIR = $(GRAPH_DIR)/src

UTIL_DIR = Util
UTIL_INCLUDE_DIR = $(UTIL_DIR)/include/src

#win
BOOST_PATH = /home/prebe/boost_1_18

#mac 
#BOOST_PATH = usr/local/boost_1_80_0

main: main.cpp util.o metafileParser.o interpreter.o omniGraph.o
	g++-11 -I/$(BOOST_PATH) -I./ main.cpp util.o metafileParser.o interpreter.o omniGraph.o -o main

MetafileParserTest: metafileParser.o util.o
	g++-11 $(METAFILE_DIR)/test/main.cpp metafileParser.o util.o -o MetaFileParserTest
	./MetaFileParserTest
	rm MetaFileParserTest

util.o: $(UTIL_INCLUDE_DIR)/poldamUtil.h $(UTIL_INCLUDE_DIR)/poldamUtil.cpp
	g++-11 -o util.o -c  $(UTIL_INCLUDE_DIR)/poldamUtil.cpp

metafileParser.o: $(METAFILE_SRC_DIR)/*.cpp $(METAFILE_SRC_DIR)/*.h
	g++-11 -c $(METAFILE_SRC_DIR)/*.cpp
	ar rvs metafileParser.o dataids.o factory.o objectFile.o seloggerLog.o methods.o classes.o
	rm factory.o
	rm objectFile.o
	rm seloggerLog.o
	rm dataids.o
	rm methods.o
	rm classes.o 

interpreter.o: $(INTERPRETER_SRC_DIR)/*
	g++-11 -c $(INTERPRETER_SRC_DIR)/*.cpp
	ar rvs interpreter.o eventHandler.o
	rm eventHandler.o

omniGraph.o: $(GRAPH_SRC_DIR)/*.cpp $(GRAPH_SRC_DIR)/*.h
	g++-11 -I/$(BOOST_PATH) -c $(GRAPH_SRC_DIR)/*.cpp
	ar rvs omniGraph.o graph.o graphDiff.o
	rm graph.o
	rm graphDiff.o 

clean: *.o
	rm -f *.o
	rm -f *.out
