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
	patterns :=  { ('Flat Blob'-> 'Condition') . ('Snow Flakes'-> 'Condition') . ('Homogeneity Breaker' -> 'Condition') . ('Intruders' -> 'Condition') . ('Confetti' -> 'Condition'). ('Homogeneous' -> 'Condition') . ('Scattered Vocabulary' -> 'Condition')} asDictionary.
	
	(self 
		help: 'Choose a pattern';
		items: self patternsNames;
		display: [ :aPattern | aPattern ];
		whenSelectedItemChangedDo: [ :aPattern | aPattern crTrace ])
		
		
		
]

{ #category : #initialization }
CNBSpecElementDropList >> items [

	^self patternsNames.
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
CNBSpecElementDropList >> patternsNames [
	^patterns keys
]

{ #category : #initialization }
CNBSpecElementDropList >> run [ 
	<script: 'self new openWithSpec extent: 400 @ 25'>
	
]

{ #category : #initialization }
CNBSpecElementDropList >> title [
	^'Patterns'
]
