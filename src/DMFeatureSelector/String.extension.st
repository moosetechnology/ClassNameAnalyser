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
String >> piecesCutWhereCamelCase [
	"Breaks apart words written in camel case.
	
	It's not simply using piecesCutWhere: because we want
	to also deal with abbreviations and thus we need to 
	decide based on three characters, not just on two:
	 ('FOOBar') piecesCutWhereCamelCase asArray = #('FOO' 'Bar').
	('FOOBar12AndSomething') piecesCutWhereCamelCase asArray = #('FOO' 'Bar' '12' 'And' 'Something')	
	"
	
	| start previous current next pieces |
	self isEmpty ifTrue: [^self].
	start := 1.
	pieces := OrderedCollection new.
	3 to: self size do: [ :index |
		previous := self at: index - 2.
		current := self at: index - 1.
		next := self at: index.
		((previous isLowercase and: [current isUppercase]) or: [
			(previous isUppercase and: [current isUppercase and: [next isLowercase ]]) or: [
				(previous isDigit not and: [current isDigit]) or: [
					previous isDigit and: [current isDigit not] 
		]]]) ifTrue: [
			pieces add: (self copyFrom: start to: index - 2).
			start := index - 1].
	].
	pieces addAll: ((self copyFrom: start to: self size) piecesCutWhere: [:a :b | 
		(a isDigit and: [b isDigit not]) or: [a isDigit not and: [b isDigit ]]]).
	^pieces
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
