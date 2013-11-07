package org.uqbar.pilax.fisica.box2d

import java.util.Iterator
import org.jbox2d.dynamics.Body
import org.jbox2d.dynamics.Fixture

class BodyIterator implements Iterator<Body> {
	Body current
	
	new(Body body) {
		current = body
	}
	
	override hasNext() {
    	current.next != null
    }
    
	override next() {
		current = current.next
		current
	}
	
	override remove() {
		throw new UnsupportedOperationException("Doesn't support removing elements!")
	}
	
}

class FixtureIterator implements Iterator<Fixture> {
	Fixture current
	
	new(Fixture body) {
		current = body
	}
	
	override hasNext() {
    	current.next != null
    }
    
	override next() {
		current = current.next
		current
	}
	
	override remove() {
		throw new UnsupportedOperationException("Doesn't support removing elements!")
	}
	
}