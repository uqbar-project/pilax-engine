package org.uqbar.pilax.engine

import com.trolltech.qt.gui.QFont
import com.trolltech.qt.gui.QFontMetrics
import com.trolltech.qt.gui.QPainter
import java.awt.Color
import org.eclipse.xtext.xbase.lib.Pair
import org.uqbar.pilax.engine.motor.ImagenMotor

import static extension org.uqbar.pilax.engine.PilasExtensions.*
import java.util.Map
import com.trolltech.qt.gui.QFontDatabase

/**
 * 
 */
 //RENAME: TextoMotor
class TextoMotor extends ImagenMotor {
	// TODO: habilitar cache !
    static Map<String, Integer> CACHE_FUENTES = newHashMap()
    @Property boolean vertical
    @Property int magnitud
    @Property String fuente
    @Property Color color
    @Property String texto
    Pair<Integer,Integer> areaTexto

    new(String texto, int magnitud, Motor motor, boolean vertical, String fuente) {
    	this.texto = texto
        this.vertical = vertical
        this.fuente = fuente
        this.magnitud = magnitud
        this.areaTexto = motor.obtenerAreaDeTexto(texto, magnitud, vertical, fuente)
    }

    override dibujarPixmap(QPainter painter, int dx, int dy) {
        //PILAX
        val nombre_de_fuente = if (this.fuente != null) 
        							cargar_fuente_desde_cache(this.fuente)
        						else
            						painter.font().family()

        val laFuente = new QFont(nombre_de_fuente, this.magnitud)
        val metrica = new QFontMetrics(laFuente)

       	painter.setPen(color.asQColor)
        painter.setFont(laFuente)

		val lines =
//        if (this.vertical)
//          [t for t in self.texto]
//        else:
            this.texto.split('\n')

		var auxdy = dy
        for (line : lines) {
            painter.drawText(dx, auxdy + this.alto, line)
            auxdy = auxdy + metrica.height()
        }
	}
	

    /**
     * Carga o convierte una fuente para ser utilizada dentro del motor.
     *
     * Permite a los usuarios referirse a las fuentes como ruta a archivos, sin
     *  tener que preocuparse por el font-family.
	 *
     * :param fuente_como_ruta: Ruta al archivo TTF que se quiere utilizar.
	 *	
     *  Ejemplo:
	 *
     *      >>> Texto.cargar_fuente_desde_cache('myttffile.ttf')
     *      'Visitor TTF1'
     */    
    def static String cargar_fuente_desde_cache(String fuente_como_ruta) {
        var int fuente_id
        if (!CACHE_FUENTES.containsKey(fuente_como_ruta)) {
            val ruta_a_la_fuente = Utils.obtenerRutaAlRecurso(fuente_como_ruta)
            fuente_id = QFontDatabase.addApplicationFont(ruta_a_la_fuente)
            CACHE_FUENTES.put(fuente_como_ruta, fuente_id)
        }
        else
            fuente_id = CACHE_FUENTES.get(fuente_como_ruta)

        return QFontDatabase.applicationFontFamilies(fuente_id).first
    }

    override ancho() {
        areaTexto.key
    }

    override alto() {
        areaTexto.value
    }
}