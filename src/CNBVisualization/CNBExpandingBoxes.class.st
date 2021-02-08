Class {
	#name : #CNBExpandingBoxes,
	#superclass : #Object,
	#instVars : [
		'canvas',
		'color',
		'base',
		'border',
		'labeled'
	],
	#category : #CNBVisualization
}

{ #category : #'primitives-file' }
CNBExpandingBoxes >> close: shape [
	shape children copy do: #remove.
	self update.
]

{ #category : #initialization }
CNBExpandingBoxes >> initialize [
	super initialize.
	labeled := RSLabeled new.
	canvas := RSCanvas new.
	color := NSScale category20b.
	base := RSComposite new.
	base popup.
	base when: RSMouseLeftClick do: [ :evt | self processEvent: evt ].
	border := RSBorder new color: Color black
]

{ #category : #helpers }
CNBExpandingBoxes >> nodeFor: model [
	| com |
	com := base copy.
	com model: model.
	com border: border.
	com announcer: base announcer.
	com color: (model color).
	^ com
]

{ #category : #protocol }
CNBExpandingBoxes >> open: shape [
	| children |
	children := shape model models 
		collect: [ :model | self nodeFor: model ].
	shape addAll: children.
	self update.
]

{ #category : #'events-processing' }
CNBExpandingBoxes >> processEvent: evt [
	| shape |
	shape := evt shape.
	shape children
		ifEmpty: [ self open: shape]
		ifNotEmpty: [ self close: shape ].
]

{ #category : #updating }
CNBExpandingBoxes >> relayout: shape [
	shape propertyAt: #original put: shape encompassingRectangle.
	
	shape shapes do: [ :s | self relayout: s ].
	RSGridLayout on: shape shapes.
	shape adjustToChildren.
	shape padding: 10.
]

{ #category : #running }
CNBExpandingBoxes >> run [
	<script: 'self new run'>
		| cNBViewModel |
	cNBViewModel := (DMClassNamesBlueprintSample projectNameMatches: 'calypso*') viewModel.
	canvas add: (self nodeFor: cNBViewModel ).
	self update.
	canvas open
]

{ #category : #updating }
CNBExpandingBoxes >> saveCurrent: shape [
	shape children do: [ :s | self saveCurrent: s ].
	shape propertyAt: #current put: shape encompassingRectangle.
]

{ #category : #updating }
CNBExpandingBoxes >> scale: shape at: t [
	| rect1 rect2 |
	shape children do: [ :s | self scale: s at: t ].
	rect1 := shape propertyAt: #original ifAbsent: [ ^ self].
	
	rect2 := shape propertyAt: #current.
	
		
	shape translateTo: (rect1 floatCenter interpolateTo: rect2 floatCenter at: t).
	
	shape extent: (rect1 extent interpolateTo: rect2 extent at: t)
]

{ #category : #updating }
CNBExpandingBoxes >> update [
	| first |
	first := canvas shapes first.
	self relayout: first.
	self saveCurrent: first.
	canvas newAnimation
		onStepDo: [ :t |
			self scale: first at: t.
			self zoomCanvans.
			canvas signalUpdate. 
			 ].
]

{ #category : #updating }
CNBExpandingBoxes >> zoomCanvans [
	canvas zoomToFit
	canvas camera scale: 1.
]
