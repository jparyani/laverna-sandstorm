CXX=clang++
CXXFLAGS=-O2 -Wall
CXXFLAGS2=-std=c++1y -Itmp $(CXXFLAGS)
SANDSTORM_CAPNP_DIR=/opt/sandstorm/latest/usr/include

.PHONEY: all clean dev

package.spk: server sandstorm-pkgdef.capnp empty
	spk pack package.spk

dev: server sandstorm-pkgdef.capnp empty
	spk dev

clean:
	rm -rf tmp server package.spk empty

tmp/genfiles:
	@mkdir -p tmp
	capnp compile --src-prefix=$(SANDSTORM_CAPNP_DIR) -oc++:tmp $(SANDSTORM_CAPNP_DIR)/sandstorm/*.capnp
	@touch tmp/genfiles

server: tmp/genfiles server.c++
	$(CXX) -static server.c++ tmp/sandstorm/*.capnp.c++ -o server $(CXXFLAGS2) `pkg-config capnp-rpc --cflags --libs`

empty:
	mkdir -p empty

