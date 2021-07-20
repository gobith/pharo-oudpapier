Class {
	#name : #GeoOPActionAddUser,
	#superclass : #GeoOPAction,
	#instVars : [
		'id',
		'name',
		'email',
		'phoneNumber',
		'password'
	],
	#category : #'Geo Oudpapier Persistency'
}

{ #category : #private }
GeoOPActionAddUser class >> headerString [

	^'AddUser'
]

{ #category : #actions }
GeoOPActionAddUser >> doIt [

	id := schedule nextUserId. 
	password := schedule nextPassword. 
	schedule
		addUser:
			(GeoOPUser new
				id: id;
				name: name;
				email: email;
				phoneNumber: phoneNumber;
				password: password;
				yourself).
	self persist
]

{ #category : #accessing }
GeoOPActionAddUser >> email [
	^ email
]

{ #category : #accessing }
GeoOPActionAddUser >> email: anObject [
	email := anObject
]

{ #category : #actions }
GeoOPActionAddUser >> fileIn [
	id := (substrings at: 3) asInteger.
	name := substrings at: 4.
	email := substrings at: 5.
	phoneNumber := substrings at: 6.
	password := substrings at: 7.
	schedule
		addUser:
			(GeoOPUser new
				id: id;
				name: name;
				email: email;
				phoneNumber: phoneNumber;
				password: password;
				yourself).
	self addToSchedule
]

{ #category : #accessing }
GeoOPActionAddUser >> id [
	^ id
]

{ #category : #accessing }
GeoOPActionAddUser >> id: anObject [
	id := anObject
]

{ #category : #accessing }
GeoOPActionAddUser >> name [
	^ name
]

{ #category : #accessing }
GeoOPActionAddUser >> name: anObject [
	name := anObject
]

{ #category : #accessing }
GeoOPActionAddUser >> password [
	^ password
]

{ #category : #accessing }
GeoOPActionAddUser >> password: anObject [
	password := anObject
]

{ #category : #persistence }
GeoOPActionAddUser >> persistenceString [
	| ws |
	ws := WriteStream on: String new.
	self addHeaderOn: ws.
	ws
		print: id;
		nextPut: self separator;
		nextPutAll: name;
		nextPut: self separator;
		nextPutAll: email;
		nextPut: self separator;
		nextPutAll: phoneNumber;
		nextPut: self separator;
		nextPutAll: password.
	^ ws contents
]

{ #category : #accessing }
GeoOPActionAddUser >> phoneNumber [
	^ phoneNumber
]

{ #category : #accessing }
GeoOPActionAddUser >> phoneNumber: anObject [
	phoneNumber := anObject
]

{ #category : #printing }
GeoOPActionAddUser >> prettyStringOn: ws [

	super prettyStringOn: ws.
	ws tab; nextPutAll: name
]
