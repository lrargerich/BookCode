from __future__ import division
import csv
import re
import math
from pprint import *

data = "labeledTrainData.tsv"
fsize = 2**22


def parseFile(data,name,fsize):
	istest=False
	filerows = open(name+"_rows.m", "w")
	filecols = open(name+"_cols.m", "w")
	filesent = open(name+"_sent.m", "w")
	filerows.write("rows=[")
	filecols.write("cols=[")
	filesent.write("sent_"+name+"=[")
	for e, line in enumerate(open(data,"rb")):
		rows=[]
		cols=[]
		sentiments=[]
		if e>0:
			if e % 100 == 0:
				print "Processing:"+str(e)+" lines"
			r = line.strip().split("\t")
			if len(r) == 3: #train set
				istest=False 
				features = [1+(hash(f)%fsize) for f in r[2].split()]
				label = int(r[1])
			else: #test set
				istest=True
				features = [1+(hash(f)%fsize) for f in r[1].split()]
				label = 1
			rows= [e for i in range(0,len(features))]
			cols =  features;
			for row in rows:
				filerows.write(str(row)+" ")
			for col in cols:
				filecols.write(str(col)+" ")			
			filesent.write(str(label)+" ")
			if e>=100000:
				break
	filerows.write(str(e+1))
	filecols.write(str(fsize))

	filerows.write("];\n")	
	filecols.write("];\n")
	filesent.write("];\n")
	

parseFile("labeledTrainData.tsv","train",fsize)
parseFile("testData.tsv","test",fsize)
print("Done!")