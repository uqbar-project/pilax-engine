package org.uqbar.pilax.interpolacion

interface IModel<T> {
	
	def T getValue()
	
	def void setValue(T newValue)
	
}