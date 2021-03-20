Class {
	#name : #CNBClusterer,
	#superclass : #Object,
	#category : #CNBModels
}

{ #category : #'as yet unclassified' }
CNBClusterer >> organize: aPackage [

	| classes tokens |
	tokens := aPackage tokens sorted: #size descending. 
	classes := (tokens flatCollect: #classViewModels).

	classes do: [ :aClass | | classTokens winner |
		classTokens 
			:= tokens select: [ :token | token classNames includes: aClass name ].

		classTokens	
			hasMoreThanOneElement ifTrue: [ 
		winner :=	 self selectWinnerOf: aClass outOf: classTokens.	
		
		self remove: aClass from: (classTokens difference: { winner }).		
						 ]
				 ].
			
	^ aPackage reset.
]

{ #category : #initialization }
CNBClusterer >> remove: aClass from: tokens [

	tokens 
		do: [ :aToken | 
			
			aToken classViewModels removeAllSuchThat: [ :each | each model model = aClass model model ].
			
			aClass root reduceToken: aToken name.

			 ].
		
]

{ #category : #'as yet unclassified' }
CNBClusterer >> selectWinnerOf: aClass outOf: classTokens [

	| potentialWinner otherPotentialWinners potentialWinnersNames classRoot winningTokenName one two |
	potentialWinner 
		:= classTokens detectMax: [ :each | (aClass siblingsIn: each) size ].
		
		" siblings"
	otherPotentialWinners 
		:= (classTokens difference: { potentialWinner }) asSet select: [ :each | 
			one := (aClass siblingsIn: each) .
			two := (aClass siblingsIn: potentialWinner).
			one size = two size  ].
		
		"same size of siblings"
	
	otherPotentialWinners 
		ifNotEmpty: 
		[ 	
			classRoot := aClass root. 
			otherPotentialWinners add: potentialWinner.
			
			potentialWinnersNames := (classRoot tokensDictionary associations 
						select: [ :each | ((otherPotentialWinners collect: #name) includes: each key) ]).
			
			winningTokenName  
				:= (potentialWinnersNames
						detectMax: [ :each | each value ]) key.
			
			^ classTokens detect: [ :each | each name = winningTokenName ] 
		].
	^ potentialWinner
]
