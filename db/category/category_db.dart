import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manage_app/models/category/category.dart';
import 'package:money_manage_app/screens/category/income_category_list.dart';


const CATEGORY_DB_NAME = 'category_database';

abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getCategories();
  Future<void> insertCategory(CategoryModel value);
  Future<void> deleteCategory(String categoryID);
}


class CategoryDb implements CategoryDbFunctions {
  CategoryDb._internal();

  static CategoryDb instance = CategoryDb._internal();

  factory CategoryDb(){
    return instance;

  }

   
   ValueNotifier<List<CategoryModel>> incomeCategoryListListener = ValueNotifier([]);
   ValueNotifier<List<CategoryModel>> expenceCategoryListListener = ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryModel value) async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    _categoryDB.put(value.id,value);
    refreshUI();
    
  }
  
  @override
  Future<List<CategoryModel>> getCategories() async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return _categoryDB.values.toList();
    
  }


  Future<void> refreshUI()async{
    final _allCategories  = await getCategories();
    incomeCategoryListListener.value.clear();
    expenceCategoryListListener.value.clear();
    Future.forEach(_allCategories, (CategoryModel category) {
      if (category.type == CategoryType.income) {
        incomeCategoryListListener.value.add(category);
      }else{
        expenceCategoryListListener.value.add(category);
      }
    });

    incomeCategoryListListener.notifyListeners();
    expenceCategoryListListener.notifyListeners();
  }
  
  @override
  Future<void> deleteCategory(String categoryID) async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await _categoryDB.delete(categoryID);
    refreshUI();
  }
  
}