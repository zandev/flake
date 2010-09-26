package flake
{
  import flake.errors.IllegalArgumentError;
  
  import mx.collections.ArrayCollection;
  import mx.collections.ICollectionView;
  
  import flash.utils.Dictionary;
  import flash.utils.IExternalizable;
  import flash.utils.ByteArray;
  import flash.utils.describeType;
  import flash.utils.getDefinitionByName;
  import flash.utils.getQualifiedClassName;
  
  public final class ObjectUtils
  {
    public static var PRODUCTION : Boolean = true;
    
    private static const registry : Dictionary = new Dictionary();
    private static const registryNames : Dictionary = new Dictionary();
    
    public static function getClass(instanceOrClass : *) : Class
    {
      return (instanceOrClass is Class ? instanceOrClass : getDefinitionByName(getQualifiedClassName(instanceOrClass))) as Class;
    }
    
    public static function getConstsMap(instanceOrClass : *) : Dictionary
    {
      var c : Class,
        res : Dictionary,
        node : XML,
        x : XML,
        constants : XMLList;
      c = getClass(instanceOrClass);
      if (registry[c] != undefined)
      {
        res = registry[c];
      }
      else
      {
        x = describeType(c);
        constants = x.constant;
        if (constants.length() > 0)
        {
          res = new Dictionary();
          for each (node in constants)
          {
            res[c[node.@name]] = c[node.@name];
          }
          registry[c] = res;
        }
      }
      return res;
    }
    
    public static function getConstsNames(instanceOrClass : *) : Dictionary
    {
      var c : Class,
        res : Dictionary,
        node : XML,
        x : XML,
        constants : XMLList;
      c = getClass(instanceOrClass);
      if (registryNames[c] != undefined)
      {
        res = registryNames[c] as Dictionary;
      }
      else
      {
        x = describeType(c);
        constants = x.constant;
        if (constants.length() > 0)
        {
          res = new Dictionary();
          for each (node in constants)
          {
            res[c[node.@name]] = node.@name.toString();
          }
          registryNames[c] = res;
        }
      }
      return res;
    }
    
    public static function hasConst(instanceOrClass : *) : Boolean
    {
      return getConstsMap(instanceOrClass) != null;
    }
    
    public static function cloneExternalizable(value : IExternalizable) : IExternalizable
    {
      var res : IExternalizable,
        ba : ByteArray;
      if (value != null)
      {
        ba = new ByteArray();
        ba.writeObject(value);
        ba.position = 0;
        res = ba.readObject() as IExternalizable;
      }
      return res;
    }
    
    public static function clone(value : *) : *
    {
      var res : *,
        ba : ByteArray;
      if (value != null)
      {
        ba = new ByteArray();
        ba.writeObject(value);
        ba.position = 0;
        res = ba.readObject();
      }
      return res;
    }
    
    private static const __DUMP_NULL:String = '[null]'
    private static const __DUMP_EMPTY:String = '[empty]'
    public static function dumpObject(o:*):String
    {
      var dump:String;
      if (! o) 
      {
        return __DUMP_NULL;
      }
      else if (o is Array)
      {
        dump = _dumpArray(o);
      }
      else if (o is ArrayCollection)
      {
        dump = _dumpArray((o as ArrayCollection).source);
      }
      else if (o is ICollectionView)
      {
        throw new IllegalArgumentError('dumping for ICollectionView is not implemented');
      }
      else if (o is Object)
      {
        dump = _dumpObject(o);
      }
      return dump;
    }
    
    private static function _dumpObject(object:Object):String
    {
      var desc:XML = describeType(object);
      var type:String = desc.@name;
      
      var dump:Array = [];
      
      var vars:XMLList = desc.variable
      for each (var v:XML in vars)
      {
        dump.push(v.@name + '=' + object[v.@name]);
      }
      
      var accs:XMLList = desc.accessor.(@declaredBy == type)
      for each (var a:XML in accs)
      {
        dump.push(a.@name + '=' + object[a.@name]);
      }
      return _toDump(dump);
    }
    
    private static function _dumpArray(collection:*):String
    {
      var dump:Array = [];
      for each (var o:* in collection)
      {
        dump.push(_dumpObject(o));
      }
      return _toDump(dump);
    }
    
    private static function _toDump(dump:Array):String
    {
      if (dump.length == 0) 
      {
        return __DUMP_EMPTY;
      }
      else 
      {
        dump.sort();
        return '[' + dump.join(',') + ']';
      }
    }
    
    public static function isCollection(arrayOrICollectionView:*):Boolean
    {
      for each (var clazz:Class in [Array, ICollectionView])
      {
        if (arrayOrICollectionView is clazz) return true;
      }
      return false;
    }
    
  }
}