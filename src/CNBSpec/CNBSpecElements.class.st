Class {
	#name : #CNBSpecElements,
	#superclass : #Object,
	#instVars : [
		'roassalPresenter',
		'hierarchies',
		'patterns',
		'search',
		'view',
		'projectSelector'
	],
	#category : #CNBSpec
}

{ #category : #accessing }
CNBSpecElements >> hierarchies [
	^hierarchies
]

{ #category : #accessing }
CNBSpecElements >> hierarchies: anObject [
	hierarchies := anObject
]

{ #category : #accessing }
CNBSpecElements >> patterns [
	^patterns
]

{ #category : #accessing }
CNBSpecElements >> patterns: aScrollBarPatternsObject [
	patterns := aScrollBarPatternsObject
]

{ #category : #accessing }
CNBSpecElements >> projectSelector [
	^projectSelector
]

{ #category : #accessing }
CNBSpecElements >> projectSelector: aProjectSelector [
	projectSelector := aProjectSelector
]

{ #category : #accessing }
CNBSpecElements >> roassalPresenter [
	^roassalPresenter 
]

{ #category : #accessing }
CNBSpecElements >> roassalPresenter: aVisualization [
	roassalPresenter := aVisualization 
]

{ #category : #accessing }
CNBSpecElements >> search [
	^search
]

{ #category : #accessing }
CNBSpecElements >> search: aSearchBar [
	search := aSearchBar 
]

{ #category : #accessing }
CNBSpecElements >> view [
	^view
]

{ #category : #accessing }
CNBSpecElements >> view: aView [
	view := aView
]
