package org.uqbar.pilax.engine

import org.eclipse.xtext.xbase.lib.Procedures.Procedure0
import java.util.Iterator
import org.eclipse.xtext.xbase.lib.Procedures.Procedure2

interface ActorListener {
	
	def void eliminar(Actor actor, EventChain chain)
	
}

interface EventChain {
	
	def void proceed(Actor actor)
	
}

class EventChainImpl implements EventChain {
	Procedure2<ActorListener, EventChain> listenerCaller
	Iterator<ActorListener> listeners
	Procedure0 realTask
	
	new(Iterator<ActorListener> listeners, Procedure2<ActorListener, EventChain> listenerCaller, Procedure0 realTask) {
		this.listeners = listeners
		this.listenerCaller = listenerCaller
		this.realTask = realTask
	}
	
	override proceed(Actor actor) {
		if (listeners.hasNext)
			listenerCaller.apply(listeners.next, this)
		else 
			realTask.apply
	}

}