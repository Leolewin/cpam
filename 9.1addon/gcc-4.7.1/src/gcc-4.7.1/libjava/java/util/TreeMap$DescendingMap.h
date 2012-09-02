
// DO NOT EDIT THIS FILE - it is machine generated -*- c++ -*-

#ifndef __java_util_TreeMap$DescendingMap__
#define __java_util_TreeMap$DescendingMap__

#pragma interface

#include <java/lang/Object.h>

class java::util::TreeMap$DescendingMap : public ::java::lang::Object
{

public:
  TreeMap$DescendingMap(::java::util::NavigableMap *);
  ::java::util::Map$Entry * ceilingEntry(::java::lang::Object *);
  ::java::lang::Object * ceilingKey(::java::lang::Object *);
  void clear();
  ::java::util::Comparator * comparator();
  jboolean containsKey(::java::lang::Object *);
  jboolean containsValue(::java::lang::Object *);
  ::java::util::NavigableSet * descendingKeySet();
  ::java::util::NavigableMap * descendingMap();
  ::java::util::Set * entrySet();
  jboolean equals(::java::lang::Object *);
  ::java::util::Map$Entry * firstEntry();
  ::java::lang::Object * firstKey();
  ::java::util::Map$Entry * floorEntry(::java::lang::Object *);
  ::java::lang::Object * floorKey(::java::lang::Object *);
  ::java::lang::Object * get(::java::lang::Object *);
  jint hashCode();
  ::java::util::SortedMap * headMap(::java::lang::Object *);
  ::java::util::NavigableMap * headMap(::java::lang::Object *, jboolean);
  ::java::util::Map$Entry * higherEntry(::java::lang::Object *);
  ::java::lang::Object * higherKey(::java::lang::Object *);
  ::java::util::Set * keySet();
  jboolean isEmpty();
  ::java::util::Map$Entry * lastEntry();
  ::java::lang::Object * lastKey();
  ::java::util::Map$Entry * lowerEntry(::java::lang::Object *);
  ::java::lang::Object * lowerKey(::java::lang::Object *);
  ::java::util::NavigableSet * navigableKeySet();
  ::java::util::Map$Entry * pollFirstEntry();
  ::java::util::Map$Entry * pollLastEntry();
  ::java::lang::Object * put(::java::lang::Object *, ::java::lang::Object *);
  void putAll(::java::util::Map *);
  ::java::lang::Object * remove(::java::lang::Object *);
  jint size();
  ::java::util::SortedMap * subMap(::java::lang::Object *, ::java::lang::Object *);
  ::java::util::NavigableMap * subMap(::java::lang::Object *, jboolean, ::java::lang::Object *, jboolean);
  ::java::util::SortedMap * tailMap(::java::lang::Object *);
  ::java::util::NavigableMap * tailMap(::java::lang::Object *, jboolean);
  ::java::lang::String * toString();
  ::java::util::Collection * values();
private:
  ::java::util::Set * __attribute__((aligned(__alignof__( ::java::lang::Object)))) entries;
  ::java::util::Set * keys;
  ::java::util::NavigableSet * nKeys;
  ::java::util::Collection * values__;
  ::java::util::NavigableMap * map;
public:
  static ::java::lang::Class class$;
};

#endif // __java_util_TreeMap$DescendingMap__
