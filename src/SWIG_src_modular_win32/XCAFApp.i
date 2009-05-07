/*

Copyright 2008-2009 Thomas Paviot (thomas.paviot@free.fr)

This file is part of pythonOCC.

pythonOCC is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

pythonOCC is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with pythonOCC.  If not, see <http://www.gnu.org/licenses/>.

*/
%module XCAFApp

%include XCAFApp_renames.i

%include typemaps.i
%include cmalloc.i
%include cpointer.i
%include carrays.i
%include exception.i
%include std_list.i
%include std_string.i
%include <python/std_basic_string.i>

#ifndef _Standard_TypeDef_HeaderFile
#define _Standard_TypeDef_HeaderFile
#define Standard_False (Standard_Boolean) 0
#define Standard_True  (Standard_Boolean) 1
#endif

/*
Exception handling
*/
%{#include <Standard_Failure.hxx>%}
%exception
{
    try
    {
        $action
    } 
    catch(Standard_Failure)
    {
        SWIG_exception(SWIG_RuntimeError,Standard_Failure::Caught()->DynamicType()->Name());
    }
}

/*
Standard_Real & function transformation
*/
%typemap(argout) Standard_Real &OutValue {
    PyObject *o, *o2, *o3;
    o = PyFloat_FromDouble(*$1);
    if ((!$result) || ($result == Py_None)) {
        $result = o;
    } else {
        if (!PyTuple_Check($result)) {
            PyObject *o2 = $result;
            $result = PyTuple_New(1);
            PyTuple_SetItem($result,0,o2);
        }
        o3 = PyTuple_New(1);
        PyTuple_SetItem(o3,0,o);
        o2 = $result;
        $result = PySequence_Concat(o2,o3);
        Py_DECREF(o2);
        Py_DECREF(o3);
    }
}

%typemap(in,numinputs=0) Standard_Real &OutValue(Standard_Real temp) {
    $1 = &temp;
}

/*
Standard_Integer & function transformation
*/
%typemap(argout) Standard_Integer &OutValue {
    PyObject *o, *o2, *o3;
    o = PyInt_FromLong(*$1);
    if ((!$result) || ($result == Py_None)) {
        $result = o;
    } else {
        if (!PyTuple_Check($result)) {
            PyObject *o2 = $result;
            $result = PyTuple_New(1);
            PyTuple_SetItem($result,0,o2);
        }
        o3 = PyTuple_New(1);
        PyTuple_SetItem(o3,0,o);
        o2 = $result;
        $result = PySequence_Concat(o2,o3);
        Py_DECREF(o2);
        Py_DECREF(o3);
    }
}

%typemap(in,numinputs=0) Standard_Integer &OutValue(Standard_Integer temp) {
    $1 = &temp;
}

/*
Renaming operator = that can't be wrapped in Python
*/
%rename(Set) *::operator=;


%include XCAFApp_dependencies.i


%include XCAFApp_headers.i




%nodefaultctor Handle_XCAFApp_Application;
class Handle_XCAFApp_Application : public Handle_TDocStd_Application {
	public:
		%feature("autodoc", "1");
		Handle_XCAFApp_Application();
		%feature("autodoc", "1");
		Handle_XCAFApp_Application(const Handle_XCAFApp_Application &aHandle);
		%feature("autodoc", "1");
		Handle_XCAFApp_Application(const XCAFApp_Application *anItem);
		%feature("autodoc", "1");
		Handle_XCAFApp_Application & operator=(const Handle_XCAFApp_Application &aHandle);
		%feature("autodoc", "1");
		Handle_XCAFApp_Application & operator=(const XCAFApp_Application *anItem);
		%feature("autodoc", "1");
		Handle_XCAFApp_Application const DownCast(const Handle_Standard_Transient &AnObject);

};
%extend Handle_XCAFApp_Application {
	XCAFApp_Application* GetObject() {
	return (XCAFApp_Application*)$self->Access();
	}
};
%extend Handle_XCAFApp_Application {
	~Handle_XCAFApp_Application() {
	char *__env=getenv("PYTHONOCC_VERBOSE");
	if (__env){printf("## Call custom destructor for instance of Handle_XCAFApp_Application\n");}
	}
};


%nodefaultctor XCAFApp_Application;
class XCAFApp_Application : public TDocStd_Application {
	public:
		%feature("autodoc", "1");
		virtual		void Formats(TColStd_SequenceOfExtendedString & Formats);
		%feature("autodoc", "1");
		virtual		Standard_CString ResourcesName();
		%feature("autodoc", "1");
		virtual		void InitDocument(const Handle_TDocStd_Document &aDoc) const;
		%feature("autodoc", "1");
		Handle_XCAFApp_Application GetApplication();
		%feature("autodoc", "1");
		virtual		const Handle_Standard_Type & DynamicType() const;

};
%extend XCAFApp_Application {
	Handle_XCAFApp_Application GetHandle() {
	return *(Handle_XCAFApp_Application*) &$self;
	}
};
%extend XCAFApp_Application {
	Standard_Integer __hash__() {
	return $self->HashCode(__PYTHONOCC_MAXINT__);
	}
};
%extend XCAFApp_Application {
	~XCAFApp_Application() {
	char *__env=getenv("PYTHONOCC_VERBOSE");
	if (__env){printf("## Call custom destructor for instance of XCAFApp_Application\n");}
	}
};
%inline %{
Handle_XCAFApp_Application GetApplication()
{
return XCAFApp_Application::GetApplication();
}
%}
