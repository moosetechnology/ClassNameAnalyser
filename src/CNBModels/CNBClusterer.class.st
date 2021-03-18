Class {
	#name : #CNBClusterer,
	#superclass : #Object,
	#category : #CNBModels
}

{ #category : #'as yet unclassified' }
CNBClusterer >> organize: aPackage property: aSelector [ 

	| classes tokens |
	classes := aPackage classes.
	tokens := aPackage tokens.
	
	classes do: [ :aClass | | classTokens winner |
		classTokens 
			:= tokens select: [ :aToken | aToken classNames includes: aClass name ].
		 
		classTokens	
			hasMoreThanOneElement ifTrue: [ 
		winner :=	 self selectWinnerOf: aClass outOf: classTokens.			
		self remove: aClass from: (classTokens difference: { winner }).		
						 ]
				 ].
	^ aPackage removeEmptyTokens.
]

{ #category : #initialization }
CNBClusterer >> remove: aClass from: tokens [

	tokens 
		do: [ :aToken | aToken 
			classViewModels removeAllSuchThat: [ :each | each name = aClass name ].
			aClass root reduceToken: aToken name ].
		
	self resetTokens: tokens
]

{ #category : #initialization }
CNBClusterer >> resetTokens: tokens [

	tokens 
		do: [ :each | 
				each size: each size - 1 ].	
	
	
]

{ #category : #'as yet unclassified' }
CNBClusterer >> selectWinnerOf: aClass outOf: classTokens [

	| potentialWinner otherPotentialWinners potentialWinnersNames classRoot winningTokenName |
	potentialWinner 
		:= classTokens detectMax: [ :each | (aClass siblingsIn: each) size ].
		
		" siblings"
	otherPotentialWinners 
		:= (classTokens difference: { potentialWinner }) select: [ :each | 
			(aClass siblingsIn: each) size = (aClass siblingsIn: potentialWinner) size ].
		
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

{ #category : #'private - backend access' }
CNBClusterer >> sibling [ 
]
