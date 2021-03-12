Class {
	#name : #CNBBothTokensStrategy,
	#superclass : #Object,
	#instVars : [
		'packageOrganizer'
	],
	#category : #CNBModels
}

{ #category : #building }
CNBBothTokensStrategy class >> build: aViewModel [

	^ self new
			build: aViewModel 
]

{ #category : #building }
CNBBothTokensStrategy >> build: aViewModel [

	| suffixViewModel prefixViewModel newModel |
	(CNBTokenStrategy build: aViewModel withSuffix).
	suffixViewModel := aViewModel.
	 
	newModel := (CNBViewModel new model: suffixViewModel model) withPrefix.
	(CNBTokenStrategy build: newModel).
	prefixViewModel := newModel.

	^ self organize: suffixViewModel accordingTo: prefixViewModel 
]

{ #category : #initialization }
CNBBothTokensStrategy >> initialize [ 
	super initialize.
	packageOrganizer := CNBPackageViewModelOragnizer new.
]

{ #category : #'as yet unclassified' }
CNBBothTokensStrategy >> organize: aCollectionOfPackages [

	aCollectionOfPackages do: [ :each | packageOrganizer do: each ]
]

{ #category : #'as yet unclassified' }
CNBBothTokensStrategy >> organize: aSuffixViewModel accordingTo: aPrefixViewModel [ 
	| scatteredSuffixPackages siblingPackages scatteredPackagesNames |
	
	scatteredSuffixPackages := aSuffixViewModel scatteredPackages.
	scatteredPackagesNames := (scatteredSuffixPackages collect: #name).
	
	siblingPackages 
		:= aPrefixViewModel 
				packageViewModels 
					select: [ :each | (scatteredPackagesNames includes: each name) ].
	
	scatteredSuffixPackages 
		do: [ :aPackage | | itsSibling |
					itsSibling 
						:= siblingPackages detect: [ :each | each name = aPackage name].
						
		packageOrganizer organize: aPackage accordingTo: itsSibling
		 ].
	
]
