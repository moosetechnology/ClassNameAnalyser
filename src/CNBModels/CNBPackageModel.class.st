"
I am a simple model of a Package
"
Class {
	#name : #CNBPackageModel,
	#superclass : #CNBAbstractModel,
	#instVars : [
		'classModels',
		'packageViewModel'
	],
	#category : #CNBModels
}

{ #category : #accessing }
CNBPackageModel class >> of: aPackage withSettings: settings [

	| onlyClasses |
	onlyClasses := aPackage classes.
	settings noInterfaces ifTrue: [
		onlyClasses := onlyClasses reject: #isInterface ].

	^ self new
		  name: aPackage name;
		  classModels:
			  (onlyClasses collect: [ :each |
					   each classModelAccordingTo: settings ])
]

{ #category : #accessing }
CNBPackageModel >> classModels [

	^ classModels
]

{ #category : #accessing }
CNBPackageModel >> classModels: collection [

	classModels := collection
]

{ #category : #extracting }
CNBPackageModel >> extractClassModelsWithToken: aToken [

	^ classModels select: [ :eachClassmodel | eachClassmodel token = aToken ]
]

{ #category : #testing }
CNBPackageModel >> includesToken: aToken [
	
	^ (self classModels collect: #token) includes: aToken
]

{ #category : #accessing }
CNBPackageModel >> packageViewModel [
	^ packageViewModel
]

{ #category : #accessing }
CNBPackageModel >> packageViewModel: aPackageViewModel [

	packageViewModel := aPackageViewModel 
]

{ #category : #printing }
CNBPackageModel >> printOn: aStream [

	super printOn: aStream. 
	aStream nextPutAll: ' ('.
	self name asString printOn: aStream.
	aStream nextPutAll: ')'
]

{ #category : #accessing }
CNBPackageModel >> tokensDictionary [ 

	^ classModels collect: [ :each | each token ]
]
