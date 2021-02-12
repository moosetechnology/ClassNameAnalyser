Class {
	#name : #CNBSpecView,
	#superclass : #SpRoassalPresenter,
	#category : #CNBSpec
}

{ #category : #initialization }
CNBSpecView >> initialize [ 
	| roassal3SpecView |
	super initialize.
	roassal3SpecView := self instantiate: SpRoassalPresenter.
	self script: [ :canvas | CNBRoassal3Builder mooseOn: canvas ]. 
]

{ #category : #running }
CNBSpecView >> run [
	<script: 'self new openWithSpec'>
]
