Class {
	#name : #CNBSpecRoassalPresenter,
	#superclass : #Object,
	#instVars : [
		'roassalSpecPresenter'
	],
	#category : #CNBSpec
}

{ #category : #initialization }
CNBSpecRoassalPresenter >> initialize [ 
	super initialize.
	roassalSpecPresenter := Sp1RoassalPresenter new.
]

{ #category : #api }
CNBSpecRoassalPresenter >> openWithSpec [ 
	^roassalSpecPresenter openWithSpec 
]

{ #category : #accessing }
CNBSpecRoassalPresenter >> roassalSpecPresenter [
	^roassalSpecPresenter
]

{ #category : #accessing }
CNBSpecRoassalPresenter >> roassalSpecPresenter: aPresenter [
	roassalSpecPresenter := aPresenter 
]
