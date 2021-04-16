Class {
	#name : #CNBHelpPopup,
	#superclass : #MiHelpPopup,
	#category : #CNBSpec
}

{ #category : #initialization }
CNBHelpPopup >> initializePresenters [
	super initializePresenters.
	help := self newText text: browser class comment.
	okButton := self newButton
		label: 'Ok';
		action: [ self owner dismiss ];
		yourself
]
