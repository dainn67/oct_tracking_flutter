import 'package:timesheet/data/model/response/team.dart';
import 'package:timesheet/data/model/response/work_day.dart';

import 'Task.dart';

class ApiResponse {
  String timestamp;
  int code;
  String message;
  ApiData data;
  int total;

  ApiResponse({
    required this.timestamp,
    required this.code,
    required this.message,
    required this.data,
    required this.total,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      timestamp: json['timestamp'],
      code: json['code'],
      message: json['message'],
      data: ApiData.fromJson(json['data']),
      total: json['total'],
    );
  }
}

class ApiData {
  List<dynamic> content;
  ApiPageable pageable;
  int totalPages;
  int totalElements;
  bool last;
  int size;
  int number;
  ApiSort sort;
  int numberOfElements;
  bool first;
  bool empty;

  ApiData({
    required this.content,
    required this.pageable,
    required this.totalPages,
    required this.totalElements,
    required this.last,
    required this.size,
    required this.number,
    required this.sort,
    required this.numberOfElements,
    required this.first,
    required this.empty,
  });

  factory ApiData.fromJson(Map<String, dynamic> json) {
    List<dynamic> content = [];
    if(json['content'].toString().contains('dayOff')) {
      content = (json['content'] as List)
        .map((contentJson) => WorkingDay.fromJson(contentJson))
        .toList();
    } else if (json['content'].toString().contains('position')){
      content = (json['content'] as List)
          .map((contentJson) => Member.fromJson(contentJson))
          .toList();
    } else if (json['content'].toString().contains('members')){
      content = (json['content'] as List)
          .map((contentJson) => Team.fromJson(contentJson))
          .toList();
    } else {
      content = (json['content'] as List)
          .map((contentJson) => Project.fromJson(contentJson))
          .toList();
    }
    // print('DECODING: ${json['content']}');

    return ApiData(
      content: content,
      pageable: ApiPageable.fromJson(json['pageable']),
      totalPages: json['totalPages'],
      totalElements: json['totalElements'],
      last: json['last'],
      size: json['size'],
      number: json['number'],
      sort: ApiSort.fromJson(json['sort']),
      numberOfElements: json['numberOfElements'],
      first: json['first'],
      empty: json['empty'],
    );
  }
}

class ApiPageable {
  ApiSort sort;
  int pageSize;
  int pageNumber;
  int offset;
  bool unpaged;
  bool paged;

  ApiPageable({
    required this.sort,
    required this.pageSize,
    required this.pageNumber,
    required this.offset,
    required this.unpaged,
    required this.paged,
  });

  factory ApiPageable.fromJson(Map<String, dynamic> json) {
    return ApiPageable(
      sort: ApiSort.fromJson(json['sort']),
      pageSize: json['pageSize'],
      pageNumber: json['pageNumber'],
      offset: json['offset'],
      unpaged: json['unpaged'],
      paged: json['paged'],
    );
  }
}

class ApiSort {
  bool sorted;
  bool unsorted;
  bool empty;

  ApiSort({
    required this.sorted,
    required this.unsorted,
    required this.empty,
  });

  factory ApiSort.fromJson(Map<String, dynamic> json) {
    return ApiSort(
      sorted: json['sorted'],
      unsorted: json['unsorted'],
      empty: json['empty'],
    );
  }
}