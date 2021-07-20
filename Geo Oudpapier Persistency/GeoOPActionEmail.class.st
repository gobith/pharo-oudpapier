Class {
	#name : #GeoOPActionEmail,
	#superclass : #GeoOPAction,
	#instVars : [
		'user',
		'email',
		'message'
	],
	#category : #'Geo Oudpapier Persistency'
}

{ #category : #private }
GeoOPActionEmail class >> headerString [

	^'Email'
]

{ #category : #actions }
GeoOPActionEmail >> doIt [
	
	schedule sendMailMessage: message email: email.
	self persist
]

{ #category : #accessing }
GeoOPActionEmail >> email [
	^ email
]

{ #category : #accessing }
GeoOPActionEmail >> email: anObject [
	email := anObject
]

{ #category : #actions }
GeoOPActionEmail >> fileIn [
	
	user := schedule userAt: (substrings at: 3) asInteger.
	email := substrings at: 4.
	
	self addToSchedule
]

{ #category : #accessing }
GeoOPActionEmail >> message [
	^ message
]

{ #category : #accessing }
GeoOPActionEmail >> message: anObject [
	message := anObject
]

{ #category : #persistence }
GeoOPActionEmail >> persistenceString [
	| ws |
	ws := WriteStream on: String new.
	self addHeaderOn: ws.
	ws
		print: user id;
		nextPut: self separator;
		nextPutAll: email.
	^ ws contents
]

{ #category : #printing }
GeoOPActionEmail >> prettyStringOn: ws [


	super prettyStringOn: ws.
	ws
		tab;
		nextPutAll: user name";
		cr;
		nextPutAll: '<p>';
		print: (message ifNil: 'nvt' ifNotNil: [message text]);
		nextPutAll: '</p>'"
]

{ #category : #accessing }
GeoOPActionEmail >> user [
	^ user
]

{ #category : #accessing }
GeoOPActionEmail >> user: anObject [
	user := anObject
]
