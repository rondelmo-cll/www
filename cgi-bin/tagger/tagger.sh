#!/usr/bin/env python
# -*- coding: utf-8 -*-

from sys import argv
import nltk
from cPickle import load
input = open('brill_tagger_veneto.pkl','rb')
tagger = load(input)
input.close()
raw = argv[1].decode('UTF-8')
tokens = nltk.wordpunct_tokenize(raw)
print tagger.tag(tokens)

