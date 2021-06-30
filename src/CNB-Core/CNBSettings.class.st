"
I represent the settings of the ClassNames Distribution: root class and the token's position (suffix, prefix or both).
"
Class {
	#name : #CNBSettings,
	#superclass : #Object,
	#instVars : [
		'token',
		'rootClass',
		'noInterfaces',
		'noPackagesNames'
	],
	#category : #'CNB-Core'
}

{ #category : #accessing }
CNBSettings >> defaultRootClass [ 

	^ Object
]

{ #category : #accessing }
CNBSettings >> defaultToken [ 

	^ #suffix
]

{ #category : #accessing }
CNBSettings >> deleteInterfaces [
	noInterfaces := true
]

{ #category : #'as yet unclassified' }
CNBSettings >> deletePackagesNames [ 
	noPackagesNames := true
]

{ #category : #accessing }
CNBSettings >> initialize [ 
	super initialize.
	noInterfaces := false.
	noPackagesNames := false.
]

{ #category : #'as yet unclassified' }
CNBSettings >> leaveInterfaces [ 	
	noInterfaces := false
]

{ #category : #'as yet unclassified' }
CNBSettings >> leavePackagesNames [ 
	noPackagesNames := false
]

{ #category : #accessing }
CNBSettings >> noInterfaces [ 
	^ noInterfaces 
]

{ #category : #accessing }
CNBSettings >> noPackagesNames [
	^ noPackagesNames
]

{ #category : #accessing }
CNBSettings >> rootClass [

	^ rootClass ifNil: [ self defaultRootClass name ]

]

{ #category : #accessing }
CNBSettings >> rootClass: aClass [

	rootClass := aClass
]

{ #category : #accessing }
CNBSettings >> token [

	^ token ifNil: [ self defaultToken  ]
]

{ #category : #accessing }
CNBSettings >> token: aSymbol [

	token := aSymbol
]
