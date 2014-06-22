package org.uqbar.pilax.motor

import com.trolltech.qt.gui.QFont
import com.trolltech.qt.gui.QFontDatabase
import com.trolltech.qt.gui.QFontMetrics
import com.trolltech.qt.gui.QPainter
import java.awt.Color
import java.util.Map
import org.eclipse.xtext.xbase.lib.Pair
import org.uqbar.pilax.motor.qt.Motor
import org.uqbar.pilax.utils.Utils

import static extension org.uqbar.pilax.motor.qt.QtExtensions.*
import static extension org.uqbar.pilax.utils.PilasExtensions.*

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

    override dibujarPixmap(QPainter painter, double dx, double dy) {
        //PILAX
        val nombre_de_fuente = if (this.fuente != null) 
        							cargar_fuente_desde_cache(this.fuente)
        						else
            						painter.font().family()

        val laFuente = new QFont(nombre_de_fuente, this.magnitud)
        val metrica = new QFontMetrics(laFuente)

       	painter.pen = color.asQColor
        painter.font = laFuente

		val lines =
//        if (this.vertical)
//          [t for t in self.texto]
//        else:
            this.texto.split('\n')

		var auxdy = dy
        for (line : lines) {
            painter.drawText(dx.intValue, (auxdy + this.alto).intValue, line)
            auxdy = auxdy + metrica.height
        }
	}
	

    /**
     * Carga o convierte una fuente para ser utilizada dentro del motor.
     *
     * Permite a los usuarios referirse a las fuentes como ruta a archivos, sin
     *  tener que preocuparse por el font-family.
	 *
     * :param fuenteComoRuta: Ruta al archivo TTF que se quiere utilizar.
	 *	
     *  Ejemplo:
	 *
     *      >>> Texto.cargar_fuente_desde_cache('myttffile.ttf')
     *      'Visitor TTF1'
     */    
    def static String cargar_fuente_desde_cache(String fuenteComoRuta) {
        var int idFuente
        if (!CACHE_FUENTES.containsKey(fuenteComoRuta)) {
            idFuente = QFontDatabase.addApplicationFont(Utils.obtenerRutaAlRecurso(fuenteComoRuta))
            CACHE_FUENTES.put(fuenteComoRuta, idFuente)
        }
        else
            idFuente = CACHE_FUENTES.get(fuenteComoRuta)

        return QFontDatabase.applicationFontFamilies(idFuente).first
    }

    override getAncho() {
        areaTexto.key
    }

    override getAlto() {
        areaTexto.value
    }
}