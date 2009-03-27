# -*- coding: iso-8859-1 -*-
#! /usr/bin/python
##Copyright 2008 Jelle Feringa
##
##jelle.feringa@gmail.com
##
##pythonOCC is a computer program whose purpose is to provide a complete set
##of python bindings for OpenCasacde library.
##
##This software is governed by the CeCILL license under French law and
##abiding by the rules of distribution of free software.  You can  use, 
##modify and/ or redistribute the software under the terms of the CeCILL
##license as circulated by CEA, CNRS and INRIA at the following URL
##"http://www.cecill.info". 
##
##As a counterpart to the access to the source code and  rights to copy,
##modify and redistribute granted by the license, users are provided only
##with a limited warranty  and the software's author,  the holder of the
##economic rights,  and the successive licensors  have only  limited
##liability. 
##
##In this respect, the user's attention is drawn to the risks associated
##with loading,  using,  modifying and/or developing or reproducing the
##software by the user in light of its specific status of free software,
##that may mean  that it is complicated to manipulate,  and  that  also
##therefore means  that it is reserved for developers  and  experienced
##professionals having in-depth computer knowledge. Users are therefore
##encouraged to load and test the software's suitability as regards their
##requirements in conditions enabling the security of their systems and/or 
##data to be ensured and,  more generally, to use and operate it in the 
##same conditions as regards security. 
##
##The fact that you are presently reading this means that you have had
##knowledge of the CeCILL license and that you accept its terms.


'''
TODO:

Hide WireExplorer...

BRepTools.Map3DEdges()
History:
        20-01-2009:    initial version
        23-03-2009:    completed and updated for modular pythonOCC build
'''

#===============================================================================
# showing you how to implement a fillet vertex routine
#===============================================================================


from OCC.BRepPrimAPI import *
from OCC.BRepFilletAPI import *
from OCC.TColgp import *
from OCC.gp import *
from OCC.TopExp import *
from OCC.BRep import *

from OCC.Utils.Topology import Topo
from examples_gui import display, loop

cube = BRepPrimAPI_MakeBox(100,100,100).Shape()
topo = Topo(cube)
vertex_iterator = topo.vertices()
vertA  = vertex_iterator.next()
#vertex_iterator.next()
#vertex_iterator.next()
#vertex_iterator.next()
#vertex_iterator.next()
#vertex_iterator.next()
#vertex_iterator.next()
#vertex_iterator.next()
#vertex_iterator.next()

vertB = vertex_iterator.next()

def vertex_fillet(cube, vert):
    afillet = BRepFilletAPI_MakeFillet(cube)
    cnt = 0
    for edg in topo.edges_from_vertex(vert):
        first, last = TopExp().FirstVertex(edg), TopExp().LastVertex(edg)
        vertex, first_vert, last_vert = BRep_Tool().Pnt(vert), BRep_Tool().Pnt(first), BRep_Tool().Pnt(last)
        if edg.Orientation():
            if not vertex.IsEqual(first_vert, 0.001):
                afillet.Add(0, 20., edg)
            else:
                afillet.Add(20, 0, edg)
            cnt+=1
    
    afillet.Build()
    if afillet.IsDone():
        return afillet.Shape()
    else:
        raise AssertionError, 'you failed on me you fool!'

filleted_vertA = vertex_fillet(cube,vertA)
#filleted_vert = vertex_fillet(filleted_vertA,vertA)


try:
    from occ_utils import shape_to_file
    pth = '/Volumes/DATA/Jelle_prive/Jelle_dev/workspace/SVN/pythonocc/occ_examples/'
    shape_to_file(filleted_vertA, pth, 'vertex_fillet_cube')
except ImportError:
    print 'failed writing iges file'
    pass 

display.DisplayShape(filleted_vertA)
loop()


from OCC.BRepTools import *













