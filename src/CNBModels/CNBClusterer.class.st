"
I am responsible for clustering the packages and provoquing the both token strategy.
"
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

	(classes sorted: [ :each :word | each name > word name ] ) do: [ :aClass | | classTokens winner |
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

	| firstTokenOuccurences secondTokenOccurences siblingsInFirstToken siblingsInSecondToken tokenNames |
	
	firstTokenOuccurences := aClass root occurrencesOf: classTokens first name.
	siblingsInFirstToken := aClass siblingsIn: classTokens first.
	secondTokenOccurences := aClass root occurrencesOf: classTokens second name.
	siblingsInSecondToken := aClass siblingsIn: classTokens second.
	tokenNames := classTokens collect: #name.
	
	(firstTokenOuccurences = secondTokenOccurences)
		ifTrue: [ 
			(siblingsInFirstToken size > siblingsInSecondToken size)
			ifTrue: [ ^ classTokens first ] 
			ifFalse: [ ^ classTokens second ]
			 ]
		ifFalse: [  ^ classTokens detect: [ :aToken | 
				aToken name = 
				((aClass root tokensDictionary associations
				select: [ :each | tokenNames
					includes: each key ]) asDictionary detectMaxAssociation key) ]
			]
		
]

{ #category : #'as yet unclassified' }
CNBClusterer >> selectWinnerOf: aClass outOf: classTokens
selectWinnerOf: aClass outOf: classTokens [

	| firstTokenOuccurences secondTokenOccurences siblingsInFirstToken siblingsInSecondToken tokenNames |
	
	firstTokenOuccurences := aClass root occurrencesOf: classTokens first name.
	siblingsInFirstToken := aClass siblingsIn: classTokens first.
	secondTokenOccurences := aClass root occurrencesOf: classTokens second name.
	siblingsInSecondToken := aClass siblingsIn: classTokens second.
	tokenNames := classTokens collect: #name.
	
	(firstTokenOuccurences = secondTokenOccurences)
		ifTrue: [ 
			(siblingsInFirstToken size > siblingsInSecondToken size)
			ifTrue: [ ^ classTokens first ] 
			ifFalse: [ ^ classTokens second ]
			 ]
		ifFalse: [  ^ classTokens detect: [ :aToken | 
				aToken name = 
				((aClass root tokensDictionary associations
				select: [ :each | tokenNames
					includes: each key ]) asDictionary detectMaxAssociation key) ]
			]
		
]
