"
I am the drop list of the patterns predefined.
"
Class {
	#name : #CNBSpecElementDropList,
	#superclass : #SpDropListPresenter,
	#instVars : [
		'patterns'
	],
	#category : #CNBSpec
}

{ #category : #specs }
CNBSpecElementDropList class >> defaultSpec [
	<spec: #default>
	^ SpAbstractWidgetLayout for: self adapterName
]

{ #category : #initialization }
CNBSpecElementDropList >> initialize [

	super initialize.
	patterns := { 	NoPattern new .
		            CNBFatBlobPattern new .
		            CNBSnowFlakesPattern new .
		           	CNBHomogeneityBreakerPattern new .
		            CNBIntruderPattern new .
		            CNBConfettiPattern new .
		            CNBHomogeneousPattern new .
		            CNBScatteredVocabularyPattern new }.

	self
		items: self patterns;
		display: [ :aPattern | aPattern name ];
		whenSelectedItemChangedDo: [ self help: 'ChangedItem' ].
]

{ #category : #initialization }
CNBSpecElementDropList >> items [

	^ self patterns .
]

{ #category : #initialization }
CNBSpecElementDropList >> patterns [ 
	^patterns
]

{ #category : #initialization }
CNBSpecElementDropList >> patterns: aDictionary [
	patterns := aDictionary
]

{ #category : #initialization }
CNBSpecElementDropList >> run [ 
	<script: 'self new openWithSpec extent: 400 @ 25'>
	
]

{ #category : #initialization }
CNBSpecElementDropList >> title [
	^'Patterns'
]
