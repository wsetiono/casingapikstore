import 'package:casingapikstore/repository/repository.dart';

class ProductService {
  Repository _repository;
  ProductService() {
    _repository = Repository();
  }

  getHotProducts() async {
    return await _repository.httpGet('get-all-hot-products');
  }

  getProductsByCategoryId(categoryId) async {
    return await _repository.httpGetById(
        "get-products-by-category", categoryId);
  }

  getProductsByKeyword(searchKeyword) async {
    return await _repository.httpGetById(
        "get-products-by-keyword", searchKeyword);
  }
}
