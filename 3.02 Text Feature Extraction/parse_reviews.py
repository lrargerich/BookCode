from __future__ import division
import csv
import re
import math
from pprint import *

# Number of max documents to process
max_rows = 20000
# Words with global frequency higher than this are considered stop-words
theshold_max = 200;
# Words with global frequency lower than this are discarded
theshold_min = 3;

dic={}
stops = {}
gfreq = {}
docwords = []

rows = []
cols = []
values = []
sentiments = []


f = open('reviews.tsv', 'rb')
reader=csv.reader(f,delimiter='\t')

rownum = 1

for row in reader:
	docwords = []
	sentiment = row[1]
   	text = row[2]
	text_words = re.findall("[A-Z]{2,}(?![a-z])|[A-Z][a-z]+(?=[A-Z])|[\w\-]+",text)
	for word in text_words:
		if not word in stops:
			stops[word]=1
		else:
			stops[word]+=1

		if not word in docwords:
			# First time word appears
			docwords.append(word);
			if not word in gfreq:
				gfreq[word]=1
			else:
				gfreq[word]+=1
	rownum+=1
	if rownum>max_rows:
		break

total_rows = rownum

f = open('reviews.tsv', 'rb')
reader=csv.reader(f,delimiter='\t')

rownum = 1
counter = 0;

for row in reader:
	sentiment = row[1]
   	text = row[2]
	text_words = re.findall("[A-Z]{2,}(?![a-z])|[A-Z][a-z]+(?=[A-Z])|[\w\-]+",text)
	sentiments.append(sentiment)
	doc_dic = {}
	for word in text_words:
		if stops[word]<theshold_max and stops[word]>theshold_min:
			if not word in doc_dic:
				doc_dic[word]=1
			else:
				doc_dic[word]+=1

	# Now after processing all words in a doc we generate the results
	for doc_word in doc_dic:
		tf = 1 + math.log(doc_dic[doc_word])
		idf = math.log(total_rows/gfreq[doc_word])

		# Get the word Id (index)
		if not doc_word in dic:
			counter += 1
			dic[doc_word]=counter
			index = counter
		else:
			index = dic[doc_word]


		rows.append(rownum)
		cols.append(index)
		values.append(tf*idf)

	
	rownum+=1
	if rownum>max_rows:
		break


print "wdic={};"
for word in dic:
	i = dic[word]
	print "wdic("+str(i)+")=cellstr('"+word+"');"

print "sentiments=["
line = ""
for i in range(0,len(sentiments)):
	line = line + str(sentiments[i]) + " "
print line	
print "];"


print "rows=["
line = ""
for i in range(0,len(rows)):
	line = line + str(rows[i]) + " "
print line	
print "];"

print "cols=["
line = ""
for i in range(0,len(cols)):
	line = line + str(cols[i]) + " "
print line	
print "];"

print "values=["
line = ""
for i in range(0,len(values)):
	line = line + str(values[i]) + " "
print line	
print "];"

print "s=sparse(rows,cols,values);"
       	