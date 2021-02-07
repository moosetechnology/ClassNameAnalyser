Class {
	#name : #NameTokenizerTest,
	#superclass : #TestCase,
	#instVars : [
		'tokenizer'
	],
	#category : #'CNBFeatureSelector-Tests'
}

{ #category : #running }
NameTokenizerTest >> setUp [ 
	tokenizer := DMNameTokenizer new.
]

{ #category : #tests }
NameTokenizerTest >> testTokenize [

	self assert: (tokenizer tokenize: 'DMClassNameBlueprint34') equals: #('DM' 'Class' 	'Name' 'Blueprint34') asOrderedCollection 
]
