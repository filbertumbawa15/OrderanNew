import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:tasorderan/bloc/user/validasi/validasi_bloc.dart';
import 'package:tasorderan/bloc/user/verifikasi/verifikasi_cubit.dart';
import 'package:tasorderan/components/components.dart';
import 'package:tasorderan/core/app_setting/app_setting_bloc.dart';
import 'package:tasorderan/core/session_manager.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _widgetOptions();
  }

  List<Widget> _widgetOptions() {
    return [
      const Dashboard(),
      const Profiles(),
      const Settings(),
    ];
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      // if (selectedIndex == 2) {
      //   setState(() {
      //     globals.condition = "false";
      //   });
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        // key: _scaffoldKey,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: _widgetOptions().elementAt(selectedIndex),
        ),
        bottomNavigationBar: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: Material(
            elevation: 10,
            child: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Beranda',
                  tooltip: '',
                ),
                BottomNavigationBarItem(
                  icon: Stack(
                    children: <Widget>[
                      Icon(Icons.account_circle_sharp),
                    ],
                  ),
                  label: "Profil",
                  tooltip: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Pengaturan',
                  tooltip: '',
                ),
              ],
              currentIndex: selectedIndex,
              selectedLabelStyle: const TextStyle(
                fontFamily: 'Nunito-Medium',
              ),
              unselectedLabelStyle: const TextStyle(
                fontFamily: 'Nunito-Medium',
                fontSize: 14.0,
              ),
              fixedColor: const Color(0xFF5599E9),
              onTap: onItemTapped,
            ),
          ),
        ),
        // ),
      ),
    );
  }
}

class Dashboard extends StatefulWidget {
  @override
  // final File selectednpwpPath;
  // final File selectedktpPath;
  // final String selectednik;
  // final String selectedalamatdetail;
  // final String selectednama;
  // final String selectedtglLahir;
  // final String selectednpwp;
  // final int selecteduserid;

