
// DO NOT EDIT THIS FILE - it is machine generated -*- c++ -*-

#ifndef __org_xml_sax_helpers_NamespaceSupport$Context__
#define __org_xml_sax_helpers_NamespaceSupport$Context__

#pragma interface

#include <java/lang/Object.h>
#include <gcj/array.h>

extern "Java"
{
  namespace org
  {
    namespace xml
    {
      namespace sax
      {
        namespace helpers
        {
            class NamespaceSupport;
            class NamespaceSupport$Context;
        }
      }
    }
  }
}

class org::xml::sax::helpers::NamespaceSupport$Context : public ::java::lang::Object
{

public: // actually package-private
  NamespaceSupport$Context(::org::xml::sax::helpers::NamespaceSupport *);
  void setParent(::org::xml::sax::helpers::NamespaceSupport$Context *);
  void clear();
  void declarePrefix(::java::lang::String *, ::java::lang::String *);
  JArray< ::java::lang::String * > * processName(::java::lang::String *, jboolean);
  ::java::lang::String * getURI(::java::lang::String *);
  ::java::lang::String * getPrefix(::java::lang::String *);
  ::java::util::Enumeration * getDeclaredPrefixes();
  ::java::util::Enumeration * getPrefixes();
private:
  void copyTables();
public: // actually package-private
  ::java::util::Hashtable * __attribute__((aligned(__alignof__( ::java::lang::Object)))) prefixTable;
  ::java::util::Hashtable * uriTable;
  ::java::util::Hashtable * elementNameTable;
  ::java::util::Hashtable * attributeNameTable;
  ::java::lang::String * defaultNS;
  jboolean declsOK;
private:
  ::java::util::Vector * declarations;
  jboolean declSeen;
  ::org::xml::sax::helpers::NamespaceSupport$Context * parent;
public: // actually package-private
  ::org::xml::sax::helpers::NamespaceSupport * this$0;
public:
  static ::java::lang::Class class$;
};

#endif // __org_xml_sax_helpers_NamespaceSupport$Context__
