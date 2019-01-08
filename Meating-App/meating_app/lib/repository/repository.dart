
abstract class Repository<T> {

  Future<T> save(var params);
  Future<List<T>> selectAll();
  Future<T> update(T object);
}