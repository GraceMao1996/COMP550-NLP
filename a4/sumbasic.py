import re
import sys
import random
from nltk.tokenize import sent_tokenize, word_tokenize
from nltk.stem import WordNetLemmatizer
from nltk.corpus import stopwords


#main function
def main():
	method_name = sys.argv[1]
	file_n = list(sys.argv[2])
	
	doc_1=open(get_doc_name(file_n, 1), "r")
	doc_2=open(get_doc_name(file_n, 2), "r")
	doc_3=open(get_doc_name(file_n, 3), "r")
	f1 = doc_1.read()
	f2 = doc_2.read()
	f3 = doc_3.read()
	files = [f1,f2,f3]
	cluster = file_n[10]
	#print(cluster)
	summary_doc = open((method_name+"-"+ str(cluster) + ".txt"), 'w')   #summary_doc address
	print('> '+method_name+"-"+ str(cluster) + ".txt")
	if method_name == 'orig':
		orig(files, summary_doc)
	elif method_name == 'best-avg':
		best_avg(files, summary_doc)
	elif method_name == 'simplified':
		simplified(files, summary_doc)
	elif method_name == 'leading':
		leading(files, summary_doc)
	else:
		print("wrong method name, please enter again!")
	

			
#replace the star with number to get the doc name		
def get_doc_name(file_n,n):  
	file_n[12]=str(n)
	doc_n="".join(file_n)
	return doc_n	

def orig(files, summary_doc):
	data = []
	for file in files:
		data.extend(preprocess(file))    #preprocess file to create clean sentence, and reserve the original sentence
	word_probs = gen_word_prob(data)
	sent_probs = gen_sent_prob(data,word_probs)
	count = 0
	while (count<100):
		sorted_words = sorted(word_probs.items(), key=lambda x: x[1], reverse=False) 
		highest_prob_word = sorted_words[-1][0]  #in every iteration, find the highest_prob_word
		print(highest_prob_word)
		for twin in data:
			if highest_prob_word not in twin[1]:
				sent_probs[twin[0]] = 0           #pick the best scoring sentence that contains the highest probability word.
		sorted_sents = sorted(sent_probs.items(), key=lambda x: x[1], reverse=False)   #sort the sentence to find the highest prob one
		string = sorted_sents[-1][0]
		selected_sent = string.split()
		count = count + len(selected_sent)
		summary_doc.write(string+' ') 
		sent_probs, word_probs = update(data, string, word_probs)  #update sent_probs and word_probs
		
def simplified(files, summary_doc):  #holds the word scores constant and does not incorporate the non-redundancy update.
	data = []
	for file in files:
		data.extend(preprocess(file))    #preprocess file to create clean sentence, and reserve the original sentence
	word_probs = gen_word_prob(data)
	sent_probs = gen_sent_prob(data,word_probs)
	sorted_sents = sorted(sent_probs.items(), key=lambda x: x[1], reverse=False)   #sort the sentence to find the highest prob one
	count = 0
	while (count<100):
		string = sorted_sents[-1][0]
		selected_sent = string.split()
		count = count + len(selected_sent)
		summary_doc.write(string+' ') 
		sorted_sents.pop()           #no update, to avoid choose the same sentence again and again, using pop
		

def leading(files, summary_doc):
	i = random.randint(0,2)   #select an article arbitrarily
	leading_file=files[i]
	clean_file=''.join(sentence for sentence in leading_file if ord(sentence)<128)
	count=0
	sents=sent_tokenize(clean_file)
	for sent in sents:
		selected_sent=sent.split(' ')
		if (count+len(selected_sent)<100):	
			summary_doc.write(sent+' ') 
			count+=len(selected_sent)
		else:
			break
		
def best_avg(files, summary_doc):
	data = []
	for file in files:
		data.extend(preprocess(file))    #preprocess file to create clean sentence, and reserve the original sentence
	word_probs = gen_word_prob(data)
	sent_probs = gen_sent_prob(data,word_probs)
	
	count = 0
	while (count<100):
		sorted_sents = sorted(sent_probs.items(), key=lambda x: x[1], reverse=False)   #sort the sentence to find the highest prob one, skip step 3
		string = sorted_sents[-1][0]
		selected_sent = sorted_sents[-1][0].split()
		count = count + len(selected_sent)
		summary_doc.write(string+' ') 
		sent_probs, word_probs = update(data, string, word_probs)
		
		

def preprocess(file):
	sentences=''.join(sentence for sentence in file if ord(sentence)<128)
	sents=sent_tokenize(sentences)
	data=[]
	for sentence in sents:
		clean_sentence=[]
		tokens=word_tokenize(sentence)
		regex = re.compile('[^a-zA-Z]')
		for word in tokens:
		#remove stopwords and grammar
			w=regex.sub('', word)
			if w.lower() not in stopwords.words('english'):
				clean_sentence.append(WordNetLemmatizer().lemmatize(w.lower()))
			else:
				continue
		data.append((sentence, clean_sentence))   #reserve original sentence and clean sentence 
	return data

def gen_word_prob(data):
	counts = {}
	word_probs = {}
	c = 0
	for twin in data:
		clean_sentence=twin[1]       #clean_sentence and twin[1] is a list
		for word in clean_sentence:
			c = c + 1
			if word in counts:
				counts[word]+=1
			else:
				counts[word]=1
	for entry in counts:
		word_probs[entry] = float(counts[entry]/c)
	
	return word_probs
	
def gen_sent_prob(data,word_probs):
	sent_probs={}
	for twin in data:
		sentence=twin[1]     #clean_sentence
		total=0
		for word in sentence:
			total+=word_probs[word]
		sent_probs[twin[0]]=total/len(sentence)        #twin[0] is a string
	return sent_probs
	
def update(data, string, word_probs):
	for twin in data:
		if twin[0]==string:			
			for word in twin[1]:      
				value=word_probs[word]
				word_probs[word]=value*value
	sent_probs=gen_sent_prob(data, word_probs)
	
	
	return sent_probs, word_probs


main()