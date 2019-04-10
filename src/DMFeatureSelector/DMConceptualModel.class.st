Class {
	#name : #DMConceptualModel,
	#superclass : #Object,
	#instVars : [
		'packageModels',
		'packages',
		'featureSelector'
	],
	#category : #DMFeatureSelector
}

{ #category : #'as yet unclassified' }
DMConceptualModel >> createPackageModelFrom: aPackage [

 		| packageModel |
		packageModel := DMPackageModel new. 
		packageModel packageName: aPackage.
		packageModel createClassModelsFrom: aPackage with: self featureSelector.
		^ packageModel 
]

{ #category : #'as yet unclassified' }
DMConceptualModel >> createPackageModelsFrom: aCollectionOfPackage with: aFeatureSelector [

	featureSelector := aFeatureSelector.
	packages := aCollectionOfPackage.
	packageModels := packages collect: [ :each | (self createPackageModelFrom: each) ]
				
	

]

{ #category : #accessing }
DMConceptualModel >> featureSelector [
	^ featureSelector 
]

{ #category : #initialization }
DMConceptualModel >> initialize [ 

	packages := OrderedCollection new.
	packageModels := OrderedCollection new.
]

{ #category : #accessing }
DMConceptualModel >> packageModels [
	^ packageModels 
]

{ #category : #accessing }
DMConceptualModel >> packages [ 
	^ packages
]
