Class {
	#name : #DMColorAttributor,
	#superclass : #Object,
	#instVars : [
		'hierarchiesColors',
		'conceptsColors',
		'hierarchies',
		'conceptsHierarchies',
		'concepts'
	],
	#category : #DMClassNameBlueprint
}

{ #category : #building }
DMColorAttributor >> attributeColors: aViewModel [


	| allConceptsViewModels allClassViewModels featureSelector  |	
		hierarchies := self extractAllRootClassesFrom: aViewModel.
		concepts := self extractAllConceptsFrom: aViewModel.
		conceptsHierarchies:= (concepts collect: [ :aConcept | ((aConcept)->(OrderedCollection new)) ]) 	asDictionary.
		featureSelector := DMFeatureSelector new.
	hierarchiesColors := (self attributeColorsTo: hierarchies).
			allConceptsViewModels := aViewModel packageViewModels flatCollect: [ :aPackageModel | aPackageModel	conceptViewModels ].	
			allConceptsViewModels do: [ :aConceptViewModel | | Hierarchies |
		Hierarchies := aConceptViewModel classViewModels collect: [ :aClassModel | featureSelector extractRootClassFrom: (aClassModel classRef) ].
		(conceptsHierarchies at: aConceptViewModel conceptsName) addAll: Hierarchies.		
			 ]	.
	conceptsColors := (concepts collect: [ :aConcept | | color conceptsBiggestHierarchy |
	conceptsBiggestHierarchy := self selectBiggestHierarchy: (conceptsHierarchies at: aConcept).	
	color := self findColorOf: conceptsBiggestHierarchy.	
		(aConcept->color)		
		  ] ) asDictionary.					
		allConceptsViewModels do: [ :aConceptViewModel | aConceptViewModel color: (self 	selectConceptsColor: 	aConceptViewModel conceptsName)  ].			
			allClassViewModels := allConceptsViewModels flatCollect: [ :aConceptVModel | aConceptVModel 	classViewModels ].	
		allClassViewModels := allConceptsViewModels flatCollect: [ :aConceptVModel | aConceptVModel 	classViewModels  ].
	allClassViewModels do: [ :aClassViewModel | aClassViewModel color:(self findColorOf: 	aClassViewModel classRef) value ].

	^aViewModel 
]

{ #category : #actions }
DMColorAttributor >> attributeColorsTo: aCollection [

	| arrayOfColors index resultedColors|
	arrayOfColors := {#red . #blue . #pink . #purple . #tan . #yellow.
	#orange . #magenta . #green . #gray . #cyan . #brown . #darkGray.
	#lightBlue . #lightBrown . #lightCyan . #lightGray . #lightGreen.
	#lightMagenta . #lightOrange . #lightRed . #lightYellow . #paleBuff.
	#paleGreen . #paleMagenta . #paleOrange . #palePeach . #paleRed . #paleTan.
	#paleYellow . #black}.
	index := 0.
	resultedColors := ((aCollection asBag sortedCounts) collect: [ :anAssociation | 
		(index == arrayOfColors size)
		ifFalse: [ index := index + 1 ].
		(anAssociation value -> (arrayOfColors at: index)).	
		 ]).
	 ^ resultedColors asDictionary
]

{ #category : #accessing }
DMColorAttributor >> concepts [
	^concepts
]

{ #category : #accessing }
DMColorAttributor >> concepts: aCollectionOfConcepts [
	concepts := aCollectionOfConcepts 
]

{ #category : #accessing }
DMColorAttributor >> conceptsColors [
	^conceptsColors 
]

{ #category : #accessing }
DMColorAttributor >> conceptsColors: aCollectionOfAssociation [
	conceptsColors := aCollectionOfAssociation 
]

{ #category : #accessing }
DMColorAttributor >> conceptsHierarchies [ 
	^ conceptsHierarchies
]

{ #category : #accessing }
DMColorAttributor >> conceptsHierarchies: aCollectionOfAssociations [
	conceptsHierarchies := aCollectionOfAssociations 
]

{ #category : #actions }
DMColorAttributor >> extractAllConceptsFrom: aViewModel [

	| packageViewModels conceptsViewModels  resultedConcepts |
	packageViewModels := aViewModel packageViewModels.
	conceptsViewModels := packageViewModels flatCollect: [ :aPackageViewModel | aPackageViewModel conceptViewModels ].
	resultedConcepts := conceptsViewModels collect: [ :aConceptViewModel | aConceptViewModel  conceptsName  ].
	^ resultedConcepts asOrderedCollection 
]

{ #category : #actions }
DMColorAttributor >> extractAllRootClassesFrom: aViewModel [

	| packageViewModels resultedHierarchies conceptViewModels featureSelector classViewModels |
	featureSelector := DMFeatureSelector new.
	resultedHierarchies := OrderedCollection new.
	packageViewModels := aViewModel packageViewModels.
	conceptViewModels := packageViewModels flatCollect: [ :aPackageViewModel | aPackageViewModel conceptViewModels  ].
	classViewModels := conceptViewModels flatCollect: [ :aConceptViewModel | aConceptViewModel classViewModels ].
	resultedHierarchies := classViewModels collect: [ :aClassViewModel | (featureSelector extractRootClassFrom: aClassViewModel classRef ) ].
	^ resultedHierarchies asOrderedCollection.
	
	
]

{ #category : #actions }
DMColorAttributor >> findColorOf: aClass [ 

	| featureSelector  theRootClass color |
	featureSelector := DMFeatureSelector new.
	theRootClass := featureSelector extractRootClassFrom: aClass.
	color := hierarchiesColors at: theRootClass.
	^ color
]

{ #category : #accessing }
DMColorAttributor >> hierarchies [ 
	^hierarchies 
]

{ #category : #accessing }
DMColorAttributor >> hierarchies: aCollectionOfRootClasses [
	hierarchies := aCollectionOfRootClasses 
]

{ #category : #accessing }
DMColorAttributor >> hierarchiesColors [
	^ hierarchiesColors 
]

{ #category : #accessing }
DMColorAttributor >> hierarchiesColors: aCollectionOfRootClassesAndTheirColors [
	hierarchiesColors := aCollectionOfRootClassesAndTheirColors 
]

{ #category : #initialization }
DMColorAttributor >> initialize [ 
	
	super initialize.
	conceptsHierarchies := Dictionary new.
]

{ #category : #building }
DMColorAttributor >> selectBiggestHierarchy: aCollection [
	^ aCollection asBag sortedCounts first value
]

{ #category : #building }
DMColorAttributor >> selectConceptsColor: aConcept [
	^ (conceptsColors at: aConcept) 
]
