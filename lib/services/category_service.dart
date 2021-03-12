import 'package:casingapikstore/repository/repository.dart';

class CategoryService {
  Repository _repository;
  CategoryService() {
    _repository = Repository();
  }

  getCategories() async {
    return await _repository.httpGet('categories');
  }

  getTwoFirstCategories() async {
    return await _repository.httpGet('two-first-categories');
  }

  getTwoSecondCategories() async {
    return await _repository.httpGet('two-second-categories');
  }

  getOneLastCategories() async {
    return await _repository.httpGet('one-last-categories');
  }
}
