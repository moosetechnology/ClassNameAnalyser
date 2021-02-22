Class {
	#name : #CNBPresenterTest,
	#superclass : #TestCase,
	#instVars : [
		'projectCNB',
		'cnbCanvas',
		'presenter'
	],
	#category : #CNBSpec
}

{ #category : #running }
CNBPresenterTest >> setUp [
	super setUp.

	presenter := CNBPresenter new.
	projectCNB := CNBRoassal3Builder projectNameMatches: 'moose-*'.
	cnbCanvas := projectCNB on: RSCanvas new.
	presenter projectSelector text: 'moose-*'. 
	presenter onLoadProjectClicked.
	presenter cnbSpecView openWithSpec.
]

{ #category : #tests }
CNBPresenterTest >> testCanvasNotNil [


	self assert: presenter cnbSpecView canvas isNotNil equals: true
]

{ #category : #tests }
CNBPresenterTest >> testColorHighlighted [
	| highlightedBoxes |

	
	highlightedBoxes := ((CNBPatternSelector of: projectCNB)
		selectPatternOf: #'Scattered Vocabulary').
		
	self
		assert: (highlightedBoxes collect: #color) asSet
		equals: { Color purple } asSet 
]

{ #category : #tests }
CNBPresenterTest >> testGoDarker [
	| highlightedBoxes darkerBoxes expectedBoxesToGoDarker actualBoxesToGoDarker |
	
	highlightedBoxes := ((CNBPatternSelector of: projectCNB) 
			selectPatternOf: #'Scattered Vocabulary').
	expectedBoxesToGoDarker := presenter boxesToBeDarkerFor: #'Scattered Vocabulary'.
	actualBoxesToGoDarker := cnbCanvas deepNodes 
		reject: [ :each | highlightedBoxes includes: each model ].

	presenter lookFor: #'Scattered Vocabulary'.
	darkerBoxes := presenter boxesToBeDarkerFor: #'Scattered Vocabulary'.
	self assert: highlightedBoxes size equals: (presenter lookFor: #'Scattered Vocabulary') size.
]

{ #category : #tests }
CNBPresenterTest >> testNumberColorHighlighted [
	| highlightedBoxes |
	
	projectCNB := CNBRoassal3Builder projectNameMatches: 'moose-*'.
	
	highlightedBoxes := ((CNBPatternSelector of: projectCNB)
		selectPatternOf: #'Scattered Vocabulary').
		
	self assert: highlightedBoxes size equals: 3.
]

{ #category : #tests }
CNBPresenterTest >> testSelectFatBlobs [
	

	presenter patternsDropList selectItem: #'Fat Blob'.
	
]
