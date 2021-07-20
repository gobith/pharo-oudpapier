Class {
	#name : #GeoOPUserStatusICanNot,
	#superclass : #GeoOPUserStatusNotParticipating,
	#category : #'Geo Oudpapier Domain'
}

{ #category : #accessing }
GeoOPUserStatusICanNot class >> statusSymbol [

	^#iCanNot
]

{ #category : #accessing }
GeoOPUserStatusICanNot class >> userStatusString [

	^'Ik Kan Niet'
]

{ #category : #testing }
GeoOPUserStatusICanNot >> canChoose [

	^true
]

{ #category : #accessing }
GeoOPUserStatusICanNot >> color [

	^Color red
]

{ #category : #accessing }
GeoOPUserStatusICanNot >> nextAdminStatusesOn: coll user: aUser [
	coll add: self iCanStatus
]

{ #category : #accessing }
GeoOPUserStatusICanNot >> registrationStatusesOn: aCollection [
	
	aCollection
		add: self iCanStatus;
		add: self iCannotStatus
]

{ #category : #accessing }
GeoOPUserStatusICanNot >> userButtonString [

	^'Ik Kan Niet'
]
