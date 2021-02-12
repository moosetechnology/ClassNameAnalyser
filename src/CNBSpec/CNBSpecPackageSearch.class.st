Class {
	#name : #CNBSpecPackageSearch,
	#superclass : #SpSearchInputFieldPresenter,
	#category : #CNBSpec
}

{ #category : #initialization }
CNBSpecPackageSearch >> initialize [ 
	super initialize.
	placeholder := 'Search...'
]

{ #category : #running }
CNBSpecPackageSearch >> run [
	<script: 'self new openModalWithSpec'>
]
