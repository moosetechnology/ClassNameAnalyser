Class {
	#name : #CNBInstructionsPopupPresenter,
	#superclass : #CNBPopupPresenter,
	#category : #CNBSpec
}

{ #category : #'as yet unclassified' }
CNBInstructionsPopupPresenter class >> instructions [ 

	| leftClick rightClick |
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
