package org.uqbar.pilax.engine

import com.trolltech.qt.core.Qt.MouseButton

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
	@Property Object codigoDeTecla
	@Property boolean esRepeticion
	@Property String texto
	
	new(Object codigoDeTecla, boolean autoRepeat, String texto) {
		this.codigoDeTecla = codigoDeTecla
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
	
	new(Float x, Float y, Float dx, Float dy, MouseButton boton) {
		super(x, y, dx, dy)
		this.boton = boton
	}
	
}

class DataEventoMovimiento extends DataEvento {
	@Property float x
	@Property float y
	@Property float dx
	@Property float dy
	
	new(Float x, Float y, Float dx, Float dy) {
		this.x = x
		this.y = y
		this.dx = dx
		this.dy = dy
	}
}