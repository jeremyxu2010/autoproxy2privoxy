SHELL = /bin/sh

all : gfwlist.action

gfwlist.txt :
	curl -q -o - -x $(proxy) https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt | base64 -D > $@

gfwlist.action : gfwlist.txt
	gawk -f autoproxy2privoxy.awk -v proxy="$(proxy)" -v keyword="$(keyword)" -v verbose="$(verbose)" $< > $@

.PHONY : clean
clean :
	-rm gfwlist.txt gfwlist.action