  const Dashboard({
    Key? key,
    // this.selectednpwpPath,
    // this.selectedktpPath,
    // this.selectednik,
    // this.selectedalamatdetail,
    // this.selectednama,
    // this.selectedtglLahir,
    // this.selectednpwp,
    // this.selecteduserid,
  }) : super(key: key);
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
  }

  final components = Tools();

  int currentPos = 0;
  final List<String> imgList = [
    'https://www.transporindo.com/wp-content/uploads/2020/06/truckmin.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Image.asset(
            'assets/imgs/taslogo.png',
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                backgroundColor: const Color(0xFFE7E7E7),
                minimumSize: const Size(5, 5),
                splashFactory: NoSplash.splashFactory,
                elevation: 0,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/notifications');
              },
              child: const Icon(
                Icons.notifications,
                color: Color(0xFF5599E9),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF1F1EF),
      body: BlocProvider(
        create: (context) => ValidasiBloc(),
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            const SizedBox(height: 15.0),
            const Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: 10.0),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "PT. TRANSPORINDO AGUNG SEJAHTERA",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                              softWrap: true,
                            ),
                          ],
                        ),
                      ],
                    )),
                  ],
                ),
              ],
            ),
            CarouselSlider.builder(
              itemCount: imgList.length,
              options: CarouselOptions(
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                  autoPlay: false,
                  onPageChanged: (index, reason) {}),
              itemBuilder: (context, index, realIndex) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.asset(
                      'assets/imgs/carousel.jpg',
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width / 2.5,
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 18.0),
            const Text(
              'Categories',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: 'Nunito-Medium',
                fontSize: 20.0,
                color: Color(0xFF313131),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 14.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: [
                    Container(
                      width: 60,
                      margin: const EdgeInsets.only(
                          bottom: 10.0, right: 30.0, left: 30.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFCFCFC),
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: const Color(0xFFAEAEAE),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/ongkir');
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(
                            top: 15.0,
                            bottom: 15.0,
                          ),
                          child: Center(
                              child: Icon(
                            Icons.fact_check,
                            size: 30.0,
                            color: Color(0xFF5599E9),
                          )),
                        ),
                      ),
                    ),
                    const Center(
                      child: Text("Cek Ongkir",
                          style: TextStyle(
                              fontSize: 14.0, color: Color(0xFF313131))),
                    )
                  ],
                ),
                BlocConsumer<ValidasiBloc, ValidasiState>(
                  listener: (context, state) {
                    if (state is ValidasiSuccess) {
                      Future.delayed(const Duration(seconds: 0), () {
                        Navigator.pushNamed(context, '/order');
                      });
                    }
                  },
                  builder: (context, state) {
                    if (state is ValidasiLoading) {
                      print("baca loading");
                    }
                    if (state is ValidasiFailed) {
                      Future.delayed(const Duration(seconds: 0), () {
                        components.alertBerhasilPesan(
                          state.message!,
                          state.content!,
                          state.image!,
                          IconsButton(
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                            text: 'Ok',
                            iconData: Icons.done,
                            color: Colors.blue,
                            textStyle: const TextStyle(color: Colors.white),
                            iconColor: Colors.white,
                          ),
                        );
                      });
                    }
                    return Column(
                      children: [
                        Container(
                          width: 60,
                          margin: const EdgeInsets.only(
                              bottom: 10.0, right: 30.0, left: 30.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFCFCFC),
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: const Color(0xFFAEAEAE),
                            ),
                          ),
                          child: InkWell(
                            onTap: () async {
                              context
                                  .read<ValidasiBloc>()
                                  .add(PesananValidasiEvent());
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(
                                top: 15.0,
                                bottom: 15.0,
                              ),
                              child: Center(
                                  child: Icon(
                                Icons.local_shipping,
                                size: 30.0,
                                color: Color(0xFF5599E9),
                              )),
                            ),
                          ),
                        ),
                        const Center(
                          child: Text("Pesanan",
                              style: TextStyle(
                                  fontSize: 14.0, color: Color(0xFF313131))),
                        )
                      ],
                    );
                  },
                ),
                BlocConsumer<ValidasiBloc, ValidasiState>(
                  listener: (context, state) {
                    if (state is HistorySuccecss) {
                      Future.delayed(const Duration(seconds: 0), () {
                        Navigator.pushNamed(context, '/list_order');
                      });
                    }
                  },
                  builder: (context, state) {
                    if (state is HistoryFailed) {
                      Future.delayed(const Duration(seconds: 0), () {
                        components.alertBerhasilPesan(
                          state.message!,
                          state.content!,
                          state.image!,
                          IconsButton(
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                            text: 'Ok',
                            iconData: Icons.done,
                            color: Colors.blue,
                            textStyle: const TextStyle(color: Colors.white),
                            iconColor: Colors.white,
                          ),
                        );
                      });
                    }
                    return Column(
                      children: [
                        Container(
                          width: 60,
                          margin: const EdgeInsets.only(
                              bottom: 10.0, right: 30.0, left: 30.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFCFCFC),
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: const Color(0xFFAEAEAE),
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              context
                                  .read<ValidasiBloc>()
                                  .add(HistoryValidasiEvent());
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(
                                top: 15.0,
                                bottom: 15.0,
                              ),
                              child: Center(
                                  child: Icon(
                                Icons.list,
                                size: 30.0,
                                color: Color(0xFF5599E9),
                              )),
                            ),
                          ),
                        ),
                        const Center(
                          child: Text("List Pesanan",
                              style: TextStyle(
                                  fontSize: 14.0, color: Color(0xFF313131))),
                        )
                      ],
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget alertBerhasilPesan() {
  //   Dialogs.materialDialog(
  //       color: Colors.white,
  //       msg:
  //           'Anda belum bisa melakukan pemesanan orderan,silahkan menyelesaikan pembayaran yang sebelum terlebih dahulu',
  //       title: 'Gagal',
  //       lottieBuilder: Lottie.asset(
  //         'assets/imgs/updated-transaction.json',
  //         fit: BoxFit.contain,
  //       ),
  //       context: context,
  //       actions: [
  //         IconsButton(
  //           onPressed: () {
  //             Navigator.pop(context);
  //           },
  //           text: 'Ok',
  //           iconData: Icons.done,
  //           color: Colors.blue,
  //           textStyle: TextStyle(color: Colors.white),
  //           iconColor: Colors.white,
  //         ),
  //       ]);
  // }
}

class Profiles extends StatefulWidget {
  const Profiles({
    Key? key,
  }) : super(key: key);

  @override
  State<Profiles> createState() => _ProfilesState();
}

class _ProfilesState extends State<Profiles>
    with SingleTickerProviderStateMixin {
  SessionManager sessionManager = SessionManager();
  int selectedIndex = 0;
  TabController? tabController;
  Tools tools = Tools();

  @override
  void initState() {
    tabController = TabController(
        initialIndex: selectedIndex,
        length: sessionManager.getActiveId() == null ||
                sessionManager.getActiveVerification() == "0"
            ? 1
            : 2,
        vsync: this);
    super.initState();
  }

  double? height;
  double? width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppSettingBloc()..add(SettingAppEvent()),
        ),
        BlocProvider(
          create: (context) => VerifikasiCubit(),
        ),
      ],
      child: DefaultTabController(
        length: sessionManager.getActiveId() == null ||
                sessionManager.getActiveVerification() == "0"
            ? 1
            : 2,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          extendBody: true,
          body: BlocBuilder<AppSettingBloc, AppSettingState>(
            builder: (context, state) {
              if (state is AppSettingLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is AppSettingAuthenticated) {
                return SizedBox(
                  height: height,
                  width: width,
                  child: alreadyLogin(),
                );
              } else {
                return SizedBox(
                  height: height,
                  width: width,
                  child: notLogin(),
                );
              }
            },
          ),
          // ),
        ),
      ),
    );
  }

  Widget notLogin() {
    return ListView(
      children: <Widget>[
        Container(
          height: 250,
          decoration: const BoxDecoration(
              color: Color(
            0xFFF1F1EF,
          )),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Color(0xFFD9D9D9),
                    minRadius: 45.0,
                    child: CircleAvatar(
                      radius: 40.0,
                      backgroundImage: AssetImage('assets/imgs/user.png'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'USER',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF313131),
                ),
              ),
              Text(
                'email@example.com',
                style: TextStyle(
                  color: Color(0xFFA1A19C),
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        TabBar(
          controller: tabController,
          indicatorColor: const Color(0xFF5599E9),
          labelColor: const Color(0xFF5599E9),
          splashFactory: NoSplash.splashFactory,
          unselectedLabelColor: const Color(0xFF313131),
          tabs: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Data User",
                style: TextStyle(
                  fontFamily: 'Nunito-Medium',
                ),
              ),
            ),
          ],
        ),
        const Column(
          children: <Widget>[
            ListTile(
              title: Text(
                'Name',
                style: TextStyle(
                  color: Color(0xFF777777),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'USER',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF313131),
                ),
              ),
            ),
            Divider(
              color: Color(0xFF999999),
              thickness: 2.0,
              indent: 15.0,
              endIndent: 15.0,
            ),
            ListTile(
              title: Text(
                'Tanggal Lahir',
                style: TextStyle(
                  color: Color(0xFF777777),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'XX-XX-XXXX',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF313131),
                ),
              ),
            ),
            Divider(
              color: Color(0xFF999999),
              thickness: 2.0,
              indent: 15.0,
              endIndent: 15.0,
            ),
            ListTile(
              title: Text(
                'No. Telp',
                style: TextStyle(
                  color: Color(0xFF777777),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'XXXX-XXXX-XXXX',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF313131),
                ),
              ),
            ),
            Divider(
              color: Color(0xFF999999),
              thickness: 2.0,
              indent: 15.0,
              endIndent: 15.0,
            ),
          ],
        )
      ],
    );
  }

  Widget alreadyLogin() {
    return ListView(
      // shrinkWrap: true,
      children: <Widget>[
        Container(
          height: 250,
          decoration: const BoxDecoration(
              color: Color(
            0xFFF1F1EF,
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Color(0xFFD9D9D9),
                    minRadius: 45.0,
                    child: CircleAvatar(
                      radius: 40.0,
                      backgroundImage: AssetImage('assets/imgs/user.png'),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                sessionManager.getActiveName()!.toUpperCase(),
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF313131),
                ),
              ),
              Text(
                '${sessionManager.getActiveEmail()}',
                style: const TextStyle(
                  color: Color(0xFFA1A19C),
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        if (sessionManager.getActiveVerification() == "0") ...[
          TabBar(
            controller: tabController,
            indicatorColor: const Color(0xFF5599E9),
            labelColor: const Color(0xFF5599E9),
            splashFactory: NoSplash.splashFactory,
            unselectedLabelColor: const Color(0xFF313131),
            tabs: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Data User",
                  style: TextStyle(
                    fontFamily: 'Nunito-Medium',
                  ),
                ),
              ),
            ],
            onTap: (int index) {
              setState(() {
                selectedIndex = index;
                tabController!.animateTo(index);
              });
            },
          ),
          IndexedStack(
            index: selectedIndex,
            children: <Widget>[
              Visibility(
                maintainState: true,
                visible: selectedIndex == 0,
                child: dataUser(),
              ),
            ],
          ),
        ] else ...[
          TabBar(
            controller: tabController,
            indicatorColor: const Color(0xFF5599E9),
            labelColor: const Color(0xFF5599E9),
            splashFactory: NoSplash.splashFactory,
            unselectedLabelColor: const Color(0xFF313131),
            tabs: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Data User",
                  style: TextStyle(
                    fontFamily: 'Nunito-Medium',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Data Identitas",
                  style: TextStyle(
                    fontFamily: 'Nunito-Medium',
                  ),
                ),
              ),
            ],
            onTap: (int index) {
              setState(() {
                selectedIndex = index;
                tabController!.animateTo(index);
              });
            },
          ),
          IndexedStack(
            index: selectedIndex,
            children: <Widget>[
              Visibility(
                maintainState: true,
                visible: selectedIndex == 0,
                child: dataUser(),
              ),
              Visibility(
                // child: dataIdentitas(),
                maintainState: true,
                visible: selectedIndex == 1,
                child: dataIdentitas(),
                // child: const Text("asdf"),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget dataUser() {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text(
            'Name',
            style: TextStyle(
              color: Color(0xFF777777),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            '${sessionManager.getActiveName()}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF313131),
            ),
          ),
        ),
        const Divider(
          color: Color(0xFF999999),
          thickness: 2.0,
          indent: 15.0,
          endIndent: 15.0,
        ),
        ListTile(
          title: const Text(
            'Tanggal Lahir',
            style: TextStyle(
              color: Color(0xFF777777),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            sessionManager.getActiveTglLahir() == null
                ? "1 Januari 1990"
                : DateFormat("dd-MM-yyyy").format(DateFormat("yyyy-MM-dd")
                    .parse(sessionManager.getActiveTglLahir()!)),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF313131),
            ),
          ),
        ),
        const Divider(
          color: Color(0xFF999999),
          thickness: 2.0,
          indent: 15.0,
          endIndent: 15.0,
        ),
        ListTile(
          title: const Text(
            'No. Telp',
            style: TextStyle(
              color: Color(0xFF777777),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            '${sessionManager.getActiveTelp()}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF313131),
            ),
          ),
        ),
        const Divider(
          color: Color(0xFF999999),
          thickness: 2.0,
          indent: 15.0,
          endIndent: 15.0,
        ),
        const SizedBox(
          height: 15.0,
        ),
        if (sessionManager.getActiveVerification() == "0") ...[
          Padding(
            padding: const EdgeInsets.only(
                left: 25.0, top: 0.0, bottom: 0.0, right: 25.0),
            child: ElevatedButton.icon(
              label: const Text(
                'Verifikasi Akun',
                style:
                    TextStyle(color: Colors.white, fontFamily: 'Nunito-Medium'),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(8.0),
                minimumSize: const Size.fromHeight(30),
                backgroundColor: const Color(0xFF5599E9),
                splashFactory: NoSplash.splashFactory,
                elevation: 0,
              ),
              icon: const Icon(
                Icons.security,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/home_verifikasi');
              },
            ),
          ),
        ] else if (sessionManager.getActiveVerification() == "12") ...[
          Padding(
            padding: const EdgeInsets.only(
                left: 25.0, top: 0.0, bottom: 0.0, right: 25.0),
            child: ElevatedButton.icon(
              label: const Text(
                'Data sedang diproses',
                style:
                    TextStyle(color: Colors.white, fontFamily: 'Nunito-Medium'),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(8.0),
                minimumSize: const Size.fromHeight(30),
                backgroundColor: const Color.fromARGB(255, 245, 165, 36),
                splashFactory: NoSplash.splashFactory,
                elevation: 0,
              ),
              icon: const Icon(
                Icons.security,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ),
        ] else if (sessionManager.getActiveVerification() == "13") ...[
          Padding(
            padding: const EdgeInsets.only(
                left: 25.0, top: 0.0, bottom: 0.0, right: 25.0),
            child: ElevatedButton.icon(
              label: const Text(
                'Akun terverifikasi',
                style:
                    TextStyle(color: Colors.white, fontFamily: 'Nunito-Medium'),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(8.0),
                backgroundColor: const Color(0xFF409658),
                minimumSize: const Size.fromHeight(30),
                splashFactory: NoSplash.splashFactory,
                elevation: 0,
              ),
              icon: const Icon(
                Icons.check_circle,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ),
        ] else if (sessionManager.getActiveVerification() == "14") ...[
          Padding(
            padding: const EdgeInsets.only(
                left: 25.0, top: 0.0, bottom: 0.0, right: 25.0),
            child: ElevatedButton.icon(
              label: const Text(
                'Data akun ditolak',
                style:
                    TextStyle(color: Colors.white, fontFamily: 'Nunito-Medium'),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(8.0),
                backgroundColor: const Color.fromARGB(255, 221, 0, 0),
                minimumSize: const Size.fromHeight(30),
                splashFactory: NoSplash.splashFactory,
                elevation: 0,
              ),
              icon: const Icon(
                Icons.cancel,
                color: Colors.white,
              ),
              onPressed: () {
                context.read<VerifikasiCubit>().editVerifikasi(
                      route: '/data_verifikasi',
                    );
                // return showDialog(
                //     context: context,
                //     barrierDismissible: false,
                //     builder: (BuildContext context) {
                //       return AlertDialog(
                //         title: const Text(
                //           'Data Verifikasi Anda Ditolak',
                //           style: TextStyle(fontWeight: FontWeight.bold),
                //         ),
                //         content: SingleChildScrollView(
                //             child: ListBody(
                //           children: <Widget>[
                //             Text(
                //               "Data anda ditolak karena tidak memenuhi syarat, silahkan lakukan verifikasi data sekali lagi. \n\nKeterangan : ${globals.keteranganverifikasi.toLowerCase()}",
                //             ),
                //           ],
                //         )),
                //         actions: <Widget>[
                //           TextButton(
                //             onPressed: () {
                //               Navigator.pop(context, 'OK');
                //             },
                //             child: const Text('OK'),
                //           ),
                //           TextButton(
                //               onPressed: () async {
                //                 Navigator.pop(context, 'Verifikasi Ulang');
                //                 Navigator.push(
                //                     context,
                //                     MaterialPageRoute(
                //                         builder: (context) => DataVerifikasi(
                //                               npwpPath:
                //                                   widget.selectednpwpPath,
                //                               ktpPath: widget.selectedktpPath,
                //                               user_id: widget.selecteduserid,
                //                               nik: widget.selectednik,
                //                               nama: widget.selectednama,
                //                               alamatdetail:
                //                                   widget.selectedalamatdetail,
                //                               tglLahir:
                //                                   widget.selectedtglLahir,
                //                               npwp: widget.selectednpwp,
                //                               isEdit: true,
                //                             )));
                //               },
                //               child: const Text('Verifikasi Ulang')),
                //         ],
                //       );
                //     });
              },
            ),
          ),
        ],
      ],
    );
  }

  Widget dataIdentitas() {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
          child: Image.file(
            File(sessionManager.getKtpPath()!),
            fit: BoxFit.contain,
            width: 170,
            height: 170,
          ),
        ),
        ListTile(
          title: const Text(
            'NIK',
            style: TextStyle(
              color: Color(0xFF777777),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            '${sessionManager.getActiveNik()}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF313131),
            ),
          ),
        ),
        const Divider(
          color: Color(0xFF999999),
          thickness: 2.0,
          indent: 15.0,
          endIndent: 15.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
          child: Image.file(
            File(sessionManager.getNpwpPath()!),
            fit: BoxFit.contain,
            width: 170,
            height: 170,
          ),
        ),
        ListTile(
          title: const Text(
            'NPWP',
            style: TextStyle(
              color: Color(0xFF777777),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            '${sessionManager.getActiveNpwp()}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF313131),
            ),
          ),
        ),
        const Divider(
          color: Color(0xFF999999),
          thickness: 2.0,
          indent: 15.0,
          endIndent: 15.0,
        ),
      ],
    );
  }
}

