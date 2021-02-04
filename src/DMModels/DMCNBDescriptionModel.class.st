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

{ #category : #'as yet unclassified' }
DMCNBDescriptionModel >> allConceptViewModels [
	^self packageViewModels flatCollect: #suffixViewModels
]

{ #category : #accessing }
DMCNBDescriptionModel >> averageClassesPerSuffix [
	^averageClassesPerSuffix
]

{ #category : #'as yet unclassified' }
DMCNBDescriptionModel >> countAverageClassesPerSuffix [
	
	averageClassesPerSuffix := (self allConceptViewModels collect: [ :each | each classViewModels size ]) average asFloat.
	^averageClassesPerSuffix 
]

{ #category : #'as yet unclassified' }
DMCNBDescriptionModel >> countConcepts [
	nbrSuffixes := (self allClassModels collect: #concept ) asSet size
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
DMCNBDescriptionModel >> countIntruders [ 
	 nbrIntruders:= (DMBuilder countIntrudersIn: self)
]

{ #category : #'as yet unclassified' }
DMCNBDescriptionModel >> countMonoClasses [

	nbrMonoClasses := (self rootModels select: [ :each | each isMonoClass ]) size
]

{ #category : #'as yet unclassified' }
DMCNBDescriptionModel >> countMonoSuffixHierarchies [
	nbrMonoSuffix := (self rootModels select: [ :each | each isMonoSuffix ] ) size
]

{ #category : #'as yet unclassified' }
DMCNBDescriptionModel >> countNumberOfClasses [
	nbrClasses := self allClassModels size
]

{ #category : #'as yet unclassified' }
DMCNBDescriptionModel >> countRootModels [
	| roots |
	roots := self rootModels copy removeAllSuchThat: [ :each | each isMonoClass ].
	nbrRoots := roots size
]

{ #category : #'as yet unclassified' }
DMCNBDescriptionModel >> countSnowFlakes [
	snowFlakes := (self allConceptViewModels select: [ :each | each root isMonoClass ]) size.
	
]

{ #category : #'as yet unclassified' }
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
