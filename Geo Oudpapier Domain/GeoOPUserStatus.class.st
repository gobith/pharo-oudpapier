Class {
	#name : #GeoOPUserStatus,
	#superclass : #Object,
	#classInstVars : [
		'singleInstance'
	],
	#category : #'Geo Oudpapier Domain'
}

{ #category : #accessing }
GeoOPUserStatus class >> fromSymbol: aStatusSymbol [
	| statusClass |
	statusClass := self allSubclasses
		detect: [ :statusCls | statusCls statusSymbol = aStatusSymbol ]
		ifNone: nil.
	^ statusClass ifNotNil: [ statusClass singleInstance ]
]

{ #category : #accessing }
GeoOPUserStatus class >> new [

	self shouldNotImplement 
]

{ #category : #accessing }
GeoOPUserStatus class >> scheduleStatuses [
	^ {GeoOPUserStatusScheduled.
	GeoOPUserStatusScheduledDriver.
	GeoOPUserStatusConfirmed .
	GeoOPUserStatusConfirmedDriver .
	GeoOPUserStatusICan.
	GeoOPUserStatusICanNot}
		collect: [ :statusClass | statusClass singleInstance ]
]

{ #category : #accessing }
GeoOPUserStatus class >> singleInstance [
	singleInstance
		ifNil: [ singleInstance := self basicNew
				initialize;
				yourself ].
	^ singleInstance
]

{ #category : #accessing }
GeoOPUserStatus class >> status [
	^ {GeoOPUserStatusScheduled.
	GeoOPUserStatusScheduledDriver.
	GeoOPUserStatusConfirmed .
	GeoOPUserStatusConfirmedDriver .
	GeoOPUserStatusICan.
	GeoOPUserStatusICanNot.
	GeoOPUserStatusNeutral}
		collect: [ :statusClass | statusClass singleInstance ]
]

{ #category : #accessing }
GeoOPUserStatus class >> statusSymbol [

	^nil
]

{ #category : #accessing }
GeoOPUserStatus class >> userStatusString [

	self subclassResponsibility 
]

{ #category : #testing }
GeoOPUserStatus >> canChoose [

	^false
]

{ #category : #accessing }
GeoOPUserStatus >> color [

	^nil
]

{ #category : #accessing }
GeoOPUserStatus >> colorString [

	^self color ifNil: [ '' ] ifNotNil: [: color | color asHexString] 
]

{ #category : #'accessing status' }
GeoOPUserStatus >> confirmedDriverStatus [
	^ GeoOPUserStatusConfirmedDriver singleInstance
]

{ #category : #'accessing status' }
GeoOPUserStatus >> confirmedStatus [
	^ GeoOPUserStatusConfirmed singleInstance
]

{ #category : #'accessing status' }
GeoOPUserStatus >> iCanStatus [
	^ GeoOPUserStatusICan singleInstance
]

{ #category : #'accessing status' }
GeoOPUserStatus >> iCannotStatus [
	^ GeoOPUserStatusICanNot singleInstance
]

{ #category : #accessing }
GeoOPUserStatus >> inactiveColorString [

	^self color ifNil: [ '' ] ifNotNil: [: color | color muchLighter asHexString] 
]

{ #category : #testing }
GeoOPUserStatus >> isConfirmed [

	^false
]

{ #category : #testing }
GeoOPUserStatus >> isConfirmedDriver [

	^false
]

{ #category : #testing }
GeoOPUserStatus >> isICan [
	^ false
]

{ #category : #testing }
GeoOPUserStatus >> isParticipating [

	^false
]

{ #category : #testing }
GeoOPUserStatus >> isScheduled [

	^false
]

{ #category : #testing }
GeoOPUserStatus >> isScheduledDriver [

	^false
]

{ #category : #testing }
GeoOPUserStatus >> isScheduledOrConfirmed [
	^ self isScheduled or: [ self isConfirmed ]
]

{ #category : #accessing }
GeoOPUserStatus >> nextAdminStatuses [
	| coll |
	coll := OrderedCollection new.
	self nextAdminStatusesOn: coll.
	^ coll
]

{ #category : #accessing }
GeoOPUserStatus >> nextAdminStatusesFor: aUser [
	| coll |
	coll := OrderedCollection new.
	self nextAdminStatusesOn: coll user: aUser.
	^ coll
]

{ #category : #accessing }
GeoOPUserStatus >> nextAdminStatusesOn: coll [
]

{ #category : #accessing }
GeoOPUserStatus >> nextAdminStatusesOn: coll user: aUser [
]

{ #category : #accessing }
GeoOPUserStatus >> nextConfirmedStatusOrNil [

	^nil
]

{ #category : #accessing }
GeoOPUserStatus >> registrationStatuses [
	| coll |
	coll := OrderedCollection new.
	self registrationStatusesOn: coll.
	^ coll
]

{ #category : #accessing }
GeoOPUserStatus >> registrationStatusesOn: aCollection [
	aCollection add: self
]

{ #category : #'accessing schedule' }
GeoOPUserStatus >> scheduleImageClosed [

	^nil
]

{ #category : #'accessing schedule' }
GeoOPUserStatus >> scheduleImageFinished [

	^nil
]

{ #category : #'accessing schedule' }
GeoOPUserStatus >> scheduleImageOpen [

	^nil
]

{ #category : #'accessing schedule' }
GeoOPUserStatus >> scheduleStringArchived [

	^''
]

{ #category : #'accessing schedule' }
GeoOPUserStatus >> scheduleStringClosed [

	^''
]

{ #category : #'accessing schedule' }
GeoOPUserStatus >> scheduleStringFinished [

	^''
]

{ #category : #'accessing schedule' }
GeoOPUserStatus >> scheduleStringOpen [

	^''
]

{ #category : #'accessing status' }
GeoOPUserStatus >> scheduledDriverStatus [
	^ GeoOPUserStatusScheduledDriver singleInstance
]

{ #category : #'accessing status' }
GeoOPUserStatus >> scheduledStatus [
	^ GeoOPUserStatusScheduled singleInstance
]

{ #category : #accessing }
GeoOPUserStatus >> statusSymbol [

	^self class statusSymbol
]

{ #category : #accessing }
GeoOPUserStatus >> userButtonString [

	^''
]

{ #category : #accessing }
GeoOPUserStatus >> userStatusString [

	^self class userStatusString
]
