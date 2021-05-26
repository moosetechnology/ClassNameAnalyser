"
I generate a ClassNames Blueprint.
"
Class {
	#name : #CNBClassNamesBlueprintGenerator,
	#superclass : #Object,
	#category : #CNBProjectImporter
}

{ #category : #'as yet unclassified' }
CNBClassNamesBlueprintGenerator class >> buildProjects: aCollectionOfNames from: aPathDirectory [

	^ aCollectionOfNames collect: [ :aProjectName | | mseFileName|
		mseFileName 
			:= (CNBFeatureSelector new removeAllDigitsAndSpecialCharsFrom: aProjectName), '.mse'.
			
		(ClassNamesBlueprint new
		model: (CNBModelGenerator importProject: aPathDirectory,aProjectName,'/',mseFileName); withBoth) startBuilding ]


]

{ #category : #'as yet unclassified' }
CNBClassNamesBlueprintGenerator class >> importProject: aPath [

	^ ClassNamesBlueprint new
		model: (CNBModelGenerator importProject: aPath)
]

{ #category : #'as yet unclassified' }
CNBClassNamesBlueprintGenerator class >> importProjects: aCollectionOfNames from: aPathDirectory [

	^ aCollectionOfNames collect: [ :aProjectName | | mseFileName|
		mseFileName := (CNBFeatureSelector new removeAllDigitsAndSpecialCharsFrom: aProjectName), '.mse'.
		ClassNamesBlueprint new
		model: (CNBModelGenerator importProject: aPathDirectory,aProjectName,'/',mseFileName ) ]


]

{ #category : #'as yet unclassified' }
CNBClassNamesBlueprintGenerator class >> packagesNamed: aCollection [ 

	^ ClassNamesBlueprint new
		model: (CNBModelGenerator packagesNamed: aCollection) 
]

{ #category : #'as yet unclassified' }
CNBClassNamesBlueprintGenerator class >> projectNameMatches: aString [ 

	^ ClassNamesBlueprint new
		model: (CNBModelGenerator projectNameMatches: aString) 
]
