from sklearn.feature_extraction.text import CountVectorizer
import numpy as np
from sklearn.linear_model import LogisticRegression
from sklearn.feature_extraction import DictVectorizer
from sklearn.naive_bayes import GaussianNB
from sklearn.svm import SVC
from sklearn.feature_selection import VarianceThreshold
from sklearn.metrics import confusion_matrix

def SvmClass(x_train, y_train):	
	clf = SVC(kernel='linear')	
	clf.fit(x_train, y_train)
	return clf 

def LogisticClass(x_train, y_train):	
	clf = LogisticRegression(penalty='l2')	
	clf.fit(x_train, y_train)	
	return clf	

def GaussianNBClass(x_train, y_train):
	clf = GaussianNB()	
	clf.fit(x_train, y_train)	
	return clf	
	
def DataManager(direct, fname):

	with open("%s/rt-polarity.%s"%(direct, fname),"rb") as f:
		sentences = f.readlines()
			
	data_features = []
	label = []
	for sentence in sentences:
		data_features.append(sentence.decode('utf8','ignore'))
		label.append(fname)
	return(data_features,label)

if __name__ == '__main__':
	directory = 'D:/work/Mcgill/comp550/a1/rt-polaritydata'		
	f_pos = 'pos'
	f_neg = 'neg'
	
	feats_pos, label_pos = DataManager(directory, f_pos)
	feats_neg, label_neg = DataManager(directory, f_neg)	
	cutoff_pos = int(len(feats_pos)*3/4)
	cutoff_neg = int(len(feats_neg)*3/4)
	feats_train = feats_pos[:cutoff_pos] + feats_neg[:cutoff_neg]
	label_train = label_pos[:cutoff_pos] + label_neg[:cutoff_neg]
	feats_test = feats_pos[cutoff_pos:] + feats_neg[cutoff_neg:]
	label_test = label_pos[cutoff_pos:] + label_neg[cutoff_neg:]
	
	vec = CountVectorizer(max_df = 2500 )
	bigram_vec = CountVectorizer(ngram_range=(1, 2))

	feats_matrix_train = vec.fit_transform(feats_train).toarray()
	feats_matrix_test = vec.transform(feats_test).toarray() 

	print("Logistic Regression:")
	clf = LogisticClass(feats_matrix_train, label_train)
	acc = clf.score(feats_matrix_test, label_test)
	label_pred = clf.predict(feats_matrix_test)
	print(confusion_matrix(label_test, label_pred))
	
	print(acc)
	print("GaussianNBClass:")
	clf = GaussianNBClass(feats_matrix_train, label_train)
	acc = clf.score(feats_matrix_test, label_test)
	print(acc)
	
	# print("SVM:")
	# clf = SvmClass(feats_matrix_train, label_train)
	# acc = clf.score(feats_matrix_test, label_test)
	# print(acc)
	
	
	
	