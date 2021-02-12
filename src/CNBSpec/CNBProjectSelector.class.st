Class {
	#name : #CNBProjectSelector,
	#superclass : #SpLabelledTextInput,
	#category : #CNBSpec
}

{ #category : #running }
CNBProjectSelector >> initialize [
	super initialize.
	self input placeholder: 'ProjectNameMatches: ...*'.
	self label: 'Please enter a project name or the path'.
	
	
]

{ #category : #running }
CNBProjectSelector >> run [ 
	<script: 'self new openWithSpec extent: 400@25'>
	
]
