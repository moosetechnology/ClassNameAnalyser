Class {
	#name : #CNBInstructionsPopupPresenter,
	#superclass : #CNBPopupPresenter,
	#category : #CNBSpec
}

{ #category : #'as yet unclassified' }
CNBInstructionsPopupPresenter class >> instructions [ 

	| intro leftClick rightClick pause stream deHighlight pattern |
	stream := (String new: 300) writeStream.
	pause := '*********************************'.
	intro := 'Here are some instructions you might want to use when navigating the tool.'.
	leftClick := 'Left click: Highlights the whole hierarchy of the selected class.'.
	deHighlight 
		:= 'Package/Token or Reset button click: resets the highlight to the initial state of the visualisation.'.
	rightClick := 'Right click: Opens the class browser in case the class is in the system or the Famix model of the class in case of an MSE file'.
	pattern := 'When selecting a pattern, class tokens following the selected pattern are highlighted.'.
	 stream nextPutAll: intro; cr; nextPutAll: pause; cr;
				nextPutAll: leftClick ; cr; nextPutAll: pause; cr;
				nextPutAll: deHighlight ; cr ;nextPutAll: pause; cr;
				nextPutAll: rightClick ; cr ; nextPutAll: pause; cr;
				nextPutAll: pattern ; cr ; nextPutAll: pause; cr.
	^ stream contents
			
	
	
]

{ #category : #initialization }
CNBInstructionsPopupPresenter >> initializePresenters [
	super initializePresenters.
	help := self newText text: self class instructions.
	okButton := self newButton 
		label: 'Ok';
		action: [ self owner dismiss ];
		yourself
]
