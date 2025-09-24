///contrato generico para todos os casos de uso
///padroniza a chamada com retorno e parametros
abstract class UseCase<T, Params> {
  Future<T> call(Params params);
}

class NoParams {}
