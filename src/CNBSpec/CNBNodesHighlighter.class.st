Class {
	#name : #CNBNodesHighlighter,
	#superclass : #Object,
	#instVars : [
		'nodes',
		'nodesToBeDarker',
		'nodesToBeHighlighted'
	],
	#category : #CNBSpec
}

{ #category : #'as yet unclassified' }
CNBNodesHighlighter >> goDarkerFor: anObject [
	
	"Only tokenViewModels, last composite"

	nodesToBeDarker isNotNil ifTrue: [ self reset ].
	nodesToBeHighlighted := self nodesToHighlightFor: anObject. 
	nodesToBeDarker := self nodesToBeDarker.
	nodesToBeHighlighted ifEmpty: [ ^ self ].
	
	"token boxes: for those to be highlighted the borders will be colors in white + width"
	nodesToBeHighlighted 
				select: [ :each | each hasChildren ] 
				thenDo: [ :aNode | aNode border color: Color white; width: 3 ].
		
	"Change other nodes colors to darker"	
	nodesToBeDarker do: [ :each | each color: each color muchDarker duller ].

]

{ #category : #highlighting }
CNBNodesHighlighter >> highlight: nodesCollection accordingTo: anObject [

	self nodes: nodesCollection.
	self goDarkerFor: anObject 
]

{ #category : #initialization }
CNBNodesHighlighter >> initialize [ 
	super initialize.
	
	nodesToBeDarker := OrderedCollection new.
	nodesToBeHighlighted := OrderedCollection new
]

{ #category : #accessing }
CNBNodesHighlighter >> nodes [ 
		
	^ nodes
]

{ #category : #accessing }
CNBNodesHighlighter >> nodes: allNodes [

	nodes := allNodes

	
]

{ #category : #highlighting }
CNBNodesHighlighter >> nodesToBeDarker [ 

	^ nodes difference: nodesToBeHighlighted 
]

{ #category : #accessing }
CNBNodesHighlighter >> nodesToBeHighlighted [ 

	^ nodesToBeHighlighted 
]

{ #category : #highlighting }
CNBNodesHighlighter >> nodesToHighlightFor: anObject [
	 
	^ anObject selectAttributedNodes: (self nodes select: [ :aNode | aNode hasModel ])
	
]

{ #category : #initialization }
CNBNodesHighlighter >> reset [
	
	self resetHighlightedNodes.
	self resetDarkerNodes.

	
	
]

{ #category : #initialization }
CNBNodesHighlighter >> resetDarkerNodes [
	
	 nodesToBeDarker 
		 do: [ :each | each 
					hasModel
						ifTrue: [ each color: each model originalColor ]
						ifFalse: [ each color: each class new color darker ] 
				]
	
]

{ #category : #initialization }
CNBNodesHighlighter >> resetHighlightedNodes [

	nodesToBeHighlighted 
				select: [ :each | each hasChildren ] 
				thenDo: [ :each | each 
								border 
									color: each model class new defaultBorderColor; 
									width: each model class new defaultBorderWidth.
								"each model hidePatternDescription "].
	
]
