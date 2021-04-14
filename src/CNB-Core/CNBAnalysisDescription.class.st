"
I represent the data as numbers extracted from the ClassNames Distribution, Num-Packag, Num-Classes, Num-Patterns ...etc
"
Class {
	#name : #CNBAnalysisDescription,
	#superclass : #Object,
	#instVars : [
		'scatteredVocabulary',
		'confetti',
		'homogeneous',
		'intruder',
		'snowFlakes',
		'homogeneityBreaker',
		'fatBlob',
		'tokens',
		'classes',
		'packages',
		'maxDepth',
		'maxChildren',
		'maxChildrenRoot',
		'maxDepthRoot',
		'averageDepth',
		'averageChildren'
	],
	#category : #'CNB-Core'
}

{ #category : #accessing }
CNBAnalysisDescription >> averageChildren: aNumber [
	averageChildren := aNumber 
]

{ #category : #accessing }
CNBAnalysisDescription >> averageDepth: aNumber [
	averageDepth := aNumber
]

{ #category : #accessing }
CNBAnalysisDescription >> classes: aNumber [
	classes := aNumber 
]

{ #category : #accessing }
CNBAnalysisDescription >> confetti: aNumber [
	
	confetti := aNumber 
]

{ #category : #accessing }
CNBAnalysisDescription >> fatBlob: aNumber [
	
	fatBlob := aNumber 
]

{ #category : #accessing }
CNBAnalysisDescription >> homogeneityBreaker: aNumber [
	
	homogeneityBreaker := aNumber 
]

{ #category : #accessing }
CNBAnalysisDescription >> homogeneous: aNumber [
	
	homogeneous := aNumber 
]

{ #category : #accessing }
CNBAnalysisDescription >> intruder: aNumber [
	
	intruder := aNumber 
]

{ #category : #accessing }
CNBAnalysisDescription >> maxChildren: aNumber [

	maxChildren := aNumber
]

{ #category : #accessing }
CNBAnalysisDescription >> maxChildrenRoot: aRoot [

	maxChildrenRoot := aRoot
]

{ #category : #accessing }
CNBAnalysisDescription >> maxDepth: aNumber [

	maxDepth := aNumber 
]

{ #category : #accessing }
CNBAnalysisDescription >> maxDepthRoot: aRoot [

	maxDepthRoot := aRoot 
]

{ #category : #accessing }
CNBAnalysisDescription >> packages: aNumber [

	packages := aNumber 
]

{ #category : #accessing }
CNBAnalysisDescription >> scatteredVocabulary: aNumber [
	
	scatteredVocabulary := aNumber 
]

{ #category : #accessing }
CNBAnalysisDescription >> snowFlakes: aNumber [
	
	snowFlakes := aNumber 
]

{ #category : #accessing }
CNBAnalysisDescription >> tokens: aNumber [
	tokens := aNumber 
]
