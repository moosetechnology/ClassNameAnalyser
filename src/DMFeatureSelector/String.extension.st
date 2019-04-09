Extension { #name : #String }

{ #category : #'*DMFeatureSelector' }
String >> cutWhereCamelCase [

	| word tokenizer token allTokens resultedTokens|
	word := self deepCopy.
	token := ''.
	tokenizer := DMNameTokenizer new.
	allTokens := OrderedCollection new.
	resultedTokens := OrderedCollection new.
	1 to: word size do: [ :index | (tokenizer checkCapitalLetter: (word at: index)) 
		ifTrue: [ 
			allTokens add: token.
			token := (word at: index) asString.
			 ] 
		ifFalse: [ token := token , (word at: index) asString  ].
		(index == word size) 
		ifTrue: [ allTokens add: token ]
		].
	token := ''.
	allTokens do:  [ :each | (each size == 1)
		ifTrue: [ token := token , each asString ]
		ifFalse: [ resultedTokens add: token. 
			token := ''.
			resultedTokens add: each ]
		 ].
	resultedTokens add: token.
	^ resultedTokens reject: [ :each | each size ==0 ]

]

{ #category : #'*DMFeatureSelector' }
String >> piecesCutWhereNonAlphaNumeric [

	| word nonAlphaNumericIndexes tokenizer pieces|
	tokenizer := DMNameTokenizer new.
	nonAlphaNumericIndexes := OrderedCollection new.
	pieces := OrderedCollection new.
	word := self deepCopy.
	(word isEmptyOrNil)
	ifFalse: [  
	(1 to: word size) do: [ :index | (tokenizer checkSpecialChar: (word at: index) asString )
		ifTrue: [ nonAlphaNumericIndexes add: index ]
		] ].
	
		(nonAlphaNumericIndexes isEmptyOrNil)
	ifTrue: [ ^ self ]
	ifFalse: [  
	((nonAlphaNumericIndexes at: 1) == 1)
		ifTrue: [  
		1 to: nonAlphaNumericIndexes size do: [ :index | 
		pieces add: (word at: (nonAlphaNumericIndexes at: index)) asString .
			(index+1<=nonAlphaNumericIndexes size)
				ifTrue: [ pieces add: (word copyFrom: (nonAlphaNumericIndexes at: index)+1 to:  				(nonAlphaNumericIndexes at: index+1)-1 )].
		                                    ].
	(nonAlphaNumericIndexes last < word size )
	ifTrue: [ pieces add: (word copyFrom: ((nonAlphaNumericIndexes last) +1 ) to: (word size)) ]
	          ]

		ifFalse: [ 						
		pieces add: (word copyFrom: 1 to: (nonAlphaNumericIndexes at: 1)-1).	
		1 to: nonAlphaNumericIndexes size do: [ :index | 
		pieces add: (word at: (nonAlphaNumericIndexes at: index)) asString .
			(index+1<=nonAlphaNumericIndexes size)
				ifTrue: [ pieces add: (word copyFrom: (nonAlphaNumericIndexes at: index)+1 to:  				(nonAlphaNumericIndexes at: index+1)-1 )].
		                                    ].
		(nonAlphaNumericIndexes last < word size )
		ifTrue: [ pieces add: (word copyFrom: ((nonAlphaNumericIndexes last) +1 ) to: (word size)) ]
		]
	].

		^ pieces reject: [ :each | each size == 0 ]		.	

]
