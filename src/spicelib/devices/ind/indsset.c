/**********
Copyright 1990 Regents of the University of California.  All rights reserved.
Author: 1985 Thomas L. Quarles
**********/

    /* loop through all the devices and 
     * allocate parameter #s to design parameters 
     */

#include "ngspice.h"
#include "smpdefs.h"
#include "cktdefs.h"
#include "inddefs.h"
#include "sperror.h"
#include "suffix.h"

int
INDsSetup(info,inModel)
    SENstruct *info;
    GENmodel *inModel;
{
    INDmodel *model = (INDmodel*)inModel;
    INDinstance *here;

    /*  loop through all the inductor models */
    for( ; model != NULL; model = model->INDnextModel ) {

        /* loop through all the instances of the model */
        for (here = model->INDinstances; here != NULL ;
                here=here->INDnextInstance) {
	    if (here->INDowner != ARCHme) continue;

	    if(here->INDsenParmNo){
                here->INDsenParmNo = ++(info->SENparms);
            }
        }
    }
    return(OK);
}
