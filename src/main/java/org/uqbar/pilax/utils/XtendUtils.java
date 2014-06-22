package org.uqbar.pilax.utils;

import org.eclipse.xtext.xbase.lib.Procedures.Procedure0;

/**
 * @author jfernandes
 */
public class XtendUtils {
	
	public static void synched(Object target, Procedure0 procedure) {
		synchronized (target) {
			procedure.apply();
		}
	}

}
