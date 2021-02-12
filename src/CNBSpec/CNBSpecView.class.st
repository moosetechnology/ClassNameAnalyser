Class {
	#name : #CNBSpecView,
	#superclass : #SpRoassalPresenter,
	#category : #CNBSpec
}

{ #category : #specs }
CNBSpecView class >> defaultSpec [

	self new
		defaultSpec.
]

{ #category : #specs }
CNBSpecView >> defaultSpec [ 
	^SpBoxLayout new
		add: #canvas;yourself
]

{ #category : #initialization }
CNBSpecView >> initialize [ 
	| roassal3SpecView |
	roassal3SpecView := self instantiate: SpRoassalPresenter.
	self script: [ :canvas | CNBRoassal3Builder mooseOn: canvas ]. 
]

{ #category : #running }
CNBSpecView >> run [
	<script: 'self new openWithSpec'>
]
