Class {
	#name : #CNBPresenterTest,
	#superclass : #TestCase,
	#instVars : [
		'cnbPresenter',
		'projectCNB',
		'cnbCanvas'
	],
	#category : #CNBSpec
}

{ #category : #running }
CNBPresenterTest >> setUp [
	super setUp.

	cnbPresenter := CNBPresenter new.
	projectCNB := CNBRoassal3Builder projectNameMatches: 'moose-*'.
	cnbCanvas := projectCNB on: RSCanvas new.
	cnbPresenter projectSelector text: 'moose-*'. 
	cnbPresenter onLoadProjectClicked.
]

{ #category : #tests }
CNBPresenterTest >> testCanvasNotNil [


	self assert: cnbPresenter cnbSpecView canvas isNotNil equals: true
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
	expectedBoxesToGoDarker := cnbPresenter boxesToBeDarkerFor: #'Scattered Vocabulary'.
	actualBoxesToGoDarker := cnbCanvas deepNodes 
		reject: [ :each | highlightedBoxes includes: each model ].

	cnbPresenter lookFor: #'Scattered Vocabulary'.
	darkerBoxes := cnbPresenter boxesToBeDarkerFor: #'Scattered Vocabulary'.
	self assert: highlightedBoxes size equals: (cnbPresenter lookFor: #'Scattered Vocabulary') size.
]

{ #category : #tests }
CNBPresenterTest >> testNumberColorHighlighted [
	| highlightedBoxes |
	
	projectCNB := CNBRoassal3Builder projectNameMatches: 'moose-*'.
	
	highlightedBoxes := ((CNBPatternSelector of: projectCNB)
		selectPatternOf: #'Scattered Vocabulary').
		
	self assert: highlightedBoxes size equals: 3.
]
