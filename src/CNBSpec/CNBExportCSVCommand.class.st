"
I am responsible for exporting the CSV file of the Analysis description of the ClassNames Distribution.
"
Class {
	#name : #CNBExportCSVCommand,
	#superclass : #CmCommand,
	#category : #CNBSpec
}

{ #category : #default }
CNBExportCSVCommand class >> defaultDescription [ 
	^ 'Export visualisation Data into CSV file'
]

{ #category : #default }
CNBExportCSVCommand class >> defaultName [
	^ 'To CSV'
]

{ #category : #default }
CNBExportCSVCommand class >> forSpecContext: anObject [
	^ (super forSpecContext: anObject)
		iconNamed: #smallExport;
		beHiddenWhenCantBeRun;
		yourself
]

{ #category : #accessing }
CNBExportCSVCommand >> category [

	^ 'Import'
]

{ #category : #executing }
CNBExportCSVCommand >> execute [ 
	
	| file |
    file := UIManager default
                chooseForSaveFileReference: 'Chose export destination'
                extensions: #( 'csv' )
                path: 'Data.csv'.
    file ifNotNil: [ 
        context exportTo: file.
        UIManager default
            inform: 'Data exported.
				Click to show in folder'
            actionOnClick: [ file openInOSFileBrowser ] ]


]
