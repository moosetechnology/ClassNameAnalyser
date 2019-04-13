Class {
	#name : #DMClassNameBlueprintBuilder,
	#superclass : #Object,
	#category : #DMClassNameBlueprint
}

{ #category : #'as yet unclassified' }
DMClassNameBlueprintBuilder >> buildModelFrom: aConceptualModel [

	^ self createViewModelFrom: aConceptualModel  
	
]

{ #category : #'as yet unclassified' }
DMClassNameBlueprintBuilder >> createClassViewModelsFrom: aCollectionOfClassModels [

	| classViewModels |
	classViewModels := aCollectionOfClassModels collect: [ :aClassModel | | aClassViewModel |
		aClassViewModel := DMClassViewModel new.
		aClassViewModel theClass: (aClassModel theClass).
		 ].
	^classViewModels 
]

{ #category : #'as yet unclassified' }
DMClassNameBlueprintBuilder >> createConceptsViewModelsFrom: aPackageModel [

	| conceptsViewModels  classModels conceptsBag |
	conceptsViewModels := OrderedCollection new.
	conceptsBag := self extractConceptsFrom: aPackageModel.
	conceptsViewModels := conceptsBag collect: [ :aConceptAssociation | 
		| aConceptViewModel |
		aConceptViewModel := DMConceptViewModel new.
		aConceptViewModel conceptsName: aConceptAssociation value.
		classModels := aPackageModel classModels select: [ :aClassModel | 
			(aClassModel concept == aConceptViewModel conceptsName) ].
		aConceptViewModel classViewModels: (self createClassViewModelsFrom: classModels)
		 ].
	^ conceptsViewModels 
	
]

{ #category : #'as yet unclassified' }
DMClassNameBlueprintBuilder >> createPackageViewModelsFrom: aCollectionOfPackageModels [
	
	| packageViewModels |
	packageViewModels := OrderedCollection new.
	packageViewModels := aCollectionOfPackageModels collect: [ :aPackageModel | | packageViewModel |
		packageViewModel := DMPackageViewModel new.
		packageViewModel packageName: aPackageModel packageName.
		packageViewModel conceptViewModels: (self createConceptsViewModelsFrom: aPackageModel).
		 ].
	^packageViewModels 

]

{ #category : #'as yet unclassified' }
DMClassNameBlueprintBuilder >> createViewModelFrom: aConceptualModel [
	
	| aViewModel |
	aViewModel := DMViewModel new.
	aViewModel packageViewModels: (self createPackageViewModelsFrom: aConceptualModel packageModels).
	^aViewModel 
]

{ #category : #'as yet unclassified' }
DMClassNameBlueprintBuilder >> extractAllRootClassesFrom: aConceptualModel [

	| rootClasses packageModels classModels |
	rootClasses := OrderedCollection new.
	packageModels := aConceptualModel packageModels.
	classModels := packageModels flatCollect: [ :aPackageModel | aPackageModel classModels ].
	rootClasses := classModels collect: [ :aClassViewModel | aClassViewModel rootClass ].
	^ rootClasses 
	
	
]

{ #category : #'as yet unclassified' }
DMClassNameBlueprintBuilder >> extractConceptsFrom: aPackageModel [

	| conceptsBag |
	conceptsBag := (aPackageModel classModels collect: [ :aClassModel | aClassModel concept ]) asBag.
	^ conceptsBag 
]
