
// DO NOT EDIT THIS FILE - it is machine generated -*- c++ -*-

#ifndef __org_omg_CORBA_ValueMemberHelper__
#define __org_omg_CORBA_ValueMemberHelper__

#pragma interface

#include <java/lang/Object.h>
extern "Java"
{
  namespace org
  {
    namespace omg
    {
      namespace CORBA
      {
          class Any;
          class TypeCode;
          class ValueMember;
          class ValueMemberHelper;
        namespace portable
        {
            class InputStream;
            class OutputStream;
        }
      }
    }
  }
}

class org::omg::CORBA::ValueMemberHelper : public ::java::lang::Object
{

public:
  ValueMemberHelper();
  static void insert(::org::omg::CORBA::Any *, ::org::omg::CORBA::ValueMember *);
  static ::org::omg::CORBA::ValueMember * extract(::org::omg::CORBA::Any *);
  static ::org::omg::CORBA::TypeCode * type();
  static ::java::lang::String * id();
  static ::org::omg::CORBA::ValueMember * read(::org::omg::CORBA::portable::InputStream *);
  static void write(::org::omg::CORBA::portable::OutputStream *, ::org::omg::CORBA::ValueMember *);
private:
  static ::org::omg::CORBA::TypeCode * typeCode;
  static jboolean active;
public:
  static ::java::lang::Class class$;
};

#endif // __org_omg_CORBA_ValueMemberHelper__
