Class {
	#name : #TokenStemmerTest,
	#superclass : #TestCase,
	#instVars : [
		'tokenStemmer'
	],
	#category : #'CNBFeatureSelector-Tests'
}

{ #category : #running }
TokenStemmerTest >> setUp [ 
	tokenStemmer := DMTokenStemmer new.
]

{ #category : #tests }
TokenStemmerTest >> testStemAlphaDigits [
	"Stems in case: AlphaNumeric and Alpha Numeric it shouldn't care about 
	how the tokens should be but 	only do stemming to each token by using the MalPorterStemmer"
		
	self assert: (tokenStemmer stemToken: '34Class') equals: '34class'.
	self assert: (tokenStemmer stemToken: 'Class34') equals: 'class34'.
	self assert: (tokenStemmer stemTokens: {'56' . 'Class'} ) asArray equals: #('56' 'class').
]

{ #category : #tests }
TokenStemmerTest >> testStemAlphas [

	self assert: (tokenStemmer stemToken: 'Building') equals: 'build'.
	self assert: (tokenStemmer stemTokens: {'Building' . 'Blueprint' . 'Distribution' . 'Models'}) 	asArray equals: #('build' 'blueprint' 'distribut' 'model').
]

{ #category : #tests }
TokenStemmerTest >> testStemAlphasAndSpecialChars [

	self assert: (tokenStemmer stemToken: 'Building%') equals: 'building%'.
	self assert: (tokenStemmer stemTokens: {'Building%' . '?Blueprint' . 'Distribution' . 'Models'}) 	asArray equals: #('building%' '?blueprint' 'distribut' 'model').
]

{ #category : #tests }
TokenStemmerTest >> testStemAlphasDigitsAndSpecialChars [

	self assert: (tokenStemmer stemToken: 'Building34%') equals: 'building34%'.
	self assert: (tokenStemmer stemTokens: {'34Building' . '?Blueprint' . '(Distribution' . 'Models'}) 	asArray equals: #('34build' '?blueprint' '(distribut' 'model').
]

{ #category : #tests }
TokenStemmerTest >> testStemDigits [

	self assert: (tokenStemmer stemToken: '34') equals: '34'.
	self assert: (tokenStemmer stemToken: '34.45') equals: '34.45'.
	self assert: (tokenStemmer stemToken: '34,45') equals: '34,45'.


]

{ #category : #tests }
TokenStemmerTest >> testStemStem [

	self assert: (tokenStemmer stemToken: 'provid') equals: 'provid'.
	self assert: (tokenStemmer stemToken: 'symbol') equals: 'symbol'.
	self assert: (tokenStemmer stemToken: 'build') equals: 'build'.


]

{ #category : #tests }
TokenStemmerTest >> testStemToken [

	self assert: (tokenStemmer stemToken: 'provider') equals: 'provid'.
	self assert: (tokenStemmer stemToken: 'providing') equals: 'provid'.
	self assert: (tokenStemmer stemToken: 'provid') equals: 'provid'.
	self assert: (tokenStemmer stemToken: 'symbols') equals: 'symbol'.
	self assert: (tokenStemmer stemToken: 'symbol') equals: 'symbol'.
	self assert: (tokenStemmer stemToken: 'building') equals: 'build'.
	self assert: (tokenStemmer stemToken: 'buildings') equals: 'build'.
	self assert: (tokenStemmer stemToken: 'build') equals: 'build'.
	self assert: (tokenStemmer stemToken: 'filterer') equals: 'filter'.

]

{ #category : #tests }
TokenStemmerTest >> testStemTokens [

	self assert: (tokenStemmer stemTokens: {'class' . 'name' . 'provider' }) equals: { 'class' . 'name' . 	'provid' }

]

{ #category : #tests }
TokenStemmerTest >> testStemTokensAlphaAndDigits [

	self assert: (tokenStemmer stemTokens: {'class' . 'name' . '34' }) equals: { 'class' . 'name' . '34'}

]

{ #category : #tests }
TokenStemmerTest >> testStemTokensDigits [

	self assert: (tokenStemmer stemTokens: {'12' . '34' . '56' }) equals: { '12' . '34' . '56' }

]

{ #category : #tests }
TokenStemmerTest >> testStemTokensSpecialChars [
	
	self assert: (tokenStemmer stemTokens: { '%' . '/%.' } )  equals: { '%' . '/%.' }

]
