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
	patterns := { 	#'-------' .
		            #'Fat Blob' .
		            #'Snow Flakes'.
		            #'Homogeneity Breaker'.
		            #'Intruders'.
		            #'Confetti'.
		            #'Homogeneous'.
		            #'Scattered Vocabulary' }.

	self
		help: 'Choose a pattern';
		items: self patterns;
		display: [ :aPattern | aPattern ]
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
