Class {
	#name : #GeoOPExchangeDayTemplate,
	#superclass : #Object,
	#instVars : [
		'step1DateAndTime',
		'step2DateAndTimes'
	],
	#category : #'Geo Oudpapier Domain'
}

{ #category : #'initialize-release' }
GeoOPExchangeDayTemplate >> reset [
	step1DateAndTime := step2DateAndTimes := nil
]

{ #category : #accessing }
GeoOPExchangeDayTemplate >> step1DateAndTime [
	^ step1DateAndTime
]

{ #category : #accessing }
GeoOPExchangeDayTemplate >> step1DateAndTime: anObject [
	step1DateAndTime := anObject
]

{ #category : #testing }
GeoOPExchangeDayTemplate >> step1Done [
	^ step1DateAndTime notNil
]

{ #category : #accessing }
GeoOPExchangeDayTemplate >> step2DateAndTimes [
	^ step2DateAndTimes
]

{ #category : #accessing }
GeoOPExchangeDayTemplate >> step2DateAndTimes: anObject [
	step2DateAndTimes := anObject
]
