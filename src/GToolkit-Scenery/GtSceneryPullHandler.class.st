"
I'm a `BlPullHandler` that does not listen to CTRL events (so they can be handled by the `GtSceneryDragHandler` instead).

AS says: in the future if you see that you have another case when you would like to prevent an existing event handler from handling events based on some condition you can decorate that event handler with an event handler decorator that checks the condition and then forwards the event if condition is met. Something like `BlEventForwarder`.

ON: I looked but do not see how that would be simpler ...

NB: This class was cloned from HyperlinkDragHandler in the IMAD project and modified.

"
Class {
	#name : #GtSceneryPullHandler,
	#superclass : #BlPullHandler,
	#category : #'GToolkit-Scenery-UI'
}

{ #category : #'event handling' }
GtSceneryPullHandler >> wantsEvent: anEvent [
	"I ignore Control events"
	^ (super wantsEvent: anEvent) and: [ anEvent modifiers isCtrl not ]
]
