abstract class Resource<T> {
  final T? data;
  final String? message;

  Resource({this.data, this.message});
}

class Loading<T> extends Resource<T> {
  Loading() : super(data: null, message: null);
}

class Success<T> extends Resource<T> {
  Success(T data) : super(data: data);
}

class ErrorData<T> extends Resource<T> {
  ErrorData(String message) : super(message: message);
}
