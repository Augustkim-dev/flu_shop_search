import 'dart:math';

import 'package:flu_shop_search/app/src/model/shop_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

enum FetchOptions { All, Online, Offline, Keyword }

class ListTabScreen extends StatefulWidget {
  const ListTabScreen({super.key});

  @override
  State<ListTabScreen> createState() => _NestedListTabScreenState();
}

class _NestedListTabScreenState extends State<ListTabScreen> {
  final supabase = Supabase.instance.client;
  TextEditingController _searchController = TextEditingController(); // 검색정보

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: Text('List Screen'),
                pinned: false,
                floating: true,
                forceElevated: true,
              ),
            ];
          },
          body: ListView(
            padding: EdgeInsets.all(12),
            children: [
              banner(),
              searchBar(),
              tabController(),
            ],
          ),
        ),
      ),
    );
  }

  Widget banner() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Container(
        height: 150,
        color: Colors.orange,
        child: Center(child: Text('banner')),
      ),
    );
  }

  Widget searchBar() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: 'Search',
          border: OutlineInputBorder(),
        ),
        controller: _searchController,
        onFieldSubmitted: (value) {
          print('search : $value');
        },
      ),
    );
  }

  Widget tabController() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
      child: DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            TabBar(
              // isScrollable: false, // 추가
              // indicatorSize: TabBarIndicatorSize.label, // 추가
              // physics: NeverScrollableScrollPhysics(), // 추가
              tabs: [
                Tab(child: Text('All')),
                Tab(child: Text('On-Line')),
                Tab(child: Text('Off-Line')),
              ],
            ),
            tabView(),
          ],
        ),
      ),
    );
  }

  Widget tabView() {
    return Container(
      height: 800,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TabBarView(
          children: [
            mainListView(FetchOptions.All),
            mainListView(FetchOptions.Online),
            mainListView(FetchOptions.Offline),
            // Text('online'),
            // Text('offline'),
          ],
        ),
      ),
    );
  }

  Widget mainListView(FetchOptions fetchOptions) {
    var fetchMethods;
    if (fetchOptions == FetchOptions.All) {
      fetchMethods = fetchShopList(fetchOptions: FetchOptions.All);
    } else if (fetchOptions == FetchOptions.Online) {
      fetchMethods = fetchShopList(fetchOptions: FetchOptions.Online);
    } else if (fetchOptions == FetchOptions.Offline) {
      fetchMethods = fetchShopList(fetchOptions: FetchOptions.Offline);
    }

    return Container(
      child: FutureBuilder(
        // future: fetchShopList(fetchOptions: FetchOptions.All),
        future: fetchMethods,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error : ${snapshot.error}'));
          }

          return Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                ShopModel shopModel = snapshot.data![index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // 추가
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            child: Image.network(
                              'https://t1.daumcdn.net/cfile/tistory/2327D84754754B4D17',
                            ),
                            width: 72,
                            height: 72,
                          ),
                        ),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${shopModel.id.toString()} : ${shopModel.str_shop_name} ',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                fontFamily: 'Plus_Jakarta_Sans',
                                color: Color(0xff0D141C),
                              ),
                            ),
                            Text(
                              shopModel.str_desc,
                              style: TextStyle(
                                fontFamily: 'Plus_Jakarta_Sans',
                                color: Color(0xff4F7396),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      // SingleChildScrollView로 감싸기 시작
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(
                          // min(10, shopModel.json_brand['brand_names'].length),
                          shopModel.json_brand['brand_names'].length,
                          (index) {
                            return Padding(
                              padding: EdgeInsets.only(right: 4.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  print(
                                      '${shopModel.json_brand['brand_names'][index]} 클릭 !');
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    shopModel.json_brand['brand_names'][index],
                                    style: TextStyle(
                                      fontFamily: 'Plus_Jakarta_Sans',
                                      color: Color(0xff4F7396),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                style: ButtonStyle(
                                  minimumSize:
                                      MaterialStateProperty.all(Size(0, 0)),
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.zero),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  foregroundColor: MaterialStateProperty.all(
                                      Color(0xff4F7396)),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side:
                                          BorderSide(color: Color(0xff4F7396)),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ), // SingleChildScrollView로 감싸기 끝
                    SizedBox(height: 25),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  Future<List<ShopModel>> fetchShopList(
      {required FetchOptions fetchOptions, String? keyword}) async {
    var query = supabase.from('tbl_shop_main').select();

    switch (fetchOptions) {
      case FetchOptions.All:
        // No filter needed for "All"
        break;
      case FetchOptions.Online:
        query = query.eq('b_online', true);
        break;
      case FetchOptions.Offline:
        query = query.eq('b_offline', true);
        break;
      case FetchOptions.Keyword:
        if (keyword != null && keyword.isNotEmpty) {
          query = query.ilike('str_shop_name', '%$keyword%');
        } else {
          throw ArgumentError(
              'Keyword cannot be null or empty for Keyword search option.');
        }
        break;
    }
    print('Query : $query');

    final response = await query;

    // if (response.error != null) {
    //   throw response.error!;
    // }

    // final shopList = await supabase.from('tbl_shop_main').select();
    // return shopList.map((e) => ShopModel.fromJson(e)).toList();
    print('##### shopList : $response');
    return response.map((e) {
      return ShopModel(
        id: e['id'],
        str_shop_name: e['str_shop_name'],
        str_phone: e['str_phone'],
        str_shop_url: e['str_shop_url'],
        str_desc: e['str_desc'],
        str_image_url: e['str_image_url'],
        b_online: e['b_online'],
        b_offline: e['b_offline'],
        str_address: e['str_address'],
        str_lat: e['str_lat'],
        str_long: e['str_long'],
        json_brand: e['json_brand'],
        created_at: DateTime.parse(e['created_at']),
      );
    }).toList();
  }
}
