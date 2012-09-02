
// DO NOT EDIT THIS FILE - it is machine generated -*- c++ -*-

#ifndef __java_awt_font_GlyphJustificationInfo__
#define __java_awt_font_GlyphJustificationInfo__

#pragma interface

#include <java/lang/Object.h>
extern "Java"
{
  namespace java
  {
    namespace awt
    {
      namespace font
      {
          class GlyphJustificationInfo;
      }
    }
  }
}

class java::awt::font::GlyphJustificationInfo : public ::java::lang::Object
{

public:
  GlyphJustificationInfo(jfloat, jboolean, jint, jfloat, jfloat, jboolean, jint, jfloat, jfloat);
  static const jint PRIORITY_KASHIDA = 0;
  static const jint PRIORITY_WHITESPACE = 1;
  static const jint PRIORITY_INTERCHAR = 2;
  static const jint PRIORITY_NONE = 3;
  jfloat __attribute__((aligned(__alignof__( ::java::lang::Object)))) weight;
  jint growPriority;
  jboolean growAbsorb;
  jfloat growLeftLimit;
  jfloat growRightLimit;
  jint shrinkPriority;
  jboolean shrinkAbsorb;
  jfloat shrinkLeftLimit;
  jfloat shrinkRightLimit;
  static ::java::lang::Class class$;
};

#endif // __java_awt_font_GlyphJustificationInfo__
