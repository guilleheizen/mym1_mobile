class ProductSearchSettings {
  String? query;
  String? categoryCode;
  String? brandCode;
  String? productGroupCode;
  String? productGroupTitle;
  int pageSize;
  int pageNumber;
  String order;

  ProductSearchSettings({
    this.query,
    this.categoryCode,
    this.brandCode,
    this.productGroupCode,
    this.productGroupTitle,
    this.pageSize = 6,
    this.pageNumber = 1,
    this.order = 'DESC',
  });

  bool isEqualTo(ProductSearchSettings settings) {
    return query == settings.query &&
        categoryCode == settings.categoryCode &&
        brandCode == settings.brandCode &&
        productGroupCode == settings.productGroupCode &&
        productGroupTitle == settings.productGroupTitle &&
        pageSize == settings.pageSize &&
        pageNumber == settings.pageNumber &&
        order == settings.order;
  }
}
