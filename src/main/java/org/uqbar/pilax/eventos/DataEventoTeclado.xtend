package org.uqbar.pilax.eventos

import com.trolltech.qt.core.Qt.MouseButton
import org.eclipse.xtext.xbase.lib.Pair
import org.uqbar.pilax.engine.Tecla

/**
 * En pilas esto es simplemente un mapa.
 * Acá mejor tiparlo.
 * La idea es que los diferentes tipos de evento (ahora se llaman Evento)
 * al ejecutar sus handlers les pasan diferentes instances de subclases de DataEvento.
 * Por ejemplo un evento de click de mouse tendrá información sobre el boton apretado.
 * En cambio el del teclado tendrá teclas. Y el de "dibujar" no tiene datos.
 * Estos objetos no son polimorficos !
 */
class DataEvento {
	
}

class DataEventoTeclado extends DataEvento {
	@Property Tecla tecla
	@Property boolean esRepeticion
	@Property String texto
	
	new(Tecla tecla, boolean autoRepeat, String texto) {
		this.tecla = tecla
		this.esRepeticion = autoRepeat
		this.texto = texto
	}
	
}

class DataEventoRuedaMouse extends DataEvento {
	@Property int delta
	
	new(int delta) {
		this.delta = delta
	}
	
}

class DataEventoMouse extends DataEventoMovimiento {
	@Property MouseButton boton
	
	new(Pair<Float, Float> pos, Pair<Float,Float> delta, MouseButton boton) {
		super(pos, delta)
		this.boton = boton
	}
	
}

class DataEventoMovimiento extends DataEvento {
	@Property Pair<Float,Float> posicion
	@Property Pair<Float,Float> delta
	
	new(Pair<Float,Float> posicion, Pair<Float,Float> delta) {
		this.posicion = posicion
		this.delta = delta
	}
	
//	new(Float x, Float y, Float dx, Float dy) {
//		posicion = x -> y
//		delta = dx -> dy
//	}
}