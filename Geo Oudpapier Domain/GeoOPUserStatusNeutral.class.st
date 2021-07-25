Class {
	#name : #GeoOPUserStatusNeutral,
	#superclass : #GeoOPUserStatusNotParticipating,
	#category : #'Geo Oudpapier Domain'
}

{ #category : #accessing }
GeoOPUserStatusNeutral class >> statusSymbol [

	^#neutral
]

{ #category : #accessing }
GeoOPUserStatusNeutral class >> userStatusString [

	^'Nog Niet Gekozen'
]

{ #category : #accessing }
GeoOPUserStatusNeutral >> nextAdminStatusesOn: coll [
	coll
		add: self iCanStatus;
		add: self iCannotStatus
]

{ #category : #accessing }
GeoOPUserStatusNeutral >> nextAdminStatusesOn: coll user: aUser [
	coll
		add: self iCanStatus;
		add: self iCannotStatus
]

{ #category : #accessing }
GeoOPUserStatusNeutral >> registrationStatusesOn: aCollection [
	
	aCollection
		add: self iCanStatus;
		add: self iCannotStatus
]
