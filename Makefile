# QShisen for Qt2 - Makefile
# Ported from KDE2 to pure Qt2 using qt2-kde-mini

PREFIX ?= /opt/gnux
DESTDIR ?=
BINDIR ?= $(PREFIX)/bin
DATADIR ?= $(PREFIX)/share/qshisen
QTDIR ?= $(PREFIX)/qt2
QT2KDEMINI ?= ../qt2-kde-mini
MOC = $(QTDIR)/bin/moc

CXX = g++
CXXFLAGS = -O3 -fomit-frame-pointer -Wall -Wno-parentheses -D_UNIXWARE -DPREFIX=\"$(PREFIX)\" -I$(QTDIR)/include -I$(QT2KDEMINI)/include -I.
LDFLAGS = -L$(QTDIR)/lib -L$(QT2KDEMINI) -L$(PREFIX)/lib -lqt -lqt2kdemini -lgnux

TARGET = qshisen

# Source files
SOURCES = main.cpp app.cpp board.cpp

# Moc files
MOC_SOURCES = moc_app.cpp moc_board.cpp

# Objects
OBJECTS = $(SOURCES:.cpp=.o) $(MOC_SOURCES:.cpp=.o)

all: $(TARGET)

$(TARGET): $(OBJECTS)
	$(CXX) -o $@ $(OBJECTS) $(LDFLAGS)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

moc_%.cpp: %.h
	$(MOC) $< -o $@

# Moc dependencies
app.o: moc_app.cpp
board.o: moc_board.cpp

clean:
	rm -f $(OBJECTS) $(MOC_SOURCES) $(TARGET)

install:
	mkdir -p $(DESTDIR)$(BINDIR)
	mkdir -p $(DESTDIR)$(DATADIR)/pics
	cp $(TARGET) $(DESTDIR)$(BINDIR)/
	cp pics/*.xpm $(DESTDIR)$(DATADIR)/pics/

.PHONY: all clean install
