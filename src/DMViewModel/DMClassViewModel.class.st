Class {
	#name : #DMClassViewModel,
	#superclass : #Object,
	#instVars : [
		'class'
	],
	#category : #DMViewModel
}

{ #category : #accessing }
DMClassViewModel >> theClass [
	^ class 
]

{ #category : #accessing }
DMClassViewModel >> theClass: aClass [
	class := aClass 
]
