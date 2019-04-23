Extension { #name : #String }

{ #category : #'*DMFeatureSelector' }
String >> piecesCutWhereNonAlphaNumeric [

	| word nonAlphaNumericIndexes tokenizer pieces|
	tokenizer := DMNameTokenizer new.
	nonAlphaNumericIndexes := OrderedCollection new.
	pieces := OrderedCollection new.
	word := self deepCopy.
	(word isEmptyOrNil)
	ifFalse: [  
	(1 to: word size) do: [ :index | ((word at: index) asString isAllAlphaNumerics not)
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
