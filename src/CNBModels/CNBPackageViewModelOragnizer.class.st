Class {
	#name : #CNBPackageViewModelOragnizer,
	#superclass : #Object,
	#instVars : [
		'package'
	],
	#category : #CNBModels
}

{ #category : #'instance creation' }
CNBPackageViewModelOragnizer class >> of: aPackageModel [
	^ self new
		package: aPackageModel 
]
