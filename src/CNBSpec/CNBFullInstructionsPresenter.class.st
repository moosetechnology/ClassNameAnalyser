"
I am the presenter for showing packages, adding and deleting all in the tool.
"
Class {
	#name : #CNBFullInstructionsPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'closeButton',
		'seeDocumentationButton',
		'instructions'
	],
	#category : #CNBSpec
}

{ #category : #accessing }
CNBFullInstructionsPresenter class >> defaultExtent [
	^ 500 @ 500
]

{ #category : #specs }
CNBFullInstructionsPresenter class >> defaultSpec [ 

	^ (SpBoxLayout newVertical 
		spacing: 2;
		add: #instructions;
		add: (SpBoxLayout newHorizontal
				add: #closeButton;
				add: '';
				add: #seeDocumentationButton;
				yourself) expand: false; yourself
	)
]

{ #category : #accessing }
CNBFullInstructionsPresenter class >> defaultTitle [
	^ 'Full Instructions'
]

{ #category : #examples }
CNBFullInstructionsPresenter class >> open [
	<example>
	self new openWithSpec 
]

{ #category : #accessing }
CNBFullInstructionsPresenter >> closeButton [
	^ closeButton 
]

{ #category : #initialization }
CNBFullInstructionsPresenter >> connectPresenters [ 
	super connectPresenters.
	
"	closeButton action: [ self onCloseClicked  ].
	seeDocumentationButton action: [ self onSeeDocumentationClicked ]"
	

				
				
]

{ #category : #'as yet unclassified' }
CNBFullInstructionsPresenter >> initializeInstructions [

	| intro leftClick rightClick pause deHighlight pattern stream|
	stream := (String new: 300) writeStream.
	pause := '*********************************'.
	intro := 'Here are some instructions you might want to use when navigating the tool.'.
	leftClick := 'Left click on a class box: Highlights the whole hierarchy of the selected class. An other click at a class from the same hierarchy resets the highlight'.
	deHighlight 
		:= 'Left click on a package/token box: resets the highlight.'.
	rightClick := 'Right click on a class box: Opens the class browser in case the class is in the system or the Famix model of the class in case of an MSE file'.
	pattern := 'When selecting a pattern, class tokens following the selected pattern are highlighted.'.
	 stream nextPutAll: intro; cr; nextPutAll: pause; cr;
				nextPutAll: leftClick ; cr; nextPutAll: pause; cr;
				nextPutAll: deHighlight ; cr ;nextPutAll: pause; cr;
				nextPutAll: rightClick ; cr ; nextPutAll: pause; cr;
				nextPutAll: pattern ; cr ; nextPutAll: pause; cr.
	instructions := self instantiate: SpTextPresenter.
	instructions text: stream contents asString.
			
	
	
]

{ #category : #initialization }
CNBFullInstructionsPresenter >> initializePresenters [
	super initializePresenters.
	
	closeButton := self newButton label: 'Close'.
	seeDocumentationButton := self newButton label: 'See Documentation'.
	self initializeInstructions.
	

	
]

{ #category : #initialization }
CNBFullInstructionsPresenter >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	
	aWindowPresenter
		title: self class defaultTitle;
		initialExtent: self class defaultExtent
]

{ #category : #accessing }
CNBFullInstructionsPresenter >> instructions [ 
	^ instructions
]

{ #category : #'as yet unclassified' }
CNBFullInstructionsPresenter >> onCloseClicked [
]

{ #category : #'as yet unclassified' }
CNBFullInstructionsPresenter >> onSeeDocumentationClicked [
]

{ #category : #accessing }
CNBFullInstructionsPresenter >> seeDocumentationButton [

	^ seeDocumentationButton
]
