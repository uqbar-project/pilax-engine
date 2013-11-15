package org.uqbar.pilax.ejemplos.asteroides

import com.google.common.collect.Iterables
import java.util.List
import org.uqbar.pilax.actores.animacion.ActorExplosion
import org.uqbar.pilax.engine.ActorPiedra
import org.uqbar.pilax.engine.Tamanio

import static extension org.uqbar.pilax.utils.PythonUtils.*
import static extension org.uqbar.pilax.utils.PilasExtensions.*

class PiedraEspacial extends ActorPiedra {
	List<PiedraEspacial> piedras
	
	new(List<PiedraEspacial> piedras, int x, int y) {
		this(piedras, x, y, Tamanio.grande)
	}
	
	new(List<PiedraEspacial> piedras, double x, double y, Tamanio tamanio) {
		super(tamanio, x, y, calcularVelocidad, calcularVelocidad)
        this.piedras = piedras
	}
	
	def static double calcularVelocidad() {
		val posibles_velocidades = Iterables.concat(range(-10, -2), range(2, 10))
        choice(posibles_velocidades) / 10d
	}
	
	override eliminar() {
		new ActorExplosion(x, y)
        super.eliminar

        if (tamanio == Tamanio.grande)
            crear_dos_piedras_mas_pequenas(x, y, Tamanio.media)
        else if (tamanio == Tamanio.media)
            crear_dos_piedras_mas_pequenas(x, y, Tamanio.chica)
	}
	
	def crear_dos_piedras_mas_pequenas(double x, double y, Tamanio tamano) {
        piedras.add(new PiedraEspacial(piedras, x, y, tamano))
        piedras.add(new PiedraEspacial(piedras, x, y, tamano))
    }
	
}