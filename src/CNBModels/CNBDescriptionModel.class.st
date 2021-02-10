"
I hold the patterns of the ClassNames Blueprint visualization using queries.
"
Class {
	#name : #CNBDescriptionModel,
	#superclass : #CNBViewModel,
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
	#category : #CNBModels
}

{ #category : #accessing }
CNBDescriptionModel >> allConceptViewModels [
	^self packageViewModels flatCollect: #suffixViewModels
]

{ #category : #accessing }
CNBDescriptionModel >> averageClassesPerSuffix [
	^averageClassesPerSuffix
]

{ #category : #queries }
CNBDescriptionModel >> countAverageClassesPerSuffix [

	averageClassesPerSuffix := (self allConceptViewModels collect: [ 
		                            :each | each classViewModels size ])
		                           average asFloat.
	^ averageClassesPerSuffix
]

{ #category : #queries }
CNBDescriptionModel >> countConcepts [
	nbrSuffixes := (self allClassModels collect: #suffix ) asSet size
]

{ #category : #queries }
CNBDescriptionModel >> countHomogeneous [

	"first select the concepts dominated by a mono hierarchy, then check if all inner classes belong to mono suffix hierarchies"

	| conceptViewModelsDominatedByMonoHierarchy |
	conceptViewModelsDominatedByMonoHierarchy := self
		                                             allConceptViewModels 
		                                             select: [ :each | 
		                                             each root isMonoSuffix ].
	homogeneous := (conceptViewModelsDominatedByMonoHierarchy select: [ 
		                :each | 
		                each classViewModels allSatisfy: [ :aCVM | 
			                aCVM root isMonoSuffix ] ]) size
]

{ #category : #queries }
CNBDescriptionModel >> countIntruders [ 
	 nbrIntruders:= (DMBuilder countIntrudersIn: self)
]

{ #category : #queries }
CNBDescriptionModel >> countMonoClasses [

	nbrMonoClasses := (self rootModels select: [ :each | each isMonoClass ]) size
]

{ #category : #queries }
CNBDescriptionModel >> countMonoSuffixHierarchies [
	nbrMonoSuffix := (self rootModels select: [ :each | each isMonoSuffix ] ) size
]

{ #category : #queries }
CNBDescriptionModel >> countNumberOfClasses [
	nbrClasses := self allClassModels size
]

{ #category : #queries }
CNBDescriptionModel >> countRootModels [
	| roots |
	roots := self rootModels copy removeAllSuchThat: [ :each | each isMonoClass ].
	nbrRoots := roots size
]

{ #category : #queries }
CNBDescriptionModel >> countSnowFlakes [
	snowFlakes := (self allConceptViewModels select: [ :each | each root isMonoClass ]) size.
	
]

{ #category : #queries }
CNBDescriptionModel >> countnMultiSuffixHierarchies [
	nbrMultiSuffix := (self rootModels select: [ :each | each isMultiSuffix ] ) size
]

{ #category : #operations }
CNBDescriptionModel >> create [
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
CNBDescriptionModel >> homogeneous [
	^homogeneous 
]

{ #category : #accessing }
CNBDescriptionModel >> nbrClasses [ 
	^nbrClasses 
]

{ #category : #accessing }
CNBDescriptionModel >> nbrClasses: aNumber [
	nbrClasses := aNumber 
]

{ #category : #accessing }
CNBDescriptionModel >> nbrIntruders [
	^nbrIntruders
]

{ #category : #accessing }
CNBDescriptionModel >> nbrMonoClasses [
	^nbrMonoClasses
]

{ #category : #accessing }
CNBDescriptionModel >> nbrMonoClasses: aNumber [
	nbrMonoClasses:= aNumber
]

{ #category : #accessing }
CNBDescriptionModel >> nbrMonoSuffix [
	^nbrMonoSuffix
]

{ #category : #accessing }
CNBDescriptionModel >> nbrMonoSuffix: aNumber [
	nbrMonoSuffix := aNumber
]

{ #category : #accessing }
CNBDescriptionModel >> nbrMultiSuffix [
	^nbrMultiSuffix
]

{ #category : #accessing }
CNBDescriptionModel >> nbrMultiSuffix: aNumber [
	nbrMultiSuffix := aNumber
]

{ #category : #accessing }
CNBDescriptionModel >> nbrRoots [
	^nbrRoots
]

{ #category : #accessing }
CNBDescriptionModel >> nbrRoots: aNumber [ 
	nbrRoots := aNumber
]

{ #category : #accessing }
CNBDescriptionModel >> nbrSuffixes [
	^nbrSuffixes
]

{ #category : #accessing }
CNBDescriptionModel >> nbrSuffixes: aNumber [
	nbrSuffixes := aNumber
]

{ #category : #accessing }
CNBDescriptionModel >> snowFlakes [
	^snowFlakes
]
