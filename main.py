import glob2
import nltk
import string
import scipy
from collections import Counter
from nltk.corpus import stopwords
from nltk.stem.porter import *
from sklearn.metrics.pairwise import cosine_similarity, linear_kernel
from sklearn.feature_extraction.text import CountVectorizer
import numpy as np  # a conventional alias
import sklearn.feature_extraction.text as text
import gensim
from gensim import corpora
from nltk.corpus import stopwords
from nltk.stem.wordnet import WordNetLemmatizer
import string
import re
import dateparser
from name_entity import *
stop = set(stopwords.words('english'))
exclude = set(string.punctuation)
lemma = WordNetLemmatizer()


def clean(doc):
    stop_free = " ".join([i for i in doc.lower().split() if i not in stop])
    punc_free = ''.join(ch for ch in stop_free if ch not in exclude)
    normalized = " ".join(lemma.lemmatize(word) for word in punc_free.split())
    return normalized


def main():
    for folder_name in glob2.glob("DentonDD2/20*/"):
        folder_items = glob2.glob("%s*.txt" % folder_name)
        print folder_name, ":", len(folder_items)
        doc_complete = []
        for index, filename in enumerate(glob2.glob("%s*.txt" % folder_name)):
            if(not re.findall("(stopword|xfiles)", filename)):
                doc_complete.append(open(filename).read())
        doc_clean = [filter(lambda x: len(x) > 2, clean(doc.decode("ascii", "ignore")).split())
                     for doc in doc_complete]
        dictionary = corpora.Dictionary(doc_clean)
        doc_term_matrix = [dictionary.doc2bow(doc) for doc in doc_clean]
        Lda = gensim.models.ldamodel.LdaModel
        ldamodel = Lda(doc_term_matrix, num_topics=4,
                       id2word=dictionary, passes=1)
        topics =  ldamodel.print_topics()
        for index, doc in enumerate(doc_clean):
            topic_max =  None
            topic_value = 0
            for topic in topics:
                sum_of_terms = 0
                col = Counter(doc)
                for word in re.findall("\"(\w+)\"", topic[1]):
                    if(word in col):
                        sum_of_terms+=col[word]
                if(sum_of_terms >= topic_value):
                    topic_value =sum_of_terms
                    topic_max = topic
            print topic_max
            sentences = nltk.sent_tokenize(doc_complete[index].decode("ascii", "ignore"))
            regex = "|".join([word for word in re.findall("\"(\w+)\"", topic_max[1])])
            important_sentences = [sentence for sentence in sentences if re.findall(regex,sentence) ]
            print len(important_sentences)
            name_entities = set()
            date_time = set()
            for sentence in  important_sentences:
                name_entities.update(get_name_entities(sentence))
                date_time.add(dateparser.parse(sentence))


if __name__ == "__main__":
    main()
