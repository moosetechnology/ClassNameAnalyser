Class {
	#name : #DMCNBDescriptionModel,
	#superclass : #DMViewModel,
	#instVars : [
		'nbrClasses',
		'nbrMonoSuffix',
		'nbrMonoClasses',
		'nbrMultiSuffix',
		'nbrIntruders',
		'nbrRoots',
		'nbrSuffixes',
		'averageClassesPerSuffix',
		'homogeneous',
		'snowFlakes'
	],
	#category : #DMModels
}

{ #category : #counting }
DMCNBDescriptionModel >> allConceptViewModels [
	^self packageViewModels flatCollect: #suffixViewModels
]

{ #category : #accessing }
DMCNBDescriptionModel >> averageClassesPerSuffix [
	^averageClassesPerSuffix
]

{ #category : #counting }
DMCNBDescriptionModel >> countAverageClassesPerSuffix [
	
	averageClassesPerSuffix := (self allConceptViewModels collect: [ :each | each classViewModels size ]) average asFloat.
	^averageClassesPerSuffix 
]

{ #category : #counting }
DMCNBDescriptionModel >> countConcepts [
	nbrSuffixes := (self allClassModels collect: [:each | each concept]) asSet size
]

{ #category : #counting }
DMCNBDescriptionModel >> countHomogeneous [
	"first select the concepts dominated by a mono hierarchy, then check if all inner classes belong to mono suffix hierarchies"
	| conceptViewModelsDominatedByMonoHierarchy |
	conceptViewModelsDominatedByMonoHierarchy := self allConceptViewModels 
					select: [ :each | each root isMonoSuffix ].
	homogeneous := (conceptViewModelsDominatedByMonoHierarchy 
							select: [ :each | 
								each classViewModels allSatisfy: [ :aCVM | aCVM root isMonoSuffix ] 
													]
		 					) size
]

{ #category : #counting }
DMCNBDescriptionModel >> countIntruders [ 
	 nbrIntruders:= (DMBuilder countIntrudersIn: self)
]

{ #category : #counting }
DMCNBDescriptionModel >> countMonoClasses [

	nbrMonoClasses := (self rootModels select: [ :each | each isMonoClass ]) size
]

{ #category : #counting }
DMCNBDescriptionModel >> countMonoSuffixHierarchies [
	nbrMonoSuffix := (self rootModels select: [ :each | each isMonoSuffix ] ) size
]

{ #category : #counting }
DMCNBDescriptionModel >> countNumberOfClasses [
	nbrClasses := self allClassModels size
]

{ #category : #counting }
DMCNBDescriptionModel >> countRootModels [
	| roots |
	roots := self rootModels copy removeAllSuchThat: [ :each | each isMonoClass ].
	nbrRoots := roots size
]

{ #category : #counting }
DMCNBDescriptionModel >> countSnowFlakes [
	snowFlakes := (self allConceptViewModels select: [ :each | each root isMonoClass ]) size.
	
]

{ #category : #counting }
DMCNBDescriptionModel >> countnMultiSuffixHierarchies [
	nbrMultiSuffix := (self rootModels select: [ :each | each isMultiSuffix ] ) size
]

{ #category : #operations }
DMCNBDescriptionModel >> create [
	self countIntruders.
	self countNumberOfClasses.
	self countMonoClasses.
	self countMonoSuffixHierarchies.
	self countRootModels.
	self countnMultiSuffixHierarchies.
	self countConcepts.
	self countAverageClassesPerSuffix.
	"self countBiggestClassDepth."
	self countSnowFlakes.
	"self countConfetti."
	self countHomogeneous.
	"self countBigBlob."
	
	
	
	
]

{ #category : #accessing }
DMCNBDescriptionModel >> homogeneous [
	^homogeneous 
]

{ #category : #accessing }
DMCNBDescriptionModel >> nbrClasses [ 
	^nbrClasses 
]

{ #category : #accessing }
DMCNBDescriptionModel >> nbrClasses: aNumber [
	nbrClasses := aNumber 
]

{ #category : #accessing }
DMCNBDescriptionModel >> nbrIntruders [
	^nbrIntruders
]

{ #category : #accessing }
DMCNBDescriptionModel >> nbrMonoClasses [
	^nbrMonoClasses
]

{ #category : #accessing }
DMCNBDescriptionModel >> nbrMonoClasses: aNumber [
	nbrMonoClasses:= aNumber
]

{ #category : #accessing }
DMCNBDescriptionModel >> nbrMonoSuffix [
	^nbrMonoSuffix
]

{ #category : #accessing }
DMCNBDescriptionModel >> nbrMonoSuffix: aNumber [
	nbrMonoSuffix := aNumber
]

{ #category : #accessing }
DMCNBDescriptionModel >> nbrMultiSuffix [
	^nbrMultiSuffix
]

{ #category : #accessing }
DMCNBDescriptionModel >> nbrMultiSuffix: aNumber [
	nbrMultiSuffix := aNumber
]

{ #category : #accessing }
DMCNBDescriptionModel >> nbrRoots [
	^nbrRoots
]

{ #category : #accessing }
DMCNBDescriptionModel >> nbrRoots: aNumber [ 
	nbrRoots := aNumber
]

{ #category : #accessing }
DMCNBDescriptionModel >> nbrSuffixes [
	^nbrSuffixes
]

{ #category : #accessing }
DMCNBDescriptionModel >> nbrSuffixes: aNumber [
	nbrSuffixes := aNumber
]

{ #category : #accessing }
DMCNBDescriptionModel >> snowFlakes [
	^snowFlakes
]
