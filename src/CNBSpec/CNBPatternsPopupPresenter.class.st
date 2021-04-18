Class {
	#name : #CNBPatternsPopupPresenter,
	#superclass : #CNBPopupPresenter,
	#category : #CNBSpec
}

{ #category : #'as yet unclassified' }
CNBPatternsPopupPresenter class >> patternsDescription [

	^ ''
]

{ #category : #initialization }
CNBPatternsPopupPresenter >> initializePresenters [
	super initializePresenters.
	help := self newText text: self class patternsDescription.
	okButton := self newButton 
		label: 'Ok';
		action: [ self owner dismiss ];
		yourself
]
