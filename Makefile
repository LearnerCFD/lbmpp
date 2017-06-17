CXX = c++
CXX_FLAGS = -std=c++14 -fopenmp
OPT_FLAGS = -O3 
# OPT_FLAGS += -fopenmp -ffast-math
DEBUG_FLAGS = -g -Wall -pedantic -Wno-strict-overflow
LD_FLAGS = 

ifeq ($(NOVIZ),1)
SRCS = src/driver.cpp
else
SRCS = src/visual_driver.cpp
LD_FLAGS += -L/usr/X11R6/lib -lm -lpthread -lX11
SRCS +=	src/viz/SolutionViewer.cpp
endif

SRCS +=	src/sim/Simulator.cpp
SRCS +=	src/cell/Cell.cpp
SRCS +=	src/grid/Grid.cpp
SRCS +=	src/grid/GridLevel.cpp
SRCS +=	src/grid/BoundaryConditions.cpp

%.o: %.cpp
	$(CXX) $(CXX_FLAGS) $(OPT_FLAGS) $(DEBUG_FLAGS) -c $< -o $@ $(LD_FLAGS)

OBJS = $(SRCS:.cpp=.o)

# Finally, creating the main application.
lbmpp: $(OBJS)
	$(CXX) $(CXX_FLAGS) $(OPT_FLAGS) $(DEBUG_FLAGS) $^ -o lbmpp $(LD_FLAGS)

CLEANFILES = lbmpp
CLEANFILES += $(OBJS)
CLEANFILES += *.o[0-9][0-9]*
CLEANFILES += *.e[0-9][0-9]*
CLEANFILES += *.btr

clean:
	rm -f *~ $(CLEANFILES) driver.o visual_driver.o

# eof
