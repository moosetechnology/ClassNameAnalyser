Class {
	#name : #NameTokenizerTest,
	#superclass : #TestCase,
	#instVars : [
		'tokenizer'
	],
	#category : #'DMFeatureSelector-Tests'
}

{ #category : #running }
NameTokenizerTest >> setUp [ 
	tokenizer := DMNameTokenizer new.
]

{ #category : #tests }
NameTokenizerTest >> testCheckCapitalLetter [

	self assert: (tokenizer checkCapitalLetter: $c ) equals: false.
	self assert: (tokenizer checkCapitalLetter: ('ClassName' at: 1 )) equals: true
]

{ #category : #tests }
NameTokenizerTest >> testCheckSpecialChar [

	self assert: (tokenizer checkSpecialChar: '%') equals: true.
]

{ #category : #tests }
NameTokenizerTest >> testCutWhereCamelCase [

	self assert: (tokenizer cutWhereCamelCase: 'DMClassNameBlueprint') asArray equals: #('DM' 'Class' 	'Name' 'Blueprint').
]

{ #category : #tests }
NameTokenizerTest >> testCutWhereCamelCaseFromAlphaNumeric [

	self assert: (tokenizer cutWhereCamelCase: '12ClassNameBlueprint34') asArray equals: #('12' 'Class' 	'Name' 'Blueprint34').
]

{ #category : #tests }
NameTokenizerTest >> testCutWhereCamelCaseFromAlphaNumericAndSpecialChars [

	self assert: (tokenizer cutWhereCamelCase: '12ClassNameBlueprint34%') asArray equals: #('12' 'Class' 	'Name' 'Blueprint34%' ).
	self assert: (tokenizer cutWhereCamelCase: '12ClassNameB!lueprint34%') asArray equals: #('12' 'Class' 	'Name' 'B!lueprint34%' ).
]

{ #category : #tests }
NameTokenizerTest >> testCutWhereCamelCaseFromNumeric [

	self assert: (tokenizer cutWhereCamelCase: '1234') asArray equals: #('1234').
]
