"
I am the popup of the instructions in the tool.
"
Class {
	#name : #CNBInstructionsPopupPresenter,
	#superclass : #CNBPopupPresenter,
	#category : #CNBSpec
}

{ #category : #initialization }
CNBInstructionsPopupPresenter >> initializePresenters [
	super initializePresenters.
	help := self newText text: self class instructions.
	okButton := self newButton 
		label: 'Ok';
		action: [ self owner dismiss ];
		yourself
]
