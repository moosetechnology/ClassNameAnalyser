Class {
	#name : #DMColorAttributor,
	#superclass : #Object,
	#instVars : [
		'hierarchiesColors'
	],
	#category : #DMClassNameBlueprint
}

{ #category : #building }
DMColorAttributor >> attributeColors: aViewModel [

	| allConceptsViewModels allClassViewModels featureSelector hierarchies concepts 		conceptsHierarchies conceptsColors  |	
	
	featureSelector := DMFeatureSelector new.		
	hierarchies := self extractAllRootClassesFrom: aViewModel.
	hierarchiesColors := (self setColorsOf: hierarchies From: aViewModel).
	
	concepts := self extractAllConceptsFrom: aViewModel.
	conceptsHierarchies:= (concepts collect: [ :aConcept | ((aConcept)->(OrderedCollection new)) ]) 		asDictionary.
	allConceptsViewModels := aViewModel packageViewModels flatCollect: [ :aPackageModel | 		aPackageModel	conceptViewModels ].	
	allConceptsViewModels do: [ :aConceptViewModel | 
		| roots |
		roots := aConceptViewModel classViewModels collect: [ :aClassModel | featureSelector 		extractRootClassFrom: (aClassModel classRef) ].
		(conceptsHierarchies at: aConceptViewModel conceptName) addAll: roots ].
	
	conceptsColors := (concepts collect: [ :aConcept |
		| color conceptsBiggestHierarchy  |
		conceptsBiggestHierarchy := self selectBiggestHierarchy: (conceptsHierarchies at: aConcept).	
		color := (self selectColorOf:conceptsBiggestHierarchy).
		(((conceptsHierarchies at: aConcept) asSet size > 1) and: [color == #gray])
		ifTrue: [ (aConcept -> #lightGray) ] ifFalse: [(aConcept->color)]
		 ]) asDictionary.	
						
	allConceptsViewModels do: [ :aConceptViewModel | 
		aConceptViewModel color: (self selectConceptsColor: 	aConceptViewModel conceptName From: conceptsColors).
			aConceptViewModel root: (self selectBiggestHierarchy: (conceptsHierarchies at: aConceptViewModel conceptName)	).
			].			
	allClassViewModels := allConceptsViewModels 
		flatCollect: [ :aConceptVModel | aConceptVModel classViewModels ].	
	allClassViewModels do: [ :aClassViewModel |
aClassViewModel color:(self selectColorOf: (aClassViewModel classRef)) ].
	^aViewModel 
]

{ #category : #'as yet unclassified' }
DMColorAttributor >> checkIfMonoSuffix: aRoot [

	| subclasses conceptualSymbolSelector symbol  |

	conceptualSymbolSelector := DMConceptualSymbolSelector new.
	symbol := (conceptualSymbolSelector selectLastSymbol: aRoot asString).
	subclasses := aRoot allSubclasses.
	subclasses do: [ :aSubClass | ((conceptualSymbolSelector selectLastSymbol: aSubClass) = symbol)
		ifFalse: [ ^false ]
		 ].
	^true
	
]

{ #category : #'as yet unclassified' }
DMColorAttributor >> extractAllClasses: aViewModel [

	| conceptVMs classVMs classes |
	conceptVMs := aViewModel packageViewModels flatCollect: [ :aPackageVMs | aPackageVMs conceptViewModels 	].
	classVMs := conceptVMs flatCollect: [ :aConceptVM | aConceptVM classViewModels ].
	classes := classVMs collect: [ :aClassMD | aClassMD classRef ].
	^classes 
]

{ #category : #actions }
DMColorAttributor >> extractAllConceptsFrom: aViewModel [

	| packageViewModels conceptsViewModels  resultedConcepts |
	packageViewModels := aViewModel packageViewModels.
	conceptsViewModels := packageViewModels flatCollect: [ :aPackageViewModel | aPackageViewModel 	conceptViewModels ].
	resultedConcepts := conceptsViewModels collect: [ :aConceptViewModel | aConceptViewModel  	conceptName  ].
	^ resultedConcepts asSet
]

{ #category : #actions }
DMColorAttributor >> extractAllRootClassesFrom: aViewModel [

	| packageViewModels resultedHierarchies conceptViewModels featureSelector classViewModels |
	featureSelector := DMFeatureSelector new.
	resultedHierarchies := OrderedCollection new.
	packageViewModels := aViewModel packageViewModels.
	conceptViewModels := packageViewModels flatCollect: [ :aPackageViewModel | aPackageViewModel 	conceptViewModels  ].
	classViewModels := conceptViewModels flatCollect: [ :aConceptViewModel | aConceptViewModel 	classViewModels ].
	resultedHierarchies := classViewModels collect: [ :aClassViewModel | (featureSelector 	extractRootClassFrom: aClassViewModel classRef ) ].
	^ resultedHierarchies asOrderedCollection.
	
	
]

{ #category : #'as yet unclassified' }
DMColorAttributor >> extractMonoHierarchies: aViewModel [

	| rootClasses collectionOfMonos |
	rootClasses := self extractAllRootClassesFrom: aViewModel.
	collectionOfMonos := OrderedCollection new.
	^(rootClasses select: [ :aRootClass | (self checkIfMonoSuffix: aRootClass From: aViewModel )
		]) asSet
	
]

{ #category : #accessing }
DMColorAttributor >> hierarchiesColors [
	^hierarchiesColors
]

{ #category : #building }
DMColorAttributor >> selectBiggestHierarchy: aCollection [
	^ aCollection asBag sortedCounts first value
]

{ #category : #actions }
DMColorAttributor >> selectColorOf: aClass [

	| featureSelector  theRootClass color |
	featureSelector := DMFeatureSelector new.
	theRootClass := featureSelector extractRootClassFrom: aClass.
	color := hierarchiesColors at: theRootClass.
	^ color
]

{ #category : #building }
DMColorAttributor >> selectConceptsColor: aConcept From: conceptsColors [
	^ (conceptsColors at: aConcept) 
]

{ #category : #actions }
DMColorAttributor >> setColorsOf: aCollection From: aViewModel [

	| arrayOfColors index multiSuffixesColors monoClasses monoSuffixes resultedColors |
	arrayOfColors := {#red . #yellow . #blue . #purple . #magenta . #orange . #green . #pink . #tan  . #cyan . #lightBlue . #lightBrown . #lightCyan  . #lightGreen.
	#lightMagenta . #lightOrange . #lightRed . #lightYellow . #paleBuff.
	#paleGreen . #paleMagenta . #paleOrange . #palePeach . #paleRed . #paleTan.
	#paleYellow . #black}.
	index := 0.
	resultedColors := Dictionary new.
	monoClasses := aCollection select: [ :anHierarchy | anHierarchy subclasses isEmpty ].
	aCollection removeAll: monoClasses.
	monoSuffixes := aCollection select: [ :anHierarchy | (self checkIfMonoSuffix: anHierarchy )].
	aCollection removeAll: monoSuffixes.
	multiSuffixesColors := ((aCollection asBag sortedCounts) collect: [ :anAssociation | 
		(index == arrayOfColors size)
		ifFalse: [ index := index + 1 ].
		(anAssociation value -> (arrayOfColors at: index))	
		 ]) asDictionary.
	resultedColors addAll: multiSuffixesColors; addAll: (monoClasses asSet collect: [ :aMonoClass | (aMonoClass -> #white)]) asDictionary; addAll: (monoSuffixes asSet collect: [ :aMonoSuffix | (aMonoSuffix -> #gray) ]) asDictionary .
	 ^ resultedColors asDictionary
]
