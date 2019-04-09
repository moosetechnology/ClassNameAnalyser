Class {
	#name : #ConceptualSymbolSelector,
	#superclass : #TestCase,
	#instVars : [
		'conceptualSymbolSelector'
	],
	#category : #'DMFeatureSelector-Tests'
}

{ #category : #running }
ConceptualSymbolSelector >> setUp [ 
	conceptualSymbolSelector := DMConceptualSymbolSelector new.

]

{ #category : #tests }
ConceptualSymbolSelector >> testSelectFirstSymbolFrom [

	self assert: (conceptualSymbolSelector selectFirstSymbolFrom: { 'Class34' . 'Name' . 'Blueprint%' }) 	equals: 'Class34'.
]

{ #category : #tests }
ConceptualSymbolSelector >> testSelectLastSymbolFrom [
	
	self assert: (conceptualSymbolSelector selectLastSymbolFrom: { 'Class34' . 'Name' . 'Blueprint%' }) 	equals: 'Blueprint%'.
]

{ #category : #tests }
ConceptualSymbolSelector >> testSelectMiddleSymbolFrom [

	self assert: (conceptualSymbolSelector selectMiddleSymbolFrom: { 'Class34' . 'Name' . 'Blueprint%' }) 	equals: 'Name'.
	self assert: (conceptualSymbolSelector selectMiddleSymbolFrom: { 'Class34' . 'Blueprint%' }) equals: 	'Blueprint%'.
	self assert: (conceptualSymbolSelector selectMiddleSymbolFrom: { 'Class34' . 'Name' . 'Blueprint%' . 	'Model' . 'Concept'}) equals: 'Blueprint%'.
]
