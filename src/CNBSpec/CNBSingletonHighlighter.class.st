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

{ #category : #'as yet unclassified' }
CNBSingletonHighlighter >> generateDifferentColorThen: aColor [

	| color |
	color := Color random.
	color = aColor ifTrue: [ ^ self generateDifferentColorThen: aColor ].
	
	^ color
]

{ #category : #accessing }
CNBSingletonHighlighter >> goDarkerFor: anObject [

	super goDarkerFor: anObject.
	(property isNotNil and: [ property isMultiToken ]) ifFalse: [ ^ self ].
	nodesToBeHighlighted do: [ :each | 
		each border: (RSBorder new
				 color: Color white;
				 yourself) ].
	nodesToBeHighlighted
		select: [ :aNode | aNode model token ~= aNode model root mainToken ]
		thenDo: [ :each | 
			each
				width: 60;
				height: 60.
			each border: (RSBorder new
					 color: Color white;
					 width: 10;
					 yourself) ]
]

{ #category : #accessing }
CNBSingletonHighlighter >> property [
	^ property 
]

{ #category : #accessing }
CNBSingletonHighlighter >> property: aProperty [

	property := aProperty 
]

{ #category : #initialization }
CNBSingletonHighlighter >> resetHighlightedNodes [ 
	
	super resetHighlightedNodes.

	(nodesToBeHighlighted allSatisfy: [ :each | each hasChildren not ]) ifTrue: [  
	nodesToBeHighlighted		do: [ :each | 
					each width: each model class new width; height: each model class new height.
					each border: each model border
					 ]
								]
]
