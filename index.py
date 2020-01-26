#!/usr/bin/env python3

import os, sys, cgi, datetime
import html, html.parser, html.entities
def cur_date():
    return datetime.datetime.now().strftime("%d.%m.%Y")
def cur_time():
    return datetime.datetime.now().strftime("%H:%M")
def getfile(name: str):
    f = open(name, "r")
    t = f.read()
    f.close()
    return t
def putfile(name: str, txt):
    f = open(name, "w")
    f.write(txt)
    f.close()

def main(argv):
    form = cgi.FieldStorage()
    print("Content-type: text/html")
    print()
    new = form.getfirst("post")
    post = getfile("base.html")
    if new:
		temp = getfile("template.html")
        temp = temp.replace("$TEXT$", new)
		temp = temp.replace("$DATE$", cur_date() + " " + cur_time(), 1)
		temp = temp.replace("$AUTH$", "anon", 1)
		post += temp
        putfile("base.html", post)

    print(getfile("book.html").format(post))
    return 0

if __name__ == "__main__":
    exit(main(sys.argv))
