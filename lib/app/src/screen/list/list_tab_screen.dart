import 'dart:math';

import 'package:flu_shop_search/app/src/model/shop_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  String _searchKeyword = ""; // 검색어 상태 변수 추가

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
    // 임시로 사용할 이미지 URL 리스트
    List<String> bannerImages = [
      'https://www.repetto.kr//data/SmartEditContent/20190222102432_5355.jpg',
      'https://mblogthumb-phinf.pstatic.net/MjAxODEyMDdfOTYg/MDAxNTQ0MTkyNjk0MDYy.c1fmE2-oQrK4ANITJjQ1Y1KiVJJ5K_QQgkmHg22HgVgg.7dsEc8nr7mre5OZL5wLVLkgLBNjRTAE29143F88qY5gg.JPEG.r901207/x9788984077461.jpg?type=w800',
      'https://scontent-ssn1-1.xx.fbcdn.net/v/t1.6435-9/166876835_257668542740012_164609649367803780_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=5f2048&_nc_ohc=o3TVqPEzY8EQ7kNvgFDCZHV&_nc_ht=scontent-ssn1-1.xx&oh=00_AYBfg9PJB0xufvO-moDOPEDuzXsfgvUFmSB27ujKvCl-rQ&oe=668D0066',
    ];

    return Container(
      height: 150, // 배너 높이 설정
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // 가로 스크롤 방향 설정
        itemCount: bannerImages.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 8), // 카드 간의 간격 설정
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6), // 둥근 모서리 설정
              child: Image.network(
                bannerImages[index], // 이미지 URL 설정
                // fit: BoxFit.cover, // 이미지 비율 유지하며 꽉 채우기
                width: MediaQuery.of(context).size.width * 0.8, // 카드 너비 설정
              ),
            ),
          );
        },
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
          setState(() {
            _searchKeyword = value; // 검색어 상태 업데이트
          });
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
          ],
        ),
      ),
    );
  }

  Widget mainListView(FetchOptions fetchOptions) {
    return Container(
      child: FutureBuilder(
        future:
            fetchShopList(fetchOptions: fetchOptions, keyword: _searchKeyword),
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
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/shopdetail',
                        arguments: shopModel);
                  },
                  child: Container(
                    color: Colors
                        .transparent, // column 전체의 touch를 인식하게 해줄 수 있도록 container로 덮어주기
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: List.generate(
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
                                        shopModel.json_brand['brand_names']
                                            [index],
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
                                          MaterialStateProperty.all(
                                              Colors.white),
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              Color(0xff4F7396)),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          side: BorderSide(
                                              color: Color(0xff4F7396)),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                      ],
                    ),
                  ),
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
        // 이미 필터링된 상태에서 검색어 적용
        if (keyword != null && keyword.isNotEmpty) {
          query = query.or('json_brand->>brand_names.ilike.%$keyword%');
        }
        break;
    }

    if (keyword != null && keyword.isNotEmpty) {
      query = query.or('json_brand->>brand_names.ilike.%$keyword%');
    }

    print('Query : $query');

    final response = await query;

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
