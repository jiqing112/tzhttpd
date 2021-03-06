#!/bin/bash

echo "build normal httpsrv ..."
g++ -std=c++0x -DNP_DEBUG -Wall  main.cpp -I../ -I../../xtra_rhel6.x/include -L../build/ -L../../xtra_rhel6.x/libs/debug/boost/ -ltzhttpd -lboost_system -lboost_thread -lboost_date_time -lboost_regex -lpthread -lrt -rdynamic -ldl -lconfig++ -lssl -o httpsrv

echo "build httpsrv with tzmonitor support ..."
 g++ -std=c++0x  -DNP_DEBUG -Wall main2.cpp -I../ -I../../xtra_rhel6.x/include -L./tzmonitor -L../build/ -L../../xtra_rhel6.x/libs/debug/boost/ -ltzhttpd -ltzmonitor_client -ljsoncpp -lthrifting -lthriftz -lthrift -lboost_system -lboost_thread -lboost_date_time -lboost_regex -lpthread -lrt -rdynamic -ldl -lconfig++ -lssl -lcurl -o httpsrv2
