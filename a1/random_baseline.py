
import random
def test_random(direct, fname1, fname2):
	with open('%s/rt-polarity-test.%s'%(direct,fname1),'rb') as f3:
		sentences_pos_test = f3.readlines()
	with open('%s/rt-polarity-test.%s'%(direct,fname2),'rb') as f4:
		sentences_neg_test = f4.readlines()
	accuracy = 0
	for sentence in sentences_pos_test:
		p = random.randint(0,1)
		if p == 1:
			accuracy = accuracy + 1
	
	for sentence in sentences_pos_test:
		p = random.randint(0,1)
		if p == 0:
			accuracy = accuracy + 1
	accuracy = accuracy / (len(sentences_pos_test) + len(sentences_neg_test))
	print('accuracy:',accuracy)

	
if __name__ == '__main__':
	directory = 'D:/work/Mcgill/comp550/a1/rt-polaritydata'		
	f_pos = 'pos'
	f_neg = 'neg'
	
	
	test_random(directory, f_pos, f_neg)
