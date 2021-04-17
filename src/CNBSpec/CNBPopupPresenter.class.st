Class {
	#name : #CNBPopupPresenter,
	#superclass : #MiPresenter,
	#instVars : [
		'help',
		'okButton'
	],
	#category : #CNBSpec
}

{ #category : #specs }
CNBPopupPresenter class >> defaultSpec [
	^ SpBoxLayout newHorizontal
		borderWidth: 5;
		add:
			(SpBoxLayout newVertical
				spacing: 5;
				add: #help height: 250;
				add: #okButton height: self buttonHeight;
				yourself)
			width: 250;
		yourself
]

{ #category : #api }
CNBPopupPresenter >> dismiss [
	self owner dismiss
]

{ #category : #initialization }
CNBPopupPresenter >> initializePresenters [
	super initializePresenters.
]
