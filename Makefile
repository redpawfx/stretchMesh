#//////////////////////////////////////////////////////////////////////////////////
#//// GENERIC  make file
#///////////////////////////////////////////////////

#/////////////////////////////////
#/// version 1.0
#/// author : johnc
#\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

#
# Include platform specific build settings
#
include ./buildconfig

.SUFFIXES: .cpp .cc .o .so .c .bundle

OUTPUT = ./

EXT	= so


##  shared Object / plugin
PLUGIN =  stretchMesh.$(EXT)

EXTRA_INCLUDES =  -I$(MAYA_LOCATION)/include

EXTRA_LIBS =  -L$(MAYA_LOCATION)/lib

COMPILE  = $(CC) -c $(CFLAGS) $(INCLUDES)  $(EXTRA_INCLUDES)

.cpp.o:
	$(COMPILE) $< -o $@

plugins: $(PLUGIN)

depend:
	makedepend $(INCLUDES) $(EXTRA_INCLUDES) *.cc *.cpp

clean:
	-rm -f *.o *~


##################
# Specific Rules #
##################

SOURCES =  	pluginMain.cpp\
		stretchMeshCmd.cpp\
		stretchMeshDeformer.cpp\
		curveColliderLocator.cpp

OBJS = $(SOURCES:.cpp=.o)

all: $(SOURCES) $(PLUGIN)

$(PLUGIN): $(OBJS)
	-rm -f $(OUTPUT)$@
	$(LD) -o $(OUTPUT)$@ $(OBJS) $(LIBS) $(EXTRA_LIBS) -lgomp -lOpenMayaUI -lOpenMaya  -lFoundation -lOpenMayaAnim -lOpenMayaFX -lOpenMayaRender



