Class {
	#name : #DMPackageModel,
	#superclass : #Object,
	#instVars : [
		'packageName',
		'classes',
		'classModels',
		'featureSelector'
	],
	#category : #DMFeatureSelector
}

{ #category : #accessing }
DMPackageModel >> classModels [
	^ classModels 
]

{ #category : #accessing }
DMPackageModel >> classes [ 
	^ classes
]

{ #category : #'as yet unclassified' }
DMPackageModel >> createAClassModelFrom: aClass [

		| classModel | 
		classModel := DMClassModel new.
		classModel createFrom: aClass with: self featureSelector.
		^ classModel 
]

{ #category : #'as yet unclassified' }
DMPackageModel >> createClassModelsFrom: aCollectionOfClasses with: aFeatureSelector [

	featureSelector := aFeatureSelector.
	classes := aCollectionOfClasses.
	classModels := classes collect: [ :aClass | (self createAClassModelFrom: aClass) ].
]

{ #category : #'as yet unclassified' }
DMPackageModel >> extractClassNamesFrom: aPackageName [
	^ ((RPackageOrganizer default packageNamed: aPackageName)  definedClasses collect: [ :each | each instanceSide name ]).
]

{ #category : #'as yet unclassified' }
DMPackageModel >> extractClassesFrom: aPackageName [

	^ ((RPackageOrganizer default packageNamed: aPackageName)  
			definedClasses collect: [ :each | each  ]) asOrderedCollection
]

{ #category : #accessing }
DMPackageModel >> featureSelector [
	^ featureSelector 
]

{ #category : #initialization }
DMPackageModel >> initialize [ 

	super initialize.
	classes := OrderedCollection new.

]

{ #category : #accessing }
DMPackageModel >> packageName [
	^ packageName 
]