class Settings extends StatefulWidget {
  // final File selectednpwpPath;
  // final File selectedktpPath;
  // final String selectednik;
  // final String selectedalamatdetail;
  // final String selectednama;
  // final String selectedtglLahir;
  // final String selectednpwp;
  // final int selecteduserid;

  const Settings({
    Key? key,
    // this.selectednpwpPath,
    // this.selectedktpPath,
    // this.selectednik,
    // this.selectedalamatdetail,
    // this.selectednama,
    // this.selectedtglLahir,
    // this.selectednpwp,
    // this.selecteduserid,
  }) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  // final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Size? size;
  double? height;
  double? width;

  final components = Tools();

  SessionManager sessionManager = SessionManager();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size!.height;
    width = size!.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: SizedBox(
        height: height,
        width: width,
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Pengaturan",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Nunito-ExtraBold',
                ),
              ),
            ),
            ListTile(
                title: const Text(
                  'Hubungi Kami',
                  style: TextStyle(
                    color: Color(0xFF313131),
                    fontSize: 20,
                    fontFamily: 'Nunito-Medium',
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFF313131),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/hubungi_kami');
                }),
            ListTile(
              title: const Text(
                'Syarat dan Ketentuan',
                style: TextStyle(
                  color: Color(0xFF313131),
                  fontSize: 20,
                  fontFamily: 'Nunito-Medium',
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Color(0xFF313131),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/syaratdanketentuan');
              },
            ),
            ListTile(
              title: const Text(
                'Bantuan',
                style: TextStyle(
                  color: Color(0xFF313131),
                  fontSize: 20,
                  fontFamily: 'Nunito-Medium',
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Color(0xFF313131),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/faq');
              },
            ),
            ListTile(
              title: const Text(
                'Favorit',
                style: TextStyle(
                  color: Color(0xFF313131),
                  fontSize: 20,
                  fontFamily: 'Nunito-Medium',
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Color(0xFF313131),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/favoritesList');
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => FavoritesList(param: 'List')));
                // Navigator.pushNamed(
                //   context,
                //   '/favoritesList',
                //   arguments: FavoritesList(param: 'List'),
                // );
              },
            ),
            const SizedBox(height: 20.0),
            if (sessionManager.getActiveId() == null) ...[
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const ListTile(
                  title: Text(
                    'Login',
                    style: TextStyle(
                      color: Color(0xFF5599E9),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Nunito-Medium',
                    ),
                  ),
                  leading: Icon(
                    Icons.login_outlined,
                    color: Color(0xFF5599E9),
                  ),
                ),
              ),
            ] else ...[
              InkWell(
                onTap: () {
                  components.bottomDialog(
                      context,
                      'Apakah anda yakin? kamu tidak mengembalikan tindakan ini',
                      'Logout', [
                    IconsButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      text: 'Cancel',
                      iconData: Icons.cancel_outlined,
                      color: const Color.fromARGB(255, 230, 230, 230),
                      textStyle: const TextStyle(color: Colors.grey),
                      iconColor: Colors.grey,
                    ),
                    IconsButton(
                      onPressed: () async {
                        sessionManager.signout();
                        components.showDia();
                        // globals.pusher.disconnect();
                        Future.delayed(const Duration(seconds: 3), () {
                          components.dia!.hide();
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/home', (route) => false);
                        });
                      },
                      text: 'Logout',
                      iconData: Icons.logout,
                      color: Colors.red,
                      textStyle: const TextStyle(color: Colors.white),
                      iconColor: Colors.white,
                    ),
                  ]);
                },
                child: const ListTile(
                  title: Text(
                    'Logout',
                    style: TextStyle(
                      color: Color(0xFFE95555),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Nunito-Medium',
                    ),
                  ),
                  leading: Icon(
                    Icons.logout_outlined,
                    color: Color(0xFFE95555),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// // class Skeleton extends StatelessWidget {
// //   const Skeleton({
// //     Key key,
// //     this.height,
// //     this.width,
// //   }) : super(key: key);

// //   final double height, width;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       height: height,
// //       width: width,
// //       // padding: EdgeInsets.all(8.0),
// //       decoration: BoxDecoration(
// //         color: Color(0xFF313131).withOpacity(0.04),
// //       ),
// //     );
// //   }
// // }
