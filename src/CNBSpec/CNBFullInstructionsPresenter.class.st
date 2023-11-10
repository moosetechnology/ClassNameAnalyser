"
I am the presenter for showing packages, adding and deleting all in the tool.
"
Class {
	#name : #CNBFullInstructionsPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'instructions'
	],
	#category : #CNBSpec
}

{ #category : #layout }
CNBFullInstructionsPresenter class >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: #instructions;
		  yourself
]

{ #category : #accessing }
CNBFullInstructionsPresenter class >> icon [

	^ self iconNamed: #help
]

{ #category : #specs }
CNBFullInstructionsPresenter class >> initialExtent [

	^ 500 @ 450
]

{ #category : #examples }
CNBFullInstructionsPresenter class >> open [

	<script>
	self new openDialog
]

{ #category : #specs }
CNBFullInstructionsPresenter class >> title [

	^ 'Full Instructions'
]

{ #category : #initialization }
CNBFullInstructionsPresenter >> initializePresenters [

	instructions := self instantiate: MicrodownPresenter.
	instructions document: self instructionsDocument
]

{ #category : #initialization }
CNBFullInstructionsPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: self class title;
		initialExtent: self class initialExtent
]

{ #category : #initialization }
CNBFullInstructionsPresenter >> instructionsDocument [

	^ Microdown parse: (String streamContents: [ :s |
			   s
				   << self introductionText;
				   << self leftClickText;
				   << self rightClickText;
				   << self patternText ])
]

{ #category : #initialization }
CNBFullInstructionsPresenter >> introductionText [

	^ '### How to use the Class Name Analyser\' withCRs
]

{ #category : #initialization }
CNBFullInstructionsPresenter >> leftClickText [

	^ '##### Highlight: Left click
- Left click on a class highlights the whole hierarchy of the selected class.
- An other click at a class from the same hierarchy resets the highlight
- Left click on a package or token resets the highlight.\' withCRs
]

{ #category : #initialization }
CNBFullInstructionsPresenter >> patternText [

	^ '##### Pattern 
When selecting a pattern, class tokens following the selected pattern are highlighted.\'
		  withCRs
]

{ #category : #initialization }
CNBFullInstructionsPresenter >> rightClickText [

	^ '##### Browse: Right click on a class
- opens the pharo class in the browser if it is in the system
- inspects the Moose entity representing the class otherwise\' withCRs
]
