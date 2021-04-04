Class {
	#name : #CNBSingletonHighlighter,
	#superclass : #CNBNodesHighlighter,
	#instVars : [
		'property'
	],
	#classVars : [
		'Instance'
	],
	#category : #CNBSpec
}

{ #category : #accessing }
CNBSingletonHighlighter class >> instance [
	^ Instance ifNil: [ Instance := self basicNew ]
]

{ #category : #'instance creation' }
CNBSingletonHighlighter class >> new [
	self error: 'I''m a singleton!'
]

{ #category : #'instance creation' }
CNBSingletonHighlighter class >> reset [
	Instance := nil
]

{ #category : #accessing }
CNBSingletonHighlighter >> property [
	^ property 
]

{ #category : #accessing }
CNBSingletonHighlighter >> property: aProperty [

	property := aProperty 
]
