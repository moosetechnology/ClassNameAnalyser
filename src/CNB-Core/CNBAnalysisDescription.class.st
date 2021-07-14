"
I represent the data as numbers extracted from the ClassNames Distribution, Num-Packag, Num-Classes, Num-Patterns ...etc
"
Class {
	#name : #CNBAnalysisDescription,
	#superclass : #Object,
	#instVars : [
		'project',
		'scatteredVocabulary',
		'confetti',
		'homogeneous',
		'intruder',
		'snowFlakes',
		'nearlyHomogeneous',
		'fatBlob',
		'tokens',
		'classes',
		'packages',
		'maxDepth',
		'maxChildren',
		'maxChildrenRoot',
		'maxDepthRoot',
		'averageDepth',
		'averageChildren',
		'monoClasses',
		'monoTokenClasses',
		'multiTokenClasses',
		'averageTokensPerMultiHierarchy',
		'suspisciousTokens',
		'hierarchies',
		'multiTokenHierarchies',
		'monoTokenMaxChildren',
		'multiTokenMaxChildren'
	],
	#category : #'CNB-Core'
}

{ #category : #'instance creation' }
CNBAnalysisDescription class >> of: aCnD [

	^ self new
		model: aCnD 
]

{ #category : #accessing }
CNBAnalysisDescription >> averageChildren [

	^ averageChildren
]

{ #category : #accessing }
CNBAnalysisDescription >> averageChildren: aNumber [
	averageChildren := aNumber 
]

{ #category : #accessing }
CNBAnalysisDescription >> averageDepth [
	^ averageDepth
]

{ #category : #accessing }
CNBAnalysisDescription >> averageDepth: aNumber [
	averageDepth := aNumber
]

{ #category : #accessing }
CNBAnalysisDescription >> averageTokensPerMultiHierarchy [
	^ averageTokensPerMultiHierarchy
]

{ #category : #accessing }
CNBAnalysisDescription >> averageTokensPerMultiHierarchy: aNum [

	averageTokensPerMultiHierarchy := aNum
]

{ #category : #accessing }
CNBAnalysisDescription >> classes [
	^ classes
]

{ #category : #accessing }
CNBAnalysisDescription >> classes: aNumber [
	classes := aNumber 
]

{ #category : #accessing }
CNBAnalysisDescription >> confetti [

	^ confetti isZero 
	ifFalse: [ ((confetti / tokens) asFloat) * 100 ]
	ifTrue: [ 0 ]
]

{ #category : #accessing }
CNBAnalysisDescription >> confetti: aNumber [
	
	confetti := aNumber 
]

{ #category : #accessing }
CNBAnalysisDescription >> fatBlob [

	^ fatBlob isZero 
	ifFalse: [ ((fatBlob / tokens) asFloat ) * 100 ]
	ifTrue: [ 0 ]
]

{ #category : #accessing }
CNBAnalysisDescription >> fatBlob: aNumber [
	
	fatBlob := aNumber 
]

{ #category : #accessing }
CNBAnalysisDescription >> hierarchies [ 
	^ hierarchies
]

{ #category : #accessing }
CNBAnalysisDescription >> hierarchies: aNumber [
	hierarchies := aNumber
]

{ #category : #accessing }
CNBAnalysisDescription >> homogeneous [

	^ homogeneous isZero 
	ifFalse: [ ((homogeneous / hierarchies) asFloat) * 100 ]
	ifTrue: [ 0 ]
]

{ #category : #accessing }
CNBAnalysisDescription >> homogeneous: aNumber [
	
	homogeneous := aNumber 
]

{ #category : #accessing }
CNBAnalysisDescription >> intruder [

	^ intruder isZero 
	ifFalse: [ ((intruder / tokens) asFloat )* 100 ]
	ifTrue: [ 0 ]
]

{ #category : #accessing }
CNBAnalysisDescription >> intruder: aNumber [
	
	intruder := aNumber 
]

{ #category : #accessing }
CNBAnalysisDescription >> maxChildren [
	^ maxChildren
]

{ #category : #accessing }
CNBAnalysisDescription >> maxChildren: aNumber [

	maxChildren := aNumber
]

{ #category : #accessing }
CNBAnalysisDescription >> maxChildrenRoot [
	^ maxChildrenRoot
]

{ #category : #accessing }
CNBAnalysisDescription >> maxChildrenRoot: aRoot [

	maxChildrenRoot := aRoot
]

{ #category : #accessing }
CNBAnalysisDescription >> maxDepth [
	^ maxDepth
]

{ #category : #accessing }
CNBAnalysisDescription >> maxDepth: aNumber [

	maxDepth := aNumber 
]

{ #category : #accessing }
CNBAnalysisDescription >> maxDepthRoot [
	^ maxDepthRoot
]

{ #category : #accessing }
CNBAnalysisDescription >> maxDepthRoot: aRoot [

	maxDepthRoot := aRoot 
]

{ #category : #accessing }
CNBAnalysisDescription >> monoClasses [

	^ monoClasses isZero 
	ifFalse: [ ((monoClasses / classes) asFloat) * 100 ] 
	ifTrue: [ 0 ]
]

{ #category : #accessing }
CNBAnalysisDescription >> monoClasses: aSize [

	monoClasses := aSize
]

{ #category : #accessing }
CNBAnalysisDescription >> monoTokenClasses [

	^ monoTokenClasses isZero 
	ifFalse: [ ((monoTokenClasses / classes) asFloat) * 100 ]
	ifTrue: [ 0 ] 
]

{ #category : #accessing }
CNBAnalysisDescription >> monoTokenClasses: aSize [
	monoTokenClasses := aSize 
]

{ #category : #accessing }
CNBAnalysisDescription >> monoTokenMaxChildren [
	^ monoTokenMaxChildren
]

{ #category : #accessing }
CNBAnalysisDescription >> monoTokenMaxChildren: aNumber [ 	
	monoTokenMaxChildren := aNumber 
]

{ #category : #accessing }
CNBAnalysisDescription >> multiTokenClasses [

	^ multiTokenClasses isZero 
	ifFalse: [ ((multiTokenClasses / classes) asFloat) * 100 ]
	ifTrue: [ 0 ]
]

{ #category : #accessing }
CNBAnalysisDescription >> multiTokenClasses: aSize [
	multiTokenClasses := aSize
]

{ #category : #accessing }
CNBAnalysisDescription >> multiTokenHierarchies [

	^ multiTokenHierarchies isZero 
	ifFalse: [ ((multiTokenHierarchies / hierarchies) asFloat) * 100  ] 
	ifTrue: [ 0 ]
]

{ #category : #accessing }
CNBAnalysisDescription >> multiTokenHierarchies: aSize [
	multiTokenHierarchies := aSize
]

{ #category : #accessing }
CNBAnalysisDescription >> multiTokenMaxChildren [
	^ multiTokenMaxChildren
]

{ #category : #accessing }
CNBAnalysisDescription >> multiTokenMaxChildren: aNumber [ 	
	multiTokenMaxChildren := aNumber 
]

{ #category : #accessing }
CNBAnalysisDescription >> nearlyHomogeneous [

	^ nearlyHomogeneous isZero 
	ifFalse: [ ((nearlyHomogeneous / hierarchies) asFloat) * 100  ] 
	ifTrue: [ 0 ]
]

{ #category : #accessing }
CNBAnalysisDescription >> nearlyHomogeneous: aNumber [
	
	nearlyHomogeneous := aNumber 
]

{ #category : #accessing }
CNBAnalysisDescription >> packages [
	^ packages
]

{ #category : #accessing }
CNBAnalysisDescription >> packages: aNumber [

	packages := aNumber 
]

{ #category : #accessing }
CNBAnalysisDescription >> project [
	^ project
]

{ #category : #accessing }
CNBAnalysisDescription >> project: aName [ 
	project := aName
]

{ #category : #accessing }
CNBAnalysisDescription >> scatteredVocabulary [

	^ scatteredVocabulary isZero  
	ifFalse: [ ((scatteredVocabulary / hierarchies) asFloat) * 100 ] 
	ifTrue: [ 0 ]
]

{ #category : #accessing }
CNBAnalysisDescription >> scatteredVocabulary: aNumber [
	
	scatteredVocabulary := aNumber 
]

{ #category : #accessing }
CNBAnalysisDescription >> snowFlakes [

	^ snowFlakes isZero 
	ifFalse: [ ((snowFlakes / tokens) asFloat )* 100 ]
	ifTrue: [ 0 ]
]

{ #category : #accessing }
CNBAnalysisDescription >> snowFlakes: aNumber [
	
	snowFlakes := aNumber 
]

{ #category : #accessing }
CNBAnalysisDescription >> suspisciousTokens [
	
	^ suspisciousTokens isZero 
	ifFalse: [ (suspisciousTokens / tokens asFloat) * 100 ]
	ifTrue: [ 0 ]
]

{ #category : #accessing }
CNBAnalysisDescription >> suspisciousTokens: aNumder [
	suspisciousTokens := aNumder 
]

{ #category : #accessing }
CNBAnalysisDescription >> tokens [
	^ tokens
]

{ #category : #accessing }
CNBAnalysisDescription >> tokens: aNumber [
	tokens := aNumber 
]
