import nltk
from nltk.corpus import stopwords
import loader
import xml.etree.cElementTree as ET
import codecs
from nltk.corpus import wordnet as wn
from nltk.wsd import lesk
import nltk
from nltk.probability import *




def baseline(instances, keys):
	sum=0
	count=len(instances)
	for entry in instances:
		x=[]
		word=instances[entry].lemma.decode("utf-8")
		m=wn.synsets(word)[0].lemmas()
		for item in m:
			x.append((item.key()))
		for key in keys[entry]:
			if key in x:
				sum+=1
	baseline_accuracy = float(sum)/count
	print (" Baseline accuracy: " + str(baseline_accuracy*100)+"%")

def remove_stopwords(instances):
	for item in instances.values():
		for word in item.context:
			if word in stopwords.words('english'):
				item.context.remove(word)
	
	
def test_lesk1(instances, keys):
	sum=0
	count=len(instances)
	remove_stopwords(instances)
	
	for entry in instances:
		x=[]
		result=(lesk(instances[entry].context, instances[entry].lemma.decode("utf-8"))).lemmas()
		for item in result:
			x.append(item.key())
		for key in keys[entry]:
			if key in x:
				sum+=1
	lesk_accuracy = float(sum)/count
	print ("Lesk accuracy: " + str(lesk_accuracy*100) +"%")

def test_lesk2(instances, keys):
	sum=0
	count=len(instances)
	remove_stopwords(instances)
	
	for entry in instances:
		x=[]
		results=(lesk2(instances[entry].context, instances[entry].lemma.decode("utf-8")))
		result=results.lemmas()
		for item in result:
			#print item.key()
			x.append(item.key())
		for key in keys[entry]:
			if key in x:
				sum+=1
	lesk_accuracy = float(sum)/count
	print ("Lesk2 accuracy: " + str(lesk_accuracy*100) +"%")
	

def test_lesk3(instances, keys):
	sum=0
	count=len(instances)
	remove_stopwords(instances)
	data=[]
	for entry in instances:
		sense =(lesk(instances[entry].context, instances[entry].lemma.decode("utf-8")))
		data.append(sense)                                  #fist use lesk algorithm
		
	
	
	for entry in instances:
		synsets = wn.synsets(instances[entry].lemma.decode("utf-8"))
		fd = nltk.FreqDist(synsets)
		for synset in synsets:
			f=frequent(synset, data)
			for element in fd:
				fd[element]=fd[element]+f
		sense_mle = MLEProbDist(fd).max()      	#find MLE max sense
		#sense_mle = sense_mle.lemmas()
		
		
		overlap = {}
		cont = set()
		context = set(instances[entry].context)
		for word in context:
			word = word.decode("utf-8")
			cont.add(word)   #convert bytes to strings
		
		for sense in synsets:	
			overlap[sense] = len(cont.intersection(sense.definition().strip().split())) 
		i= 2
		overlap[sense_mle] = overlap[sense_mle] + i
		_, sense = max((overlap[sense], sense) for sense in synsets)
		sense = sense.lemmas()
		x=[]
		for item in sense:
			#print( item.key())
			x.append(item.key())
		for key in keys[entry]:
			#print(key)
			if key in x:
				sum+=1
	lesk_accuracy = float(sum)/count
	print ("Lesk3 accuracy: " + str(lesk_accuracy*100) +"%")
	
	
	
def lesk2(context_sentence, ambiguous_word):
	context = set(context_sentence)
	synsets = wn.synsets(ambiguous_word)
	if not synsets:
		return None
	overlap = {}
	cont = set()  
	for word in context:
		word = word.decode("utf-8")
		cont.add(word)   #convert bytes to strings
	i = len(synsets)
	for sense in synsets:	
		overlap[sense] = len(cont.intersection(sense.definition().strip().split())) + i
		i = i-1
		
	_, sense = max((overlap[sense], sense) for sense in synsets)
	return sense
	
	
	
def frequent(synset, data):
		if synset in data:
			return data.count(synset)
		else:
			return 0
			
			

data_f = 'multilingual-all-words.en.xml'
key_f = 'wordnet.en.key'
dev_instances, test_instances = loader.load_instances(data_f)
dev_key, test_key = loader.load_key(key_f)
    
# IMPORTANT: keys contain fewer entries than the instances; need to remove them
dev_instances = {k:v for (k,v) in dev_instances.items() if k in dev_key}
test_instances = {k:v for (k,v) in test_instances.items() if k in test_key}
baseline(test_instances, test_key)
test_lesk1(test_instances, test_key)
test_lesk2(test_instances, test_key)
test_lesk3(test_instances, test_key)