Class {
	#name : #CNBNameTokenizerTest,
	#superclass : #TestCase,
	#instVars : [
		'tokenizer'
	],
	#category : #'CNBFeatureSelector-Tests'
}

{ #category : #running }
CNBNameTokenizerTest >> setUp [ 
	tokenizer := CNBNameTokenizer new.
]

{ #category : #tests }
CNBNameTokenizerTest >> testTokenize [

	self assert: (tokenizer tokenize: 'DMClassNameBlueprint34') equals: #('DM' 'Class' 	'Name' 'Blueprint34') asOrderedCollection 
]
