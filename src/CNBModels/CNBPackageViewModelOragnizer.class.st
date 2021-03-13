Class {
	#name : #CNBPackageViewModelOragnizer,
	#superclass : #Object,
	#instVars : [
		'package'
	],
	#category : #CNBModels
}

{ #category : #'instance creation' }
CNBPackageViewModelOragnizer class >> of: aPackageModel [
	^ self new
		package: aPackageModel 
]

{ #category : #'as yet unclassified' }
CNBPackageViewModelOragnizer >> organize: aPackage accordingTo: anOtherPackage [ 

	| scatteredRoots |
	scatteredRoots := aPackage scatteredRoots.
	
	scatteredRoots do: [ :aRoot | | otherPackageTokens commonToken |
		otherPackageTokens := (anOtherPackage tokensOf: aRoot name).
		(((aPackage tokensOf: aRoot name) size > otherPackageTokens size)
			and: [ (otherPackageTokens anySatisfy: [ :aToken | aToken hasNoOutsiders ])
				  
				and: [ 
						commonToken := otherPackageTokens detectMax: [ :aToken | aToken size ].
						(aRoot dominantTokens keys
							includes: commonToken name )
								and: [	 commonToken hasNoOutsiders ]
							].
						 ]) ifTrue: [ 
				
				aPackage replaceTokensOf: aRoot with: otherPackageTokens. 							
				 ] 	
		 ].
	
]
