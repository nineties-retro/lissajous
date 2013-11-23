lissajous_cl:
	gnatmake lissajous_cl.adb

clean:
	rm -rf lissajous.ali lissajous.o lissajous_cl.ali lissajous_cl.o

realclean: clean
	rm -f lissajous_cl

distclean: realclean
	find . -name '*~' -print0 | xargs -0 rm -f
