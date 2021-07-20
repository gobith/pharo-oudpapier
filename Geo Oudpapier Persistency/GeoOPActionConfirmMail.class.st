Class {
	#name : #GeoOPActionConfirmMail,
	#superclass : #GeoOPAction,
	#instVars : [
		'partTime'
	],
	#category : #'Geo Oudpapier Persistency'
}

{ #category : #private }
GeoOPActionConfirmMail class >> headerString [

	^'ConfirmMail'
]

{ #category : #actions }
GeoOPActionConfirmMail >> doIt [
	partTime addOneToNrOfSendMail.
	
	schedule sendConfirmMailToUsersFor: partTime.
	
	self persist
]

{ #category : #actions }
GeoOPActionConfirmMail >> fileIn [
	
	partTime := schedule collectionPartTimeAt: (DateAndTime fromSeconds: (substrings at: 3) asInteger).
	
	partTime addOneToNrOfSendMail.
	
	self addToSchedule
]

{ #category : #accessing }
GeoOPActionConfirmMail >> partTime [
	^ partTime
]

{ #category : #accessing }
GeoOPActionConfirmMail >> partTime: anObject [
	partTime := anObject
]

{ #category : #persistence }
GeoOPActionConfirmMail >> persistenceString [
	| ws |
	ws := WriteStream on: String new.
	self addHeaderOn: ws.
	ws
		nextPutAll: partTime dateAndtimeString.
	^ ws contents
]

{ #category : #printing }
GeoOPActionConfirmMail >> prettyStringOn: ws [
	super prettyStringOn: ws.
	ws
		tab;
		nextPutAll: partTime prettyString
]
