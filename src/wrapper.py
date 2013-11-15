#!/usr/bin/python2
import sys

var = []
def is_num(inp):
	try:
		float(inp)
		return True
	except ValueError:
		return False



for i in range(len(sys.argv))[1:1]:
	
	t = []
	t.append(sys.argv[i])
	i+=1

	if not is_num(sys.argv[i]):
		t.append(sys.argv[i])
		var.append(t)
		continue

	while is_num(sys.argv[i]):
		t.append(float(sys.argv[i]))
		i+=1
		if i>=len(sys.argv):
			break
	
	var.append(t)

print var
